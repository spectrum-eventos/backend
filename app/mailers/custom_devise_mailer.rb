# frozen_string_literal: true

class CustomDeviseMailer < ::Devise::Mailer
  include Devise::Controllers::UrlHelpers

  layout 'layouts/mailer'
  default template_path: "mailers/#{name.underscore}"

  def reset_password_instructions(params, token, opts = {})
    custom_devise_mail(params, opts, __method__) do |record, options|
      super(record, token, options)
    end
  end

  def password_change(params, opts = {})
    custom_devise_mail(params, opts, __method__) do |record, options|
      super(record, options)
    end
  end

  # Confirmable not supported for admins
  # def confirmation_instructions(params, token, opts = {})
  #   custom_devise_mail(params, opts) do |record, options|
  #     super(record, token, options)
  #   end
  # end

  private

  def custom_devise_mail(params, opts, method)
    klass = params.class.name.constantize
    record = klass.find(params[:id])
    opts[:template_path] = self.class.default_params[:template_path]
    mail = yield record, opts if block_given?
    mail.subject = I18n.t("mailers.subjects.#{method}")
  end
end
