##  encoding: utf-8 --
#lib = File.expand_path('../lib', _FILE_)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'rspec_manual_order'
  spec.version = '0.0.1'
  spec.authors = ['Austin Putman']
  spec.email = ['austin@omadahealth.com']
  spec.description = %q{Rspec Manual Ordering Tool}
  spec.summary = %q{Rspec Manual Ordering Tool}
  spec.homepage = 'https://github.com/omadahealth/rspec_manual_order'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.1.0'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10'
  spec.add_development_dependency 'rspec', '~> 2.14'
end
