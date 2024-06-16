# frozen_string_literal: true

module RenderJson
  extend ActiveSupport::Concern

  def render_json_response(data:, status: :ok)
    render json: data, status:
  end
end