module Api
  module V1
    module Admin
      class BaseController < ApplicationController
        before_action :authorize_resource
      end
    end
  end
end