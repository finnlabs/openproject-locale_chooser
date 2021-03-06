$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "open_project/locale_chooser/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "openproject-locale_chooser"
  s.version = OpenProject::LocaleChooser::VERSION
  s.authors = ["OpenProject GmbH"]
  s.email = ["info@openproject.com"]
  s.homepage = "http://www.openproject.com/"
  s.summary = "OpenProject plugin providing language switching functionality for other plugins."
  s.description = "OpenProject plugin providing language switching functionality for other plugins."

  s.files = Dir["{app,config,db,lib}/**/*"] + [ "README.md" ]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "factory_girl_rails", "~> 4.0"
end
