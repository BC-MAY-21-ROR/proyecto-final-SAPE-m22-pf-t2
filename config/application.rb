require_relative 'boot'

require 'rails/all'
require 'dotenv/load' if defined? Dotenv

if Rails.env != 'production'
  require 'dotenv'
  Dotenv.load('.env.docker') if Rails.env == 'docker'
end

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SAPEC
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoload_paths += %W[#{config.root}/lib]

    config.i18n.available_locales = %i[en es]
    config.i18n.default_locale = :en
    # config.i18n.fallbacks = true
  end
end
