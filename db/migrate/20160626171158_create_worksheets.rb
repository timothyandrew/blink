class CreateWorksheets < ActiveRecord::Migration
  def change
    create_table :worksheets do |t|
      t.date :date
      t.text :topic
      t.text :description
      t.string :attachment
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
