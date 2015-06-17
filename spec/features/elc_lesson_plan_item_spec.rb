describe "ELC Lesson Plan Items", type: :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    create_lesson_plan
  end

  def create_lesson_plan(date = nil)
    visit "/lesson_plans"
    click_on "New Lesson Plan"
    fill_in "Date", with: date || Faker::Date.forward(50)
    click_on "Save"
  end

  def create_elc_lesson_plan_item
    click_on "Add Item"
    choose "lesson_plan_item_type_elclessonplanitem"
    fill_in "Start Time", with: "1:00pm"
    fill_in "End Time", with: "2:00pm"
    fill_in "Theme", with: Faker::Company.catch_phrase
    fill_in_ckeditor "lesson_plan_item_elc_data_central_1_activity", with: Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_elc_data_central_1_materials", with: Faker::Lorem.paragraph

    fill_in_ckeditor "lesson_plan_item_elc_data_central_2_activity", with: Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_elc_data_central_2_materials", with: Faker::Lorem.paragraph

    fill_in_ckeditor "lesson_plan_item_elc_data_reading_activity", with: Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_elc_data_reading_materials", with: Faker::Lorem.paragraph

    fill_in_ckeditor "lesson_plan_item_elc_data_technology_activity", with: Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_elc_data_technology_materials", with: Faker::Lorem.paragraph

    fill_in_ckeditor "lesson_plan_item_elc_data_craft_activity", with: Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_elc_data_craft_materials", with: Faker::Lorem.paragraph
    click_on "Save"
  end

  it "allows creating an ELC type lesson plan item" do
    create_lesson_plan
    create_elc_lesson_plan_item
    expect(ELCLessonPlanItem.count).to eq(1)
    expect(page).to have_content(ELCLessonPlanItem.last.theme)

    expect(ELCLessonPlanItem.last.elc_data["craft"]["materials"]).not_to be_empty
    expect(ELCLessonPlanItem.last.elc_data["craft"]["activity"]).not_to be_empty

    expect(ELCLessonPlanItem.last.elc_data["technology"]["materials"]).not_to be_empty
    expect(ELCLessonPlanItem.last.elc_data["technology"]["activity"]).not_to be_empty

    expect(ELCLessonPlanItem.last.elc_data["reading"]["materials"]).not_to be_empty
    expect(ELCLessonPlanItem.last.elc_data["reading"]["activity"]).not_to be_empty

    expect(ELCLessonPlanItem.last.elc_data["central_1"]["materials"]).not_to be_empty
    expect(ELCLessonPlanItem.last.elc_data["central_1"]["activity"]).not_to be_empty

    expect(ELCLessonPlanItem.last.elc_data["central_2"]["materials"]).not_to be_empty
    expect(ELCLessonPlanItem.last.elc_data["central_2"]["activity"]).not_to be_empty
  end
end
