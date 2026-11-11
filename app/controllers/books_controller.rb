class BooksController < ApplicationController
  def index
    @categories = Category.order(:name)
    @books = Book.includes(:category).order(:id)
    @query = params[:q].to_s.strip


    if params[:category_id].present?
      @selected_category = Category.find(params[:category_id])
      @books = @books.where(category: @selected_category)
    end

    if @query.present?
      keyword = "%#{Book.sanitize_sql_like(@query)}%"
      @books = @books.where("title ILIKE ?", keyword)
    end
  end

  def show
    @book = Book.includes(:category).find(params[:id])
    @market_names = @book.markets.order(:name).pluck(:name)
  end
end
