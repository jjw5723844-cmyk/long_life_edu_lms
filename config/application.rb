require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LongLifeEduLms
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1
    config.time_zone = "Seoul"
    config.i18n.default_locale = :ko
    config.i18n.available_locales = [ :ko, :en ]
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
