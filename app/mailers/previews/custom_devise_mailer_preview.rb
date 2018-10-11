# frozen_string_literal: true

class CustomDeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions_admin
    CustomDeviseMailer.reset_password_instructions(params(admin), 'faketoken', {})
  end

  def password_change_admin
    CustomDeviseMailer.password_change(params(admin))
  end

  private

  def params(user)
    { id: user.id, class_name: user.class.name }
  end

  def admin
    Admin.first || FactoryBot.create(:admin)
  end
end
