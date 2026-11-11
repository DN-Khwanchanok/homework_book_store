class AdminController < Admin::BaseController
  def index
    @books = Book.order(:title)
  end
end
