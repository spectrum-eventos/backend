# frozen_string_literal: true

Devise.setup do |config|
  # Using rails-api, tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  config.navigational_formats = [:json]

  config.mailer = CustomDeviseMailer

  config.mailer_sender = "Spectrum <#{ENV['EMAIL_FROM']}>"

  config.send_password_change_notification = true

  config.password_length = 8..128

  if ENV['SECRET_KEY_BASE']
    config.secret_key = ENV['SECRET_KEY_BASE']
  else
    throw 'Could not configure devise, missing environment key SECRET_KEY_BASE'
  end
end
