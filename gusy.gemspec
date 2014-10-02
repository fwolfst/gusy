# -*- encoding: utf-8 -*-
require File.expand_path('../lib/gusy/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Felix Wolfsteller"]
  gem.email         = ["felix.wolfsteller@gmail.com"]
  gem.description   = %q{Sieben Linden Guest System}
  gem.summary       = %q{Padrino app as seminar and guest frontend.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "gusy"
  gem.require_paths = ["lib", "app"]
  gem.version       = Gusy::VERSION

  gem.add_dependency "padrino-core"

  #gem.add_development_dependency 'factory_girl'
end
