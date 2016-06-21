Gem::Specification.new do |spec|
  spec.name          = "cheesy-common"
  spec.authors       = ["Patrick Fairbank"]
  spec.email         = ["pat@patfairbank.com"]
  spec.summary       = "Contains configuration and authentication code common to all Team 254 Ruby webapps."
  spec.homepage      = "https://github.com/Team254/cheesy-ruby-common"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.version       = "0.0.1"

  spec.add_dependency "aescrypt", "~> 1.0"
  spec.add_dependency "httparty", "~> 0.13"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
