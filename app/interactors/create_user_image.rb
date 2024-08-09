# frozen_string_literal: true

class CreateUserImage
  include Interactor

  before do
    context.user = User.find_by(id: context.params[:user_id])
  end

  def call
    context.fail!(message: I18n.t('activerecord.models.user.not_found')) unless context.user.present?

    context.attachment = ActiveStorage::Attachment.new(record: context.user, name: :images)
  end
end
