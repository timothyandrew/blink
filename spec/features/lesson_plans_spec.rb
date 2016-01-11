describe "Lesson Plans", type: :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    create_lesson_plan
  end

  def create_lesson_plan(date = nil, verify = true)
    visit "/lesson_plans"
    click_on "New Lesson Plan"
    fill_in "Date", with: date || Faker::Date.forward(50)
    click_on "Save"
    if verify
      expect(page).to have_content "Lesson plan was created"
    end
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
    expect(page).to have_content "Lesson plan item was created"

    expect(page).to have_content "Goals Some Goals"
    expect(page).to have_content "A Subject"
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
    expect(page).to have_content('Lesson plan was edited')
    expect(LessonPlan.last.date).to eq(date)
  end

  it "allows editing a lesson plan item" do
    click_on "Add Item"
    fill_in_lesson_plan_item
    click_on "Save"
    click_on "1:00pm - 2:00pm"
    click_on "Edit"
    fill_in_lesson_plan_item(start: "1:00pm", end: "2:00pm", goals: "New Goals", subject: "New Subject", aids: "New aids", method: "New method", topic: "New Topic")
    click_on "Save"

    expect(page).to have_content "New Goals"
    expect(page).to have_content "New Subject"
    expect(page).to have_content "New Topic"
    expect(page).to have_content "New method"
    expect(page).to have_content "New aids"
  end

  it "does not allow two lesson plans on the same day" do
    date = Faker::Date.forward(50)
    create_lesson_plan(date, false)
    expect(page).to have_content "Lesson plan was created"
    create_lesson_plan(date, false)
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
    expect(page).to have_content("Lesson plan was created")

    new = LessonPlan.last
    expect(new.id).not_to eq(original.id)
    expect(new.items).not_to be_empty

    expect(page).to have_content "Goals Some Goals"
    expect(page).to have_content "A Subject"
    expect(page).to have_content "Topic A Topic"
    expect(page).to have_content "Teaching Method Teach a method"
    expect(page).to have_content "Teaching Aids Some aids"
    expect(page).to have_content "1:00pm - 2:00pm"
  end

  describe "Quick-Edit Lesson Plan" do
    def create_lesson_plan_with_items
      visit "/lesson_plans"
      click_on "New Lesson Plan"
      fill_in "Date", with: Faker::Date.forward(50)

      click_on "Save"
      expect(page).to have_content "Lesson plan was created"
      click_on "Quick Edit"

      2.times { click_on "Add Item" }
      fill_in "lesson_plan[items][1][subject]", with: "First Subject"
      fill_in "lesson_plan[items][1][start]", with: "10:00am"
      fill_in "lesson_plan[items][1][end]", with: "10:00pm"

      fill_in "lesson_plan[items][2][subject]", with: "Second Subject"
      fill_in "lesson_plan[items][2][start]", with: "11:00am"
      fill_in "lesson_plan[items][2][end]", with: "2:00pm"

      click_on "Submit"
      expect(page).to have_content "Lesson plan was edited"
    end

    it "allows adding items to a lesson plan" do
      create_lesson_plan_with_items

      items = LessonPlan.last.items
      expect(items.first.subject).to eq "First Subject"
      expect(items.first.start.to_s(:time)).to eq "10:00"
      expect(items.first.end.to_s(:time)).to eq "22:00"

      expect(items.second.subject).to eq "Second Subject"
      expect(items.second.start.to_s(:time)).to eq "11:00"
      expect(items.second.end.to_s(:time)).to eq "14:00"
    end

    it "allows editing items in a lesson plan" do
      create_lesson_plan_with_items

      click_on "Quick Edit"
      fill_in "lesson_plan[items][1][subject]", with: "New First Subject"
      fill_in "lesson_plan[items][2][end]", with: "4:00pm"
      click_on "Submit"

      expect(page).to have_content "Lesson plan was edited"
      items = LessonPlan.last.items
      expect(items.first.subject).to eq "New First Subject"
      expect(items.first.start.to_s(:time)).to eq "10:00"
      expect(items.first.end.to_s(:time)).to eq "22:00"

      expect(items.second.subject).to eq "Second Subject"
      expect(items.second.start.to_s(:time)).to eq "11:00"
      expect(items.second.end.to_s(:time)).to eq "16:00"
    end

    it "allows deleting items in a lesson plan" do
      create_lesson_plan_with_items

      click_on "Quick Edit"
      accept_confirm { click_on "lesson-plan-item-snippet-delete-1" }
      click_on "Submit"

      expect(page).to have_content "Lesson plan was edited"
      expect(LessonPlan.last.items.count).to eq(1)
    end

    it "does not clear other fields in the lesson plan items", focus: true do
      create_lesson_plan_with_items

      click_on "10:00am - 10:00pm"
      click_on "Edit"
      fill_in_ckeditor "lesson_plan_item_goals", with: "Some Goals"
      click_on "Save"

      click_on "Quick Edit"
      fill_in "lesson_plan[items][1][subject]", with: "New First Subject"
      click_on "Submit"

      expect(page).to have_content "Lesson plan was edited"
      items = LessonPlan.last.items
      expect(items.first.subject).to eq "New First Subject"
      expect(items.first.goals).to include "Some Goals"
    end

    it "preserves item attributes when there are errors" do
      create_lesson_plan_with_items

      click_on "Quick Edit"
      click_on "Add Item" # Error
      click_on "Submit"

      expect(page).to have_content "Start can't be blank and End can't be blank"
      expect(find_field("lesson_plan[items][1][subject]").value).to eq "First Subject"
      expect(find_field("lesson_plan[items][1][start]").value).to eq "10:00am"
      expect(find_field("lesson_plan[items][1][end]").value).to eq "10:00pm"
    end


    it "preserves deletions after there are errors" do
      create_lesson_plan_with_items

      click_on "Quick Edit"
      accept_confirm { click_on "lesson-plan-item-snippet-delete-1" }
      click_on "Add Item" # Error
      click_on "Submit"

      expect(page).to have_content "Start can't be blank and End can't be blank"
      expect(find_field("lesson_plan[items][1][subject]").value).not_to eq "First Subject"
      expect(find_field("lesson_plan[items][1][start]").value).not_to eq "10:00am"
      expect(find_field("lesson_plan[items][1][end]").value).not_to eq "10:00pm"
    end
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
      expect(page).to have_content "Lesson plan item was created"

      item = LessonPlan.last.items.last
      click_on "2:00pm - 5:00pm"
      accept_confirm { click_on "Delete" }
      expect(page).to have_content("Lesson plan item was destroyed")
      expect(LessonPlanItem.find_by_id(item.id)).to be_nil
    end
  end
end
