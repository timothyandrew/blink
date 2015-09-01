class CreateFormGeneratorDataSetItems < ActiveRecord::Migration
  def change
    create_table :form_generator_data_set_items do |t|
      t.references :form_generator_data_set, foreign_key: true
      t.text :text

      t.timestamps null: false
    end
  end
end
