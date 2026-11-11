module Admin
  class MarketsController < BaseController
    before_action :set_market, only: [:edit, :update, :destroy]

    def index
      @markets = Market.order(:name)
    end

    def new
      @market = Market.new
    end

    def create
      @market = Market.new(market_params)

      if @market.save
        redirect_to admin_markets_path, notice: "เพิ่ม Market แล้ว", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @market.update(market_params)
        redirect_to admin_markets_path, notice: "แก้ไข Market แล้ว", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @market.destroy!
      redirect_to admin_markets_path, notice: "ลบ Market แล้ว", status: :see_other
    end

    private

    def set_market
      @market = Market.find(params[:id])
    end

    def market_params
      params.require(:market).permit(:name)
    end
  end
end
