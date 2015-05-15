class CreateGeneralNotes < ActiveRecord::Migration
  def change
    create_table :general_notes do |t|
      t.text :text

      t.timestamps null: false
    end
  end
end
