# -*- encoding: utf-8 -*-
# stub: exception_notification 4.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "exception_notification"
  s.version = "4.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.8.11") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jamis Buck", "Josh Peek"]
  s.date = "2016-01-07"
  s.email = "smartinez87@gmail.com"
  s.homepage = "http://smartinez87.github.com/exception_notification"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.4.8"
  s.summary = "Exception notification for Rails apps"

  s.installed_by_version = "2.4.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionmailer>, ["~> 4.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_development_dependency(%q<rails>, ["~> 4.0"])
      s.add_development_dependency(%q<resque>, ["~> 1.2.0"])
      s.add_development_dependency(%q<sidekiq>, ["< 3.2.2", "~> 3.0.0"])
      s.add_development_dependency(%q<tinder>, ["~> 1.8"])
      s.add_development_dependency(%q<httparty>, ["~> 0.10.2"])
      s.add_development_dependency(%q<mocha>, [">= 0.13.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 1.3.4"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.8.2"])
      s.add_development_dependency(%q<appraisal>, ["~> 1.0.0"])
      s.add_development_dependency(%q<hipchat>, [">= 1.0.0"])
      s.add_development_dependency(%q<carrier-pigeon>, [">= 0.7.0"])
      s.add_development_dependency(%q<slack-notifier>, [">= 1.0.0"])
    else
      s.add_dependency(%q<actionmailer>, ["~> 4.0"])
      s.add_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_dependency(%q<rails>, ["~> 4.0"])
      s.add_dependency(%q<resque>, ["~> 1.2.0"])
      s.add_dependency(%q<sidekiq>, ["< 3.2.2", "~> 3.0.0"])
      s.add_dependency(%q<tinder>, ["~> 1.8"])
      s.add_dependency(%q<httparty>, ["~> 0.10.2"])
      s.add_dependency(%q<mocha>, [">= 0.13.0"])
      s.add_dependency(%q<sqlite3>, [">= 1.3.4"])
      s.add_dependency(%q<coveralls>, ["~> 0.8.2"])
      s.add_dependency(%q<appraisal>, ["~> 1.0.0"])
      s.add_dependency(%q<hipchat>, [">= 1.0.0"])
      s.add_dependency(%q<carrier-pigeon>, [">= 0.7.0"])
      s.add_dependency(%q<slack-notifier>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<actionmailer>, ["~> 4.0"])
    s.add_dependency(%q<activesupport>, ["~> 4.0"])
    s.add_dependency(%q<rails>, ["~> 4.0"])
    s.add_dependency(%q<resque>, ["~> 1.2.0"])
    s.add_dependency(%q<sidekiq>, ["< 3.2.2", "~> 3.0.0"])
    s.add_dependency(%q<tinder>, ["~> 1.8"])
    s.add_dependency(%q<httparty>, ["~> 0.10.2"])
    s.add_dependency(%q<mocha>, [">= 0.13.0"])
    s.add_dependency(%q<sqlite3>, [">= 1.3.4"])
    s.add_dependency(%q<coveralls>, ["~> 0.8.2"])
    s.add_dependency(%q<appraisal>, ["~> 1.0.0"])
    s.add_dependency(%q<hipchat>, [">= 1.0.0"])
    s.add_dependency(%q<carrier-pigeon>, [">= 0.7.0"])
    s.add_dependency(%q<slack-notifier>, [">= 1.0.0"])
  end
end
