describe "Duplicating a Lesson Plan Item", type: :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
  end

  def create_lesson_plan(date = nil)
    visit "/lesson_plans"
    click_on "New Lesson Plan"
    fill_in "Date", with: date || Faker::Date.forward(50)
    click_on "Save"
  end

  [:elc, :regular].each do |type|
    it "allows duplicating an #{type.to_s.titleize} lesson plan item" do
      create_lesson_plan("Jun 24, 2015")
      create_lesson_plan("Jun 25, 2015")
      create_lesson_plan_item(type)
      click_on "1:00pm - 2:00pm"
      click_on "Save As"
      select("Wednesday - 24 June 2015", from: "lesson_plan_item[lesson_plan_id]")
      click_on "Save"
      expect(page).to have_content "Duplicated"

      new_item = LessonPlan.first.items.first
      old_item = LessonPlan.last.items.first


      keys_to_compare = [:start, :end, :subject, :topic, :goals, :teaching_method, :teaching_aids,
                         :type, :elc_data, :theme]

      keys_to_compare.each do |key|
        expect(new_item.send(key)).to eq(old_item.send(key))
      end
    end
  end
end
