class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :student, index: true, foreign_key: true

      t.string :title
      t.text :description
      t.date :start
      t.date :end

      t.integer :parent_id, :null => true, :index => true
      t.integer :lft, :null => false, :index => true
      t.integer :rgt, :null => false, :index => true

      # optional fields
      t.integer :depth, :null => false, :default => 0
      t.integer :children_count, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
