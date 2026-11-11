class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.decimal :price, precision: 10, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
