class CreateBasketLines < ActiveRecord::Migration[5.2]
  def change
    create_table :basket_lines do |t|
      t.integer :quantity
      t.references :basket, foreign_key: true
      t.references :item, foreign_key: true
      t.timestamps
    end
  end
end
