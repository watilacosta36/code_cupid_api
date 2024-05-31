# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization

  after_action :verify_authorized
  around_action :switch_locale

  attr_reader :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authorize_resource
    header = request.headers['Authorization']

    return render json: { errors: ['Not Authorized'] }, status: :unauthorized unless header

    @decoded = JwtToken.decode(header).symbolize_keys
    @current_user = User.find(@decoded[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: I18n.t('activerecord.models.user.not_found') }, status: :not_found
  rescue JWT::VerificationError, JWT::ExpiredSignature => e
    render json: { errors: e.message }, status: :forbidden
  end

  private

  def switch_locale(&)
    locale = current_user.try(:locale) || I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    render json: { error: I18n.t("pundit.#{policy_name}.#{exception.query}"), scope: 'pundit', default: :default },
           status: :unauthorized
  end
end
