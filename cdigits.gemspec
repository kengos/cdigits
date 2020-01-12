# frozen_string_literal: true

require_relative 'lib/cdigits/version'

Gem::Specification.new do |spec|
  spec.name          = 'cdigits'
  spec.version       = Cdigits::VERSION
  spec.authors       = ['kengos']
  spec.email         = ['kengo@kengos.jp']

  spec.summary       = 'Generate code with Luhn mod N algorithm using placeholder.'
  spec.description   = [
    'Generate code with Luhn mod N algorithm using placeholder.',
    'e.g)',
    "Cdigits::Luhn.number('CA##-####-####-###?') #=> 'CA63-6485-2316-2675'",
    "Cdigits::Luhn.easy #=> '16TPF8RETL'"
  ].join("\n")
  spec.homepage      = 'https://github.com/kengos/cdigits'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '>= 12.0'
  spec.add_development_dependency 'rspec', '>= 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'yard'
end
