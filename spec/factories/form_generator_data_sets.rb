FactoryGirl.define do
  factory :form_generator_data_set do
    title { Faker::Commerce.department(1) }
  end
end
