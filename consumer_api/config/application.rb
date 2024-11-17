require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module ConsumerApi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = false
    config.active_job.queue_adapter = :sidekiq
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore, key: '_my_session_key'
  end
end
