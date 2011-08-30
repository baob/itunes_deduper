require 'ftools'
require 'pp'

module Deduper

  class Totaler
    
    def initialize
      @size  = 0
      @number = 0
    end

    def add(file)
      @size += file[:size]
      @number += 1
    end

    def totals
      {:number => @number, :size => @size}
    end
      
  end

  def self.dedupe(dir_name, totaler=Totaler.new)
    puts "START - #{dir_name}"

    files = []
    dirs = []

    Dir.foreach(dir_name) do |file_name|
      full_name = File.join(dir_name,file_name)
      if file_name.size > 2
        if File.file?(full_name)
          info = {}
          info[:name] = file_name
          info[:type] = file_name.split('.').last
          info[:base] = file_name.split('.')[0..-2].join('.')
          info[:fullname] = full_name
          info[:size] = File.size(full_name)
          files << info
        end
        if File.directory?(full_name)
          dirs << full_name
        end
      end
    end

    dirs.each do |dir|
      dedupe(dir, totaler)
    end


    dedupe_files(files, totaler)

  #  puts "need to de-dup #{files.size} files with sizes"
  #  files.each do |file_info|
  #    puts file_info.inspect
  #  end

    puts "END   - #{dir_name}"

    return totaler.totals

  end

  def self.dedupe_files(files, totaler)
  #  puts "de-duping #{files.size} files"
    return if files.size < 2
    sizes = files.map{ |file| file[:size] }
    return if sizes.size == sizes.uniq.size # return if all the file sizes are different

  #  check_sizes = (sizes - sizes.uniq).uniq

  #  puts "need to check files with sizes #{check_sizes}"

    files[0..-2].each_with_index do |file1,index1|
      files[index1+1..-1].each_with_index do |file2,index2|
  #      puts "comparing #{file1[:base]} with #{file2[:base]} "
        dedupe_pair(file1,file2, totaler)
      end
    end

  end

  def self.dedupe_pair(file1,file2, totaler)

    if file1[:base].size < file2[:base].size
      dedupe_ordered_pair(file1,file2, totaler)
    else
      dedupe_ordered_pair(file2,file1, totaler)
    end

  end

  def self.dedupe_ordered_pair(file1,file2,totaler)

  #  puts "dedupe_ordered_pair - comparing #{file1[:base]} with #{file2[:base]} "

  #  puts "about to test for name length"

    return if file1[:base].size >= file2[:base].size

  #  puts "about to test for type"

    return unless file1[:type] == file2[:type]

  #  puts "about to test for size"

    return unless file1[:size] == file2[:size] # not neccessary for algorithmic correctness, but a shortcut for performance

  #  puts "dedupe_ordered_pair - comparing #{file1[:base]} with #{file2[:base]} - type and size identical"

  #  puts "about to test for prefix"

    file1_base_size = file1[:base].size
    return unless file1[:base] == file2[:base][0..file1_base_size-1]

  #  puts "about to test for numeric suffix"

    extra = file2[:base][file1_base_size..-1]
    return unless %w{ 1 2 3 4 5 6 7 8 9 }.include?(extra.strip)

  #  puts "about to test for actual content"

    puts " FINAL CHECK - for same file content - #{file1[:base]} with #{file2[:base]}"

    return unless File.exist?(file1[:fullname]) && File.exist?(file2[:fullname]) && File.compare(file1[:fullname],file2[:fullname])

  #  exit

    puts "\nDELETING #{file2[:name]} in favour of #{file1[:name]}\n"
      
    File.delete(file2[:fullname]) 

    totaler.add(file2)

  end

end
