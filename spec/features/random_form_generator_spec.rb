describe "Random Form Generator", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    click_on "Random Form"
  end

  it "generates a random form PDF", focus: true do
    fill_in "Form Title", with: Faker::Company.catch_phrase
    fill_in "Form Count", with: 2
    fill_in "Copy Count", with: 2

    4.times { click_on "Add Field" }

    fill_in "form_generator[fields][1][name]", with: "Name"
    fill_in "form_generator[fields][2][name]", with: "School"
    fill_in "form_generator[fields][3][name]", with: "Address"
    fill_in "form_generator[fields][4][name]", with: "Blank"

    select "Name", from: "form_generator[fields][1][type]"
    select "School", from: "form_generator[fields][2][type]"
    select "Address", from: "form_generator[fields][3][type]"
    select "Blank", from: "form_generator[fields][4][type]"

    click_on "Done"
    expect(download_content).to_not be_nil
  end
end
