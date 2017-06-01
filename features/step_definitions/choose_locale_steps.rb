When /^I switch the locale to "(.+)"$/ do |locale|
  steps %Q{When I press "#{locale}" within ".locales_chooser"}
end
