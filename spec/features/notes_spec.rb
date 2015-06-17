describe "Notes", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  describe "saves global notes per user" do
    def fill_in_note(title, notes)
      click_on "New Note"
      fill_in "general_note_title", with: title
      fill_in_ckeditor "general_note_text", with: notes
      click_on "Save"
    end

    it "allows creating notes" do
      title = Faker::Company.catch_phrase
      notes = Faker::Lorem.paragraph
      click_on "General Notes"
      expect(page).to have_content "You need to add notes"
      fill_in_note(title, notes)
      click_on title
      expect(page).to have_content notes
    end

    it "allows editing notes" do
      title = Faker::Company.catch_phrase
      notes = Faker::Lorem.paragraph
      click_on "General Notes"
      fill_in_note(title, notes)
      click_on title
      click_on "Edit"

      fill_in "general_note_title", with: "Title"
      fill_in_ckeditor "general_note_text", with: "Some Note Text"
      click_on "Save"

      click_on "Title"
      expect(page).to have_content "Some Note Text"
    end

    it "allows deleting notes" do
      title = Faker::Company.catch_phrase
      notes = Faker::Lorem.paragraph
      click_on "General Notes"
      fill_in_note(title, notes)
      click_on title
      accept_confirm { click_on "Delete" }
      expect(page).to have_content("Note was destroyed")
      expect(GeneralNote.find_by_title(title)).to be_nil
    end
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
