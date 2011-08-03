# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'melissa-data/version'

Gem::Specification.new do |s|
  s.name = 'melissa-data'
  s.version = MelissaData::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['JohnnyT', 'Chris Wyckoff']
  s.email = ['johnnyt@xan.do', 'cwyckoff@alliancehealth.com']
  s.homepage = 'http://github.com/johnnyt/melissa-data'
  s.summary = 'Ruby wrappers around MelissaData objects'
  s.description = s.summary
  s.require_paths = %w[ lib ]
  s.files = Dir["**/*"].map{ |f| f.to_s }
  s.executables   = Dir['bin/*'].map{ |f| File.basename(f) }

  s.add_development_dependency 'rake', '0.8.7'
  s.add_development_dependency 'rspec', '>2.0'

  s.add_dependency 'i18n'
  s.add_dependency 'thor'
  s.add_dependency 'activesupport'
  s.add_dependency 'multi_json'
  s.add_dependency 'msgpack-rpc'
  s.add_dependency 'awesome_print'
  s.add_dependency 'yajl-ruby'
end
