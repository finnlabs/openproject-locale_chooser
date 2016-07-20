module OpenProject
  module LocaleChooser
    module ControllerPatch
      def self.included(base)
        base.class_eval do
          helper :locales

          include Manual

          def set_localization_with_session
            set_localization_without_session
            set_language_if_valid(manual_locale) if manual_locale
          end
          alias_method_chain :set_localization, :session

        end
      end
    end
  end
end
