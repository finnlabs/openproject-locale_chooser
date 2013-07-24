module OpenProject
  module LocaleChooser
    module Manual
      def self.included(base)
        base.class_eval do
          def set_manual_locale(locale)
            session[:locale] = locale if Setting.available_languages.include?(locale)
          end
        end

        def manual_locale
          session[:locale]
        end
      end
    end
  end
end
