class AddColumnUserIdToStudents < ActiveRecord::Migration
  def change
    add_column :students, :user_id, :integer, index: true, foreign_key: true
  end
end
