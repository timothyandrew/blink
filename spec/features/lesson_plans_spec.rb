describe "Lesson Plans", type: :feature do
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

  def fill_in_lesson_plan_item(options = {})
    fill_in "Start Time", with: options[:start] || "1:00pm"
    fill_in "End Time", with: options[:end] || "2:00pm"
    fill_in "Subject", with: options[:subject] || Faker::Company.bs
    fill_in "Topic", with: options[:topic] || Faker::Company.bs
    fill_in_ckeditor "lesson_plan_item_goals", with: options[:goals] || Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_teaching_method", with: options[:method] || Faker::Lorem.paragraph
    fill_in_ckeditor "lesson_plan_item_teaching_aids", with: options[:aids] || Faker::Lorem.paragraph
  end

  it "allows creating a lesson plan for a given day" do
    click_on "Add Item"
    fill_in_lesson_plan_item(start: "1:00pm", end: "2:00pm", goals: "Some Goals", subject: "A Subject", aids: "Some aids", method: "Teach a method", topic: "A Topic")
    click_on "Save"

    expect(page).to have_content "Goals Some Goals"
    expect(page).to have_content "Subject A Subject"
    expect(page).to have_content "Topic A Topic"
    expect(page).to have_content "Teaching Method Teach a method"
    expect(page).to have_content "Teaching Aids Some aids"
    expect(page).to have_content "1:00pm - 2:00pm"
  end

  it "allows creating a lesson plan item with only a subject, which is a `span` event" do
    click_on "Add Item"
    fill_in "Start Time", with: "1:00pm"
    fill_in "End Time", with: "2:00pm"
    fill_in "Subject", with: "Break"
    click_on "Save"

    expect(page).to have_content "Break"
  end

  it "allows editing a lesson plan" do
    date = Faker::Date.forward(90)
    click_on "Edit Date"
    fill_in "Date", with: date
    click_on "Save"
    expect(LessonPlan.last.date).to eq(date)
  end

  it "does not allow two lesson plans on the same day" do
    date = LessonPlan.last.date
    create_lesson_plan(date)
    expect(page).to have_content "Date has already been taken"
  end

  it "allows duplicating a lesson plan" do
    original = LessonPlan.last

    click_on "Add Item"
    fill_in_lesson_plan_item(start: "1:00pm", end: "2:00pm", goals: "Some Goals", subject: "A Subject", aids: "Some aids", method: "Teach a method", topic: "A Topic")
    click_on "Save"

    click_on "Save As"
    fill_in "Date", with: Faker::Date.between(original.date + 15.days, original.date + 90.days)
    click_on "Save"

    new = LessonPlan.last
    expect(new.id).not_to eq(original.id)
    expect(new.items).not_to be_empty

    expect(page).to have_content "Goals Some Goals"
    expect(page).to have_content "Subject A Subject"
    expect(page).to have_content "Topic A Topic"
    expect(page).to have_content "Teaching Method Teach a method"
    expect(page).to have_content "Teaching Aids Some aids"
    expect(page).to have_content "1:00pm - 2:00pm"
  end

  describe "Deletions" do
    it "allows deleting a lesson plan" do
      lesson_plan = LessonPlan.last
      accept_confirm { click_on "Delete" }
      expect(page).to have_content("Lesson plan was destroyed")
      expect(LessonPlan.find_by_id(lesson_plan.id)).to be_nil
    end

    it "allows deleting a lesson plan item" do
      click_on "Add Item"
      fill_in_lesson_plan_item(start: "2:00pm", end: "5:00pm")
      click_on "Save"

      item = LessonPlan.last.items.last
      click_on "2:00pm - 5:00pm"
      accept_confirm { click_on "Delete" }
      expect(page).to have_content("Lesson plan item was destroyed")
      expect(LessonPlanItem.find_by_id(item.id)).to be_nil
    end
  end
end
