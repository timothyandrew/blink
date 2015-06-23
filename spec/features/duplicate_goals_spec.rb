describe "Goal duplication", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  it "allows duplicating a tree of goals" do
    new_student = create_student

    click_on "IEP"
    click_on @student_name
    subject, long_term_goal, short_term_goal, monthly_objective, weekly_objective, activity = create_goal_tree

    old_goal_count = Student.first.goals.count

    click_on "IEP"
    click_on @student_name
    click_on subject
    accept_confirm { click_on "Save As" }

    select(new_student, from: "target")
    click_on "Save As"
    expect(page).to have_content "Duplicated"

    goals = Student.last.goals.where(depth: 0)
    expect(goals[0].title).to eq(subject)
    expect(goals[0].children[0].title).to eq(long_term_goal)
    expect(goals[0].children[0].children[0].title).to eq(short_term_goal)
    expect(goals[0].children[0].children[0].children[0].title).to eq(monthly_objective)
    expect(goals[0].children[0].children[0].children[0].children[0].title).to eq(weekly_objective)
    expect(goals[0].children[0].children[0].children[0].children[0].children[0].title).to eq(activity)
    expect(old_goal_count).to eq(Student.last.goals.count)
    expect(old_goal_count).to eq(Student.first.goals.count)
  end
end
