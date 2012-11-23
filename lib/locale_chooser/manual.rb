module LocaleChooser
  module Manual
    def self.included(base)
      base.class_eval do
        helper :locales

        def set_localization_with_session
          set_localization_without_session
          set_language_if_valid(manual_locale) if manual_locale
        end
        alias_method_chain :set_localization, :session


        def set_manual_locale(locale)
          session[:locale] = locale if Setting.available_languages.include?(locale)
        end
      end
    end
  end
end
