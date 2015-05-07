class CreateLongTermGoals < ActiveRecord::Migration
  def change
    create_table :long_term_goals do |t|
      t.references :student, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
