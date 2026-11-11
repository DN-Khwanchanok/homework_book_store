module Api
  class BaseController < ActionController::Base
    include Authentication

    prepend_before_action :no_store
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

    private

    def request_authentication
      render json: { error: "Sign in required" }, status: :unauthorized
    end

    def render_not_found
      render json: { error: "Record not found" }, status: :not_found
    end
  end
end
