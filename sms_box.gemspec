# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_box/version'

Gem::Specification.new do |gem|
  gem.name          = "sms_box"
  gem.version       = SMSBox::VERSION
  gem.authors       = ["Sebastian de Castelberg"]
  gem.email         = ["developers@screenconcept.ch"]
  gem.description   = %q{Ruby API client for the MNC smsBox® v6.4 -- HTTP XML API}
  gem.summary       = %q{smsBox® HTTP XML API ruby client}
  gem.homepage      = "http://github.com/screenconcept/sms_box"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'nokogiri'
  gem.add_dependency 'rest-client'
  gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'awesome_print'
end
