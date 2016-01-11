class AddColumnPositionToPcImages < ActiveRecord::Migration
  def change
    add_column :picture_comprehension_images, :position, :integer, default: 0
  end
end
