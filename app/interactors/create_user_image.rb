# frozen_string_literal: true

class CreateUserImage
  include Interactor

  before do
    context.fail!(message: I18n.t('activerecord.models.user.not_found')) unless context.user.present?
  end

  def call
    context.attachment = ActiveStorage::Attachment.new(record: context.user, name: :images)
  end
end
