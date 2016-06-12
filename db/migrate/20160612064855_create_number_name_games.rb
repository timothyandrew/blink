class CreateNumberNameGames < ActiveRecord::Migration
  def change
    create_table :number_name_games do |t|
      t.string :name
      t.text :numbers, array: true, default: []
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
