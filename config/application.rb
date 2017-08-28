require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'rack-cas/session_store/active_record'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ManifesteSe
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]

    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["pt-BR"]
    config.i18n.default_locale = :'pt-BR'

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    config.generators do |g|
      g.fixture_replacement :machinist
    end

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    config.assets.initialize_on_precompile = false

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.sass.preferred_syntax = :sass

    # CAS configuration
    config.rack_cas.server_url = ENV["CAS_SERVER_URL"]
    config.rack_cas.session_store = RackCAS::ActiveRecordStore

    # config.quiet_assets = false

    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"

    config.exceptions_app = self.routes

    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301      '/campaigns/966',   'http://www.escolainclusiva.meurio.org.br'
      r301      '/campaigns/969',   'https://www.licencaparamatar.meurio.org.br/'
    end
  end
end
