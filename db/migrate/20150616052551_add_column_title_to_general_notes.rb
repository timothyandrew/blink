class AddColumnTitleToGeneralNotes < ActiveRecord::Migration
  def change
    add_column :general_notes, :title, :text
  end
end
