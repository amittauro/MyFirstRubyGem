require_relative 'lib/cipherworld_amitjuly2020/version'

Gem::Specification.new do |spec|
  spec.name          = "cipherworld_amitjuly2020"
  spec.version       = CipherworldAmitjuly2020::VERSION
  spec.authors       = ["Amit Tauro"]
  spec.email         = ["tauroamit@gmail.com"]

  spec.summary       = %q{Encryption and decryption methods for text files.}
  spec.description   = %q{Provides methods to encrypt and decrypt text files through the command line.}
  spec.homepage      = "https://github.com/amittauro/MyFirstRubyGem"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/amittauro/MyFirstRubyGem"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
