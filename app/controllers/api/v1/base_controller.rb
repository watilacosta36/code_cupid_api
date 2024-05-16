# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :authorize_resource
    end
  end
end
