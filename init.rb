require 'redmine'

Redmine::Plugin.register :locale_chooser do
  name 'OpenProject Locale Chooser plugin'
  author 'Finn GmbH'
  description 'Provides language switching functionality for other plugins.'
  version '1.1.3'
  url 'git@github.com:finnlabs/locale_chooser.git'
  author_url 'https://finn.de/team'
end
