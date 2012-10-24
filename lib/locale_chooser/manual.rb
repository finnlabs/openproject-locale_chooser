module LocaleChooser
  module Manual
    def self.included(base)
      base.class_eval do
        helper :locales

        def set_localization_with_session
          set_localization_without_session
          set_language_if_valid(session[:locale])
        end
        alias_method_chain :set_localization, :session

      end
    end
  end
end
