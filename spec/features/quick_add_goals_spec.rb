describe "Quick addition of goals", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    @student_name = create_student
    click_on @student_name
  end

  it "allows adding a number of top-level goals at once" do
    click_on "Add Subject"
    click_on "Quick (Experimental)"

    fill_in "goals", with: <<-eos
First goal
Second goal
Third goal
    eos

    click_on "Submit"
    expect(page).to have_content('Goals were created')

    expect(page).to have_content("First goal")
    expect(page).to have_content("Second goal")
    expect(page).to have_content("Third goal")
  end

  it "allows adding a number of sub-level goals at once" do
    click_on "Add Subject"
    subject = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on subject
    click_on "Add Long Term Goal"

    click_on "Quick (Experimental)"

    fill_in "goals", with: <<-eos
First goal
Second goal
Third goal
    eos

    click_on "Submit"
    expect(page).to have_content('Goals were created')

    expect(page).to have_content("First goal")
    expect(page).to have_content("Second goal")
    expect(page).to have_content("Third goal")
  end

  it "allows adding a number of goals grouped by category" do
    click_on "Add Subject"
    subject = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
    click_on subject
    click_on "Add Long Term Goal"

    click_on "Quick (Experimental)"

    fill_in "goals", with: <<-eos
[First Category]
Foo
Bar

[Second Category]
Baz
Quux
    eos

    click_on "Submit"
    expect(page).to have_content('Goals were created')

    expect(Goal.count).to eq(5)

    expect(Goal.find_by_title("Foo").category_name).to eq("First Category")
    expect(Goal.find_by_title("Bar").category_name).to eq("First Category")

    expect(Goal.find_by_title("Baz").category_name).to eq("Second Category")
    expect(Goal.find_by_title("Quux").category_name).to eq("Second Category")
  end
end
