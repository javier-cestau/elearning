require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ElearningP
  class Application < Rails::Application
      config.exceptions_app = self.routes
      config.i18n.default_locale = :es
      WeekOfMonth.configuration.monday_active = true
      config.time_zone = "Caracas"
      config.autoload_paths += %W(#{config.root}/lib)
      config.assets.initialize_on_precompile = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.after_initialize do
     ReproveCourseJob.perform_later
    end
  end
end
