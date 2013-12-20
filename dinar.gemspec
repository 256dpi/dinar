# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dinar/version'

Gem::Specification.new do |spec|
  spec.name          = 'dinar'
  spec.version       = Dinar::VERSION
  spec.authors       = ['Joël Gähwiler']
  spec.email         = ['joel.gaehwiler@bluewin.ch']
  spec.description   = ''
  spec.summary       = ''
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'highline'
  spec.add_dependency 'hashdiff'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rails', '~> 4.0'
end
