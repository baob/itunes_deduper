require 'ftools'
require 'fileutils'
require File.dirname(__FILE__) + '/../../lib/dedupedir'
describe "dedupedir.rb" do

  before(:all) do
    @test_dir = File.dirname(__FILE__) + '/../../tmp'
    FileUtils.mkdir_p @test_dir

    def run_script
      Dedupedir.one_dir(@test_dir)
    end

    def build_test_file(name,path='')
      FileUtils.mkdir_p File.join(@test_dir,path) if  path
      full_name = File.join(@test_dir,path,name)
      File.open(full_name, 'w') {|f| yield f }
      full_name
    end
  end

  after(:all) do
    FileUtils.rm_rf @test_dir
  end

  it "opens the expected directory" do
    Dir.should_receive(:foreach).with(@test_dir).and_return([])
    run_script
  end

  it "deletes the highest numbered of two otherwise identical files" do
    f1 = build_test_file('xab.mp3'  ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.mp3','test1') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should_not exist(f2)
  end

  it "deletes the highest numbered of two otherwise identical files in the root dir" do
    f1 = build_test_file('xab.mp3'  ) {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.mp3') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should_not exist(f2)
  end

  it "deletes the highest numbered of three otherwise identical files" do
    f1 = build_test_file('xab.mp3'  ) {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 9.mp3') {|f| f.write('qqqqq') }
    f3 = build_test_file('xab 5.mp3') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should_not exist(f2)
    File.should_not exist(f3)
  end
end
