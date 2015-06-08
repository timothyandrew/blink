describe "A student and his/her goals", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  def verify_goal_tree(goals, student_name)
    student = Student.find_by_name!(student_name)
    goals.map! { |goal| Goal.find_by_title!(goal) }
    long_term_goal, short_term_goal, monthly_objective, weekly_objective, activity = goals

    expect(long_term_goal.parent).to be_nil
    expect(short_term_goal.parent).to eq(long_term_goal)
    expect(monthly_objective.parent).to eq(short_term_goal)
    expect(weekly_objective.parent).to eq(monthly_objective)
    expect(activity.parent).to eq(weekly_objective)

    goals.each { |goal| expect(goal.student).to eq(student) }
  end

  it "allows creating a tree of goals" do
    goals = []

    click_on "Add Subject"
    goal_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    goals << goal_name
    click_on goal_name
    expect(page).to have_content goal_name

    click_on "Add Long Term Goal"
    goal_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    goals << goal_name
    click_on "Show All"
    click_on goal_name
    expect(page).to have_content goal_name

    click_on "Add Short Term Goal"
    goal_name = fill_in_goal("Jan 01, 2015", "Jan 21, 2015")
    goals << goal_name
    click_on "Show All"
    click_on goal_name

    click_on "Add Monthly Objective"
    goal_name = fill_in_goal("Jan 02, 2015", "Jan 12, 2015")
    goals << goal_name
    click_on "Show All"
    click_on goal_name

    click_on "Add Weekly Objective"
    goal_name = fill_in_goal("Jan 05, 2015", "Jan 10, 2015")
    goals << goal_name
    click_on "Show All"
    click_on goal_name

    click_on "Add Activity"
    goal_name = fill_in_goal("Jan 6, 2015", "Jan 6, 2015")
    goals << goal_name

    visit("/students")
    click_on "Goals for All Students"
    goals.each { |goal| expect(page).to have_content(goal) }

    verify_goal_tree(goals, @student_name)
  end

  it "allows editing a goal" do
    click_on "Add Subject"

    old_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on old_name
    click_on "Edit"

    fill_in "Title", with: "new name"
    click_on "Save"

    click_on "Goals"
    expect(page).to have_content("new name")
    expect(page).to have_no_content(old_name)
  end

  it "allows completing a goal and it's sub goals" do
    click_on "Add Subject"
    long_term_goal = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on "Show All"
    click_on long_term_goal

    click_on "Add Long Term Goal"
    short_term_goal = fill_in_goal("Jan 01, 2015", "Jan 21, 2015")
    click_on "Show All"
    click_on short_term_goal

    click_on "Goals"
    click_on "Show All"
    click_on long_term_goal
    click_on "Complete"

    expect(Goal.find_by_title!(long_term_goal)).to be_completed
    expect(Goal.find_by_title!(short_term_goal)).to be_completed

    click_on "Uncomplete"
    expect(Goal.find_by_title!(long_term_goal)).not_to be_completed
    expect(Goal.find_by_title!(short_term_goal)).not_to be_completed
  end

  it "allows deleting a goal" do
    click_on "Add Subject"
    goal = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on goal

    expect(Goal.find_by_title(goal)).not_to be_nil
    accept_confirm { click_on "Delete" }
    expect(page).to have_selector(".alert-success")
    expect(Goal.find_by_title(goal)).to be_nil
  end
end
