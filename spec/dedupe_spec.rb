describe "dedupe.rb" do

  def run_script
    puts "about to run  #{@dedupe_script}"
    load @dedupe_script
  end

  before(:all) do
    @dedupe_script = File.dirname(__FILE__) + '/../dedupe.rb'
    @del_dir = File.expand_path(File.dirname(__FILE__) + '/..')
  end

  it "opens the expected directory" do
    Dir.should_receive(:foreach).with(@del_dir).and_return([])
    r = run_script
    puts "script returned #{r}"
  end
end
