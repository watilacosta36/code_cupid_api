# frozen_string_literal: true

module Api
  module V1
    class UserProfilesController < BaseController
      before_action :set_user_profile, only: %i[show update]

      def show
        return render json: { message: I18n.t('activerecord.models.user.not_found') } if @user_profile.nil?

        render json: { profile: UserSerializer.new.serialize(@user_profile) }, status: :ok
      end

      def update
        if @user_profile.update(profile_params)
          return render json: { user: UserSerializer.new.serialize(@user_profile) }, status: :ok
        end

        render json: { errors: @user_profile.errors }, status: :unprocessable_entity
      end

      private

      def set_user_profile
        @user_profile ||= User.find_by(id: params[:id])

        authorize @user_profile, policy_class: UserProfilePolicy
      end

      def profile_params
        params.require(:user).permit(:username, :phone_number, :birthdate, :email, :gender)
      end
    end
  end
end
