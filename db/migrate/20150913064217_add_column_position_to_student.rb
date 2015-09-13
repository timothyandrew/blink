class AddColumnPositionToStudent < ActiveRecord::Migration
  def change
    add_column :students, :position, :integer
  end
end
