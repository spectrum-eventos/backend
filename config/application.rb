# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'active_storage/engine'
# require 'action_cable/engine'
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WhiteLabel
  class Application < Rails::Application
    config.app_generators.scaffold_controller :responders_controller
    config.autoload_paths += [Rails.root.join('lib')]
    config.eager_load_paths += [Rails.root.join('lib')]

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.action_mailer.preview_path = Rails.root.join('app', 'mailers', 'previews')

    config.api_only = true

    config.time_zone = 'America/Sao_Paulo'
    config.i18n.default_locale = :"pt-BR"
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.action_controller.include_all_helpers = false

    config.active_job.queue_adapter = :sidekiq
  end
end
