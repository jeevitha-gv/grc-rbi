# -*- encoding: utf-8 -*-
# stub: protokoll 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "protokoll"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Celso Dantas"]
  s.date = "2016-04-28"
  s.description = "Rails 4 gem to enable creation of a custom autoincrement Time based string on a model defined by a pattern. ex. 20110001, 20110002, 20110003, 20120001, 20120002..."
  s.email = ["celsodantas@gmail.com"]
  s.homepage = "https://github.com/celsodantas/protokoll"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "A simple Rails gem to create custom autoincrement Time base values to a database column"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 4.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1"])
    else
      s.add_dependency(%q<rails>, [">= 4.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1"])
    end
  else
    s.add_dependency(%q<rails>, [">= 4.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1"])
  end
end
