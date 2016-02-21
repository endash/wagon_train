lib = "#{File.expand_path(File.dirname(__FILE__))}/lib"
$LOAD_PATH << lib unless $LOAD_PATH.include?(lib)

require 'rake'
require 'rake/testtask'
require 'wagon_train'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*test.rb']
  t.verbose = true
end
