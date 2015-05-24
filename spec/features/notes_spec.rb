describe "Notes", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  it "saves global notes per user" do
    notes = Faker::Lorem.paragraph
    click_on "General Notes"
    expect(page).to have_content "You need to add some general notes"

    click_on "Edit General Notes"
    fill_in_ckeditor "general_note_text", with: notes
    click_on "Save"
    expect(page).to have_content notes
  end

  it "saves notes against each student" do
    notes = Faker::Lorem.paragraph
    click_on "Notes"
    expect(page).to have_content "You need to add some notes"

    click_on "Edit Notes"
    fill_in_ckeditor "student_notes", with: notes
    click_on "Save"
    expect(page).to have_content notes
    expect(Student.find_by_name!(@student_name).notes).to include(notes)
  end
end
