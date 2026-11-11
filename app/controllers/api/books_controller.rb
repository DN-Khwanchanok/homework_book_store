module Api
  class BooksController < BaseController
    def index
      books = Book.includes(:category, :markets).order(:id)
      render json: books.map { |book| book_json(book) }
    end

    def show
      book = Book.includes(:category, :markets).find(params[:id])
      render json: book_json(book)
    end

    private

    def book_json(book)
      book.as_json(only: [:id, :title, :author, :price, :description]).merge(
        "category" => book.category&.name,
        "markets" => book.markets.map(&:name).sort_by(&:to_s)
      )
    end
  end
end
