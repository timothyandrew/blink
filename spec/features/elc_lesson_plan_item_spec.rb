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
    expect(page).to have_content('Lesson plan was created')
  end

  it "allows creating an ELC type lesson plan item" do
    create_lesson_plan
    create_lesson_plan_item(:elc)
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
