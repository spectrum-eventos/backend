# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "SPECTRUM <#{ENV['EMAIL_FROM']}>"
  layout 'mailer'
end
