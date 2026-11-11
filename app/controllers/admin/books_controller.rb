module Admin
  class BooksController < BaseController
    before_action :set_book, only: [:edit, :update, :destroy]

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to admin_path, notice: "เพิ่มหนังสือแล้ว", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to admin_path, notice: "บันทึกการแก้ไขแล้ว", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @book.destroy!
      redirect_to admin_path, notice: "ลบหนังสือแล้ว", status: :see_other
    end

    private

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :category_id, :price, :description, market_ids: [])
    end
  end
end
