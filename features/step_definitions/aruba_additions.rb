Then "the stdout should be empty" do
  all_stdout.should == ""
end

Then "the stderr should be empty" do
  all_stderr.should == ""
end

Then /^show me the files$/ do
    puts "------------------------------ find: START"
    puts `find . -type f`
    puts "------------------------------ find: END"
end

Then /^show me the stdout$/ do
    puts "------------------------------ stdout: START"
    puts all_stdout
    puts "------------------------------ stdout: END"
end

Given /^a file named "([^"]*)" which is a copy of "([^"]*)"$/ do |file2, file1|
  in_current_dir do
    FileUtils.cp file1, file2
  end
  And "a file named \"#{file2}\" should exist"
end

