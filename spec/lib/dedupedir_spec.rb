require 'ftools'
require 'fileutils'
require File.dirname(__FILE__) + '/../../lib/dedupedir'
describe "dedupedir.rb" do

  before(:all) do
    @test_dir = File.dirname(__FILE__) + '/../../tmp'

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

  before(:each) do
    FileUtils.mkdir_p @test_dir
  end

  after(:each) do
    FileUtils.rm_rf @test_dir
  end

  it "opens the expected directory" do
    Dir.should_receive(:foreach).with(@test_dir).and_return([])
    run_script
  end

  it "returns total bytes and files deleted" do
    f1 = build_test_file('xab.mp3'  ) {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 9.mp3') {|f| f.write('qqqqq') }
    f3 = build_test_file('xab 5.mp3') {|f| f.write('qqqqq') }
    run_script.should == { :size => 10, :number => 2 }
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


  it "does not delete when the files are in different directories" do
    f1 = build_test_file('xab.mp3'  ,'test2') {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.mp3','test1') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

  it "does not delete when the files have different content" do
    f1 = build_test_file('xab.mp3'  ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.mp3','test1') {|f| f.write('11111') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

  it "does not delete when the files have different length" do
    f1 = build_test_file('xab.mp3'  ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.mp3','test1') {|f| f.write('qqqqqqqqqqq') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

  it "does not delete when the file names differ by something other than a numeric suffix" do
    f1 = build_test_file('xab.mp3'   ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('xabkkk.mp3','test1') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

  it "does not delete when the files do not share a prefix" do
    f1 = build_test_file('xab.mp3'    ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('hgghh 2.mp3','test1') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

  it "does not delete when the files do not have identical file types" do
    f1 = build_test_file('xab.mp3'  ,'test1') {|f| f.write('qqqqq') }
    f2 = build_test_file('xab 2.txt','test1') {|f| f.write('qqqqq') }
    run_script
    File.should exist(f1)
    File.should exist(f2)
  end

end
