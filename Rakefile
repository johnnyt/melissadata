bundler_installed = !!(%x[gem list] =~ /^bundler/) && File.exists?('Gemfile.lock')

desc "Setup the local environment"
task :setup do
  sh %Q!gem install bundler --pre --no-ri --no-rdoc! unless bundler_installed
  output = `bundle check 2>&1`
  if $?.to_i == 0
    puts "Bundler is up to date."
  else
    sh "bundle install"
  end

  unless %x[bundle exec vagrant box list] =~ /lucid64$/
    sh "bundle exec vagrant box add lucid64 http://files.vagrantup.com/lucid64.box"
  end

  sh "bundle exec vagrant up"
end

if bundler_installed
  desc "SSH into the Vagrant VM"
  task :ssh do
    sh "bundle exec vagrant ssh"
  end

  task :console => 'md:console'

  namespace :md do
    desc "Open a MelissaData console (IRB session)"
    task :console do
      sh "bundle exec irb -r./lib/md"
    end

    desc "Install MelissaData onto the Vagrant VM"
    task :install do
      sh "bundle exec rake build"
      sh "bundle exec vagrant md install"
    end

    desc "Update the MelissaData gem on the Vagrant VM"
    task :update do
      sh "bundle exec rake build"
      sh "bundle exec vagrant md update"
    end
  end

  require 'bundler'
  Bundler::GemHelper.install_tasks

  if defined?(RSpec)
    require 'rspec/core/rake_task'

    task :default => [:spec]
    task :test => [:spec]

    desc "Run specs"
    RSpec::Core::RakeTask.new('spec') do |t|
      t.rspec_opts = ['--backtrace', '--format', 'documentation']
      t.pattern = 'spec/**/*_spec.rb'
    end

    if RUBY_VERSION !~ /^1\.9/
      namespace :spec do
        desc "Run specs with RCov"
        RSpec::Core::RakeTask.new('rcov') do |t|
          t.pattern = 'spec/**/*_spec.rb'
          t.rspec_opts = ['--backtrace', '--format', 'documentation']
          t.rcov = true
          # t.rcov_opts = ['--exclude', 'some/path']
        end
      end
    end
  end
end
