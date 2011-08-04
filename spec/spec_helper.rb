require 'bundler'
Bundler.setup

if RUBY_VERSION =~ /^1\.9/
  require 'simplecov'
  SimpleCov.start
else
  require 'rspec'
  require 'rcov'
end

# # Add this folder to the load path for "spec_helper"
# $:.unshift(File.dirname(__FILE__))

require 'melissadata'

MelissaData.env = :test

# Try to load ruby debug since its useful if it is available.
# But not a big deal if its not available (probably on a non-MRI
# platform)
begin
  require 'ruby-debug'
rescue LoadError
end

# Add the I18n locale for tests
I18n.load_path << File.expand_path("../locales/en.yml", __FILE__)

RSpec.configure do |c|
  # Some opts are set in Guardfile
  c.color_enabled = true
end
