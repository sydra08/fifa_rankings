# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fifa_rankings/version'

Gem::Specification.new do |spec|
  spec.name          = 'fifa_rankings'
  spec.version       = FifaRankings::VERSION
  spec.authors       = 'Sydney Chun'
  spec.email         = 'schun08@gmail.com'

  spec.summary       = "Lists FIFA World Rankings for the top 20 Women's teams."
  spec.description   = "Using data from Wikipedia, lists the top 20 FIFA teams and allows you to learn more information about each team."
  spec.homepage      = 'https://github.com/sydra08/fifa_rankings'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org/'
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.require_paths = ['lib']
  spec.executables << 'fifa-rankings'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.4"
  spec.add_dependency "nokogiri", "~> 1.7", ">= 1.7"
end
