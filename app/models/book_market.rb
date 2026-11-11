class BookMarket < ApplicationRecord
  belongs_to :book
  belongs_to :market
end
