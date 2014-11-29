module LocalesHelper
  include OpenProject::LocaleChooser::Manual

  def locales_chooser
    # might cause duplicate loading of stylesheet if called more than once
    content_for :header_tags do
      [stylesheet_link_tag('locale_chooser/locale_chooser'),
       javascript_include_tag('locale_chooser/backup_input')].join('').html_safe
    end

    content_tag :div, class: 'locales_chooser' do
      form_tag my_locale_url, method: :put do
        Setting.available_languages.map do |l|
          submit_tag l, name: 'locale'
        end.join(' ').html_safe +
          hidden_field_tag(:back_url, request.url)
      end
    end
  end
end
