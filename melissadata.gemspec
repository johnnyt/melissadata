# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'melissadata/version'

Gem::Specification.new do |s|
  s.name = 'melissadata'
  s.version = MelissaData::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['JohnnyT', 'Chris Wyckoff']
  s.email = ['johnnyt@xan.do', 'cwyckoff@alliancehealth.com']
  s.homepage = 'http://github.com/johnnyt/melissadata'
  s.summary = 'Ruby wrappers around MelissaData objects'
  s.description = s.summary
  s.require_paths = %w[ lib ]
  s.files = Dir["**/*"].map{ |f| f.to_s }
  s.executables   = Dir['bin/*'].map{ |f| File.basename(f) }

  s.add_development_dependency 'rake', '0.8.7'
  s.add_development_dependency 'rspec', '>2.4'
  # s.add_development_dependency 'rb-fsevent'
  s.add_development_dependency 'growl'
  s.add_development_dependency 'guard-rspec'

  if RUBY_VERSION =~ /1\.9/
    s.add_development_dependency 'ruby-debug19'
    s.add_development_dependency 'simplecov', '>= 0.4.0'#, :require => false, :group => :test
  else
    s.add_development_dependency 'ruby-debug'
    s.add_development_dependency 'rcov'
  end

  s.add_dependency 'i18n'
  s.add_dependency 'thor'
  s.add_dependency 'activesupport'
  s.add_dependency 'multi_json'
  s.add_dependency 'msgpack-rpc'
  s.add_dependency 'awesome_print'
  s.add_dependency 'yajl-ruby'
  s.add_dependency 'cloudfiles'
end
