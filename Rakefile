require 'rake/testtask'
require 'rubocop/rake_task'

desc 'Start a console session with Selenium loaded'
task :console do
  require 'irb'
  require 'irb/completion'
  require 'selenium-webdriver'
  require 'page-object'
  require 'page-object/page_factory'
  ARGV.clear
  IRB.start
end

desc 'Calls out awful code'
RuboCop::RakeTask.new do |t|
  t.fail_on_error = false
end

desc 'Executes internet searches using the Google.com GUI'
Rake::TestTask.new(:test) do |t|
  t.warning = false
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Chrome'
Rake::TestTask.new(:chrome) do |t|
  t.warning = false
  t.libs = %w[lib test/chrome]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Firefox'
Rake::TestTask.new(:firefox) do |t|
  t.warning = false
  t.libs = %w[lib test/firefox]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against Safari'
Rake::TestTask.new(:safari) do |t|
  t.warning = false
  t.libs = %w[lib test/safari]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests against all macOS browsers in parallel'
multitask macos: %w[macos_chrome macos_firefox macos_safari]

task default: ['test']
