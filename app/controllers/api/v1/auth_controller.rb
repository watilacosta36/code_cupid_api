module Api::V1
  class AuthController < ApplicationController
    before_action :set_user_by_email, only: %i[ login resend_code confirm_account ]
    before_action :authorize_resource, except: %i[ login sign_up confirm_account resend_code ]
    after_action :skip_authorization_method, only: %i[login sign_up confirm_account resend_code ]

    def login
      if @user&.authenticate(permitted_params[:password])
        token = JwtToken.encode(user_id: @user.id)

        return render json: { token: }, status: :ok
      end

      render json: { error: I18n.t('activerecord.errors.invalid_credentials') }, status: :unauthorized
    rescue JWT::EncodeError => jwt_error
      render json: { error: jwt_error }, status: :internal_server_error
    end

    def sign_up
      result = Organizers::SignUp.call(params: permitted_params)

      if result.success?
        render json: { message: I18n.t('auth.success.create') }, status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    def resend_code
      result = Organizers::ResendConfirmCode.call(user: @user)

      if result.success?
        render json: { message: I18n.t('auth.success.resend_code') }, status: :ok
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    def confirm_account
      return render json: { message: 'Cadastro confirmado' }, status: :ok if update_confirmation_status(@user)

      render json: { message: I18n.t('activerecord.errors.messages.invalid_code') }, status: :unprocessable_entity
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }, status: :unprocessable_entity
    rescue ActiveRecord::RecordNotFound => e
      render_not_found(e)
    end

    private

    def update_confirmation_status(user)
      return unless user.confirmation_code == permitted_params[:confirmation_code]

      user.update_attribute(:confirmed_at, Time.zone.now)
    end

    def render_not_found(e)
      render json: { error: I18n.t('activerecord.errors.record_not_found_with_email', email: permitted_params[:email]) },
             status: :unauthorized

      Rails.logger.error(e)
    end

    def skip_authorization_method
      skip_authorization
    end

    def set_user_by_email
      @user||= User.find_by!(email: permitted_params[:email])

    rescue ActiveRecord::RecordNotFound => e
      render_not_found(e)
    end

    def permitted_params
      params.require(:user).permit(:email, :password, :gender, :phone_number, :confirmation_code)
    end
  end
end