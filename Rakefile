require 'rake'
require 'rake/testtask'

desc "Run all tests"
task :test do
  unless ENV.has_key? 'WHATCD_USERNAME'
  	print 'Username: '
  	ENV['WHATCD_USERNAME'] = STDIN.gets.chomp
  end

  unless ENV.has_key? 'WHATCD_PASSWORD'
  	print 'Password: '
  	ENV['WHATCD_PASSWORD'] = STDIN.gets.chomp
  end

  Rake::TestTask.new do |t|
    t.libs << "test"
    t.pattern = "test/**/*_test.rb"
    t.verbose = false
  end
end

task :default => :test
