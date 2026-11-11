module Api
  class MarketsController < BaseController
    def index
      render json: Market.order(:id).as_json(only: [:id, :name])
    end

    def show
      render json: Market.find(params[:id]).as_json(only: [:id, :name])
    end
  end
end
