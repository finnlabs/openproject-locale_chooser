module OpenProject::LocaleChooser
  class Engine < ::Rails::Engine
    engine_name :openproject_locale_chooser


    config.autoload_paths += Dir["#{config.root}/lib/"]

    spec = Bundler.environment.specs['openproject-locale_chooser'][0]
    initializer 'locale_chooser.register_plugin' do
      Redmine::Plugin.register :openproject_locale_chooser do

        name 'OpenProject Locale Chooser'
        author ((spec.authors.kind_of? Array) ? spec.authors[0] : spec.authors)
        author_url spec.homepage
        description spec.description
        version spec.version
        url 'https://www.openproject.org/projects/locale-chooser'

        requires_openproject ">= 4.0.0"
      end
    end

    initializer 'locale_chooser.precompile_assets' do
      Rails.application.config.assets.precompile += %w(locale_chooser/locale_chooser.css
        locale_chooser/backup_input.js)
    end

    initializer 'locale_chooser.register_test_paths' do |app|
      app.config.plugins_to_test_paths << self.root
    end

    config.before_configuration do |app|
      # This is required for the routes to be loaded first
      # as the routes should be prepended so they take precedence over the core.
      app.config.paths['config/routes'].unshift File.join(File.dirname(__FILE__), "..", "..", "..", "config", "routes.rb")
    end

    initializer "remove_duplicate_locale_chooser_routes", after: "add_routing_paths" do |app|
      # removes duplicate entry from app.routes_reloader
      # As we prepend the plugin's routes to the load_path up front and rails
      # adds all engines' config/routes.rb later, we have double loaded the routes
      # This is not harmful as such but leads to duplicate routes which decreases performance
      app.routes_reloader.paths.uniq!
    end
  end
end
