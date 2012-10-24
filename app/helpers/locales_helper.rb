module LocalesHelper
  def locales_chooser
    # might cause duplicate loading of stylesheet if called more than once
    content_for :header_tags do
      [stylesheet_link_tag("locale_chooser", :plugin => "locale_chooser"),
       javascript_include_tag("backup_input", :plugin => "locale_chooser")].join("")
    end

    content_tag :div, :class => 'locales_chooser' do
      form_tag my_locale_url, :method => :put do
        Setting.available_languages.collect do |l|
          submit_tag l, :name => 'locale'
        end.join(" ") +
        hidden_field_tag(:back_url, request.request_uri)
      end
    end
  end
end
