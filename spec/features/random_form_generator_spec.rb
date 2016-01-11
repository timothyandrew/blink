describe "Random Form Generator", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    create(:form_generator_data_set, title: "Names")
    create(:form_generator_data_set, title: "Schools")
    click_on "Utilities"
    click_on "Random Form"
  end

  it "generates a random form PDF" do
    fill_in "Form Title", with: Faker::Company.catch_phrase
    fill_in "Form Count", with: 2
    fill_in "Copy Count", with: 2

    2.times { click_on "Add Field" }

    fill_in "form_generator[fields][1][name]", with: "Name"
    fill_in "form_generator[fields][2][name]", with: "School"

    select "Names", from: "form_generator[fields][1][type]"
    select "Schools", from: "form_generator[fields][2][type]"

    click_on "Done"
    expect(download_content).to_not be_nil
  end
end
