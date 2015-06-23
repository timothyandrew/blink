describe "An audit log of actions for a student", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  it "records changes made to the student" do
    click_on "Edit Student"
    fill_in "Name", with: "New Name"
    click_on "Save"
    click_on "New Name"

    click_on "Log"
    click_on "Show All"

    expect(page).to have_content "This student was created on"
    expect(page).to have_content "This student was updated on"
    expect(page).to have_content "The name field was changed from #{@student_name} to New Name"
  end

  it "records changes made to a student's goals" do
    click_on "Add Subject"
    goal_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on "Goals"
    click_on goal_name
    click_on "Edit"

    fill_in "Title", with: "New Title"
    click_on "Save"
    click_on @student_name

    click_on "Log"
    click_on "Show All"

    expect(page).to have_content "A goal was created on"
    expect(page).to have_content "A goal was updated on"
    expect(page).to have_content "The title field was changed from #{goal_name} to New Title"
  end
end
