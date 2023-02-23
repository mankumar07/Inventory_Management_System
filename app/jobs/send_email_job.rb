# frozen_string_literal: true

class SendEmailJob < ApplicationJob
  self.queue_name_prefix = nil
  queue_as :default

  def perform(object)
    CrudNotificationMailer.create_notification(object).deliver_now
    CrudNotificationMailer.update_notification(object).deliver_now
  end
end
