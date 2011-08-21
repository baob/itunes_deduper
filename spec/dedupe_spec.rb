describe "dedupe.rb" do

  before(:all) do
    @dedupe_script = File.dirname(__FILE__) + '/../dedupe.rb'

    def run_script
      puts "about to run  #{@dedupe_script}"
      load @dedupe_script
    end
  end

  it "opens the expected directory" do
    Dir.should_receive(:foreach).with('C:\Users\suzie\Music\suzies music collection').and_return([])
    r = run_script
    puts "script returned #{r}"
  end
end
