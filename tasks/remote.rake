desc 'Executes tests against Selenium Grid pool'
Rake::TestTask.new(:remote) do |t|
  t.warning = false
  t.libs = %w[lib tests pages clients/remote]
  t.test_files = FileList['tests/**/*_test.rb']
end
