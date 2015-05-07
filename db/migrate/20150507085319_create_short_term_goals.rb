class CreateShortTermGoals < ActiveRecord::Migration
  def change
    create_table :short_term_goals do |t|
      t.string :name
      t.text :description
      t.references :long_term_goal, index: true, foreign_key: true
      t.date :start
      t.date :end

      t.timestamps null: false
    end
  end
end
