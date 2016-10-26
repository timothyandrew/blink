class AddBookInventory < ActiveRecord::Migration
  def change
    create_table :book_inventory_items do |t|
      t.text :name
      t.text :author
      t.text :categories, array: true

      t.timestamps null: false
    end
  end
end
