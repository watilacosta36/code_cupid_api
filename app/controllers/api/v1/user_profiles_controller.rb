module Api
  module V1
    class UserProfilesController < BaseController
      before_action :set_user_profile, only: %i[show]

      def show
        return render json: { message: I18n.t('activerecord.models.user.not_found') } if @user_profile.nil?

        render json: { profile: UserSerializer.new.serialize(@user_profile) }, status: :ok
      end

      private

      def set_user_profile
        @user_profile ||= User.find_by(id: params[:id])

        authorize @user_profile, policy_class: UserProfilePolicy
      end
    end
  end
end
