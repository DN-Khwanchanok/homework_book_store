module Api
  class UsersController < BaseController
    before_action :require_admin

    def index
      render json: User.order(:id).as_json(only: [:id, :email_address])
    end

    def show
      render json: User.find(params[:id]).as_json(only: [:id, :email_address])
    end

    private

    def require_admin
      return if Current.user&.admin?

      render json: { error: "Admin access required" }, status: :forbidden
    end
  end
end
