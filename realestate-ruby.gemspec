Gem::Specification.new do |gem|
  gem.add_dependency 'rake'
  gem.add_dependency 'activesupport', ['>= 2.3.9', '< 4']
  gem.add_dependency 'httparty'

  gem.add_development_dependency 'test-unit'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'webmock'

  gem.authors = ["Nik Wakelin", "Jared Armstrong", "Glen Barnes"]
  gem.description = %q{A Ruby wrapper for the Realestate.co.nz API.}
  gem.summary = "Ruby Realestate.co.nz API Client"
  gem.email = ['nik@200square.co.nz', 'jared@200square.co.nz', 'barnaclebarnes@gmail.com']
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/realestateconz/realestate-api-ruby-client'
  gem.name = 'realestate-ruby'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = '0.1.0'
end