task default: ['search_test']

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

desc 'Executes internet searches using the Google.com GUI'
task :search_test do
  ruby 'tests/test_search.rb'
end
