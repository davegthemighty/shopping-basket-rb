class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.decimal :total
      t.timestamps
    end
  end
end
