Given /^a music file$/ do
  @music_file = "itunes/track_1_by_x.mp3"
  ensure_path_for @music_file
  Given "a file named \"#{@music_file}\" with:", "plinky-plonk"
end   

Given /^a music file in a deep sub directory$/ do
  @music_file = "itunes/aaa/bbb/ccc/ddd/eee/fff/track_1_by_x.mp3"
  ensure_path_for @music_file
  Given "a file named \"#{@music_file}\" with:", "plinky-plonk"
end

Given /^a music file in the root directory$/ do
  @music_file = "track_1_by_x.mp3"
  Given "a file named \"#{@music_file}\" with:", "plinky-plonk"
end

Given /^a copy of that named with a numeric suffix$/ do
  @other_file = add_numeric_suffix(@music_file)
  ensure_path_for @other_file
  Given "a file named \"#{@other_file}\" which is a copy of \"#{@music_file}\""
end

Given /^a copy of that named with a numeric suffix but with different content$/ do
  @other_file = add_numeric_suffix(@music_file)
  ensure_path_for @other_file
  Given "a file named \"#{@other_file}\" with:", "trinky-tronk"
end

Given /^a copy of that named with a numeric suffix but with different size$/ do
  @other_file = add_numeric_suffix(@music_file)
  ensure_path_for @other_file
  Given "a file named \"#{@other_file}\" with:", "trinky-tronk-boom"
end

Given /^a copy of that named with a non\-numeric suffix$/ do
  @other_file = add_suffix(@music_file,' X')
  ensure_path_for @other_file
  Given "a file named \"#{@other_file}\" which is a copy of \"#{@music_file}\""
end

Given /^a copy of that named with a numeric suffix in a subdirectory$/ do
  path_parts = @music_file.split('/')
  path = File.join(*(path_parts[0..-2]+['sub1']))
  @other_file = File.join(path,add_numeric_suffix(path_parts.last))
  in_current_dir { FileUtils.mkdir_p path }
  Given "a file named \"#{@other_file}\" which is a copy of \"#{@music_file}\""
end

Then /^the music file should exist$/ do
  puts "------- music file #{@music_file} -------"
  Then "a file named \"#{@music_file}\" should exist"
end

Then /^the other file should not exist$/ do
  puts "------- other file #{@other_file} -------"
  Then "a file named \"#{@other_file}\" should not exist"
end

Then /^the other file should exist$/ do
  puts "------- other file #{@other_file} -------"
  Then "a file named \"#{@other_file}\" should exist"
end

def add_suffix(file_name,suffix)
  parts = file_name.split('.')
  parts[0..-2].join('.') + [suffix,parts.last].join('.')
end

def add_numeric_suffix(file_name)
  add_suffix(file_name,' 2')
end

def ensure_path_for(file_name)
  path = file_name.split('/')[0..-2].join('/')
  in_current_dir { FileUtils.mkdir_p path } if path && !path.size == 0
end
