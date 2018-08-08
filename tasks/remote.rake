desc 'Executes tests against Selenium Grid pool'
Rake::TestTask.new(:remote) do |t|
  t.warning = false
  t.libs = %w[lib test test/remote]
  t.test_files = FileList['test/**/*_test.rb']
end
