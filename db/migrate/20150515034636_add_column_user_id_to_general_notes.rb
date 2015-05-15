class AddColumnUserIdToGeneralNotes < ActiveRecord::Migration
  def change
    add_column :general_notes, :user_id, :integer, index: true, foreign_key: true
  end
end
