class CreateFormGeneratorDataSets < ActiveRecord::Migration
  def change
    create_table :form_generator_data_sets do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
