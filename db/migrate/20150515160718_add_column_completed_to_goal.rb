class AddColumnCompletedToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :completed, :boolean, index: true
  end
end
