class Book < ApplicationRecord
  belongs_to :category, optional: true

  has_many :book_markets, dependent: :destroy
  has_many :markets, through: :book_markets

  validates :title, :author, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than: 100_000_000 }
  validates :category, presence: true, if: -> { category_id.present? }

  def inspect
    super.sub(/price: [^,>]+/) do
      "price: #{price.nil? ? 'nil' : format('%.2f', price)}"
    end
  end
end

