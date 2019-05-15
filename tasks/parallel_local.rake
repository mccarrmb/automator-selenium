desc 'Executes tests in parallel against Chrome'
Rake::TestTask.new(:chrome_parallel) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/clients/chrome_parallel]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests in parallel against Firefox'
Rake::TestTask.new(:firefox_parallel) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/clients/firefox_parallel]
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Executes tests in parallel against Edge'
Rake::TestTask.new(:edge_parallel) do |t|
  t.warning = false
  t.libs = %w[lib test pages test/clients/edge_parallel]
  t.test_files = FileList['test/**/*_test.rb']
end
