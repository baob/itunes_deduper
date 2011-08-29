# require 'aruba'
require 'aruba/cucumber'
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../..')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"


puts ENV['PATH'] 

#module ArubaOverrides
  #def detect_ruby_script(cmd)
    #if cmd =~ /^ruby dedupe/
      #"ruby -I../../lib -S ../../bin/#{cmd}"
    #else
      #super(cmd)
    #end
  #end
#end
