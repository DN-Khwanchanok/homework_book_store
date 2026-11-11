module Api
  class CategoriesController < BaseController
    def index
      render json: Category.order(:id).as_json(only: [:id, :name])
    end

    def show
      render json: Category.find(params[:id]).as_json(only: [:id, :name])
    end
  end
end
