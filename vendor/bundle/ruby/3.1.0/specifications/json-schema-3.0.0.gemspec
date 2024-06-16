# -*- encoding: utf-8 -*-
# stub: json-schema 3.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "json-schema".freeze
  s.version = "3.0.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 2.5".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kenny Hoxworth".freeze, "Vox Pupuli".freeze]
  s.date = "2022-05-03"
  s.email = "voxpupuli@groups.io".freeze
  s.extra_rdoc_files = ["README.md".freeze, "LICENSE.md".freeze]
  s.files = ["LICENSE.md".freeze, "README.md".freeze]
  s.homepage = "http://github.com/voxpupuli/json-schema/".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5".freeze)
  s.rubygems_version = "3.3.7".freeze
  s.summary = "Ruby JSON Schema Validator".freeze

  s.installed_by_version = "3.5.13".freeze if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<rake>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<addressable>.freeze, [">= 2.8".freeze])
end
