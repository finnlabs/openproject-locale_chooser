module OpenProject
  module LocaleChooser
    module ControllerPatch
      def self.included(base)
        base.class_eval do
          helper :locales

          include Manual
          prepend InstanceMethods
        end
      end

      module InstanceMethods
        def set_localization
          super
          set_language_if_valid(manual_locale) if manual_locale
        end
      end
    end
  end
end
