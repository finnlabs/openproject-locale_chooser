When /^I switch the locale to "(.+)"$/ do |locale|
  steps %(When I press "#{locale}" within ".locales_chooser")
end
