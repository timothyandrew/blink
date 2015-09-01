class FormGeneratorDataSetItem < ActiveRecord::Base
  validates_uniqueness_of :text, scope: :form_generator_data_set_id
  belongs_to :data_set, class_name: FormGeneratorDataSet, foreign_key: "form_generator_data_set_id"
  validates_presence_of :text, :data_set
end
