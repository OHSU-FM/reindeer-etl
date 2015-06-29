require "bundler/gem_tasks"
require 'rake/testtask'
Rake::TestTask.new do |t|
    t.libs << 'lib/reindeer_etl'
    t.libs << 'test'
    t.test_files = FileList[
        "test/*_test.rb",
        "test/lib/*_test.rb"
    ]
    t.verbose = true
end

task default: :test
