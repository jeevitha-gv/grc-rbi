# -*- encoding: utf-8 -*-
# stub: public_activity 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "public_activity"
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Piotrek Oko\u{144}ski", "Kuba Oko\u{144}ski"]
  s.date = "2016-03-19"
  s.description = "Easy activity tracking for your ActiveRecord models. Provides Activity model with details about actions performed by your users, like adding comments, responding etc."
  s.email = "piotrek@okonski.org"
  s.homepage = "https://github.com/pokonski/public_activity"
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.4.8"
  s.summary = "Easy activity tracking for ActiveRecord models"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<railties>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0"])
      s.add_development_dependency(%q<sqlite3>, ["~> 1.3.7"])
      s.add_development_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.7.0"])
      s.add_development_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<yard>, ["~> 0.8"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<actionpack>, [">= 3.0.0"])
      s.add_dependency(%q<railties>, [">= 3.0.0"])
      s.add_dependency(%q<i18n>, [">= 0.5.0"])
      s.add_dependency(%q<activerecord>, [">= 3.0"])
      s.add_dependency(%q<sqlite3>, ["~> 1.3.7"])
      s.add_dependency(%q<mocha>, ["~> 0.13.0"])
      s.add_dependency(%q<simplecov>, ["~> 0.7.0"])
      s.add_dependency(%q<minitest>, ["~> 4.7.5"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<yard>, ["~> 0.8"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 3.0.0"])
    s.add_dependency(%q<railties>, [">= 3.0.0"])
    s.add_dependency(%q<i18n>, [">= 0.5.0"])
    s.add_dependency(%q<activerecord>, [">= 3.0"])
    s.add_dependency(%q<sqlite3>, ["~> 1.3.7"])
    s.add_dependency(%q<mocha>, ["~> 0.13.0"])
    s.add_dependency(%q<simplecov>, ["~> 0.7.0"])
    s.add_dependency(%q<minitest>, ["~> 4.7.5"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<yard>, ["~> 0.8"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
