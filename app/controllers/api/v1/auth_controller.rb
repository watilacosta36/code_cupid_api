module Api::V1
  class AuthController < ApplicationController
    before_action :authorize_resource, except: %i[ login sign_up ]
    after_action :skip_authorization_method, only: %i[login sign_up]

    def login
      user = User.find_by!(email: permitted_params[:email])

      if user&.authenticate(permitted_params[:password])
        token = JwtToken.encode(user_id: user.id)

        return render json: { token: }, status: :ok
      end

      render json: { error: I18n.t('activerecord.errors.invalid_credentials') }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound => e
      render_not_found(e)
    rescue JWT::EncodeError => jwt_error
      render json: { error: jwt_error }, status: :internal_server_error
    end

    def sign_up
      result = Organizers::SignUp.call(params: permitted_params)

      if result.success?
        render json: { message: I18n.t('activerecord.success.create') }, status: :created
      else
        render json: { error: result.error }, status: :unprocessable_entity
      end
    end

    private

    def render_not_found(e)
      render json: { error: I18n.t('activerecord.errors.record_not_found_with_email', email: permitted_params[:email]) },
             status: :unauthorized

      Rails.logger.error(e)
    end

    def skip_authorization_method
      skip_authorization
    end

    def permitted_params
      params.require(:user).permit(:email, :password, :gender, :phone_number)
    end
  end
end