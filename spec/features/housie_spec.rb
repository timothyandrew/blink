describe "Housie", :type => :feature do
  before(:each) do
    @user = create(:user)
    login(@user)
    click_on "Utilities"
    click_on "Housie"
  end

  it "generates a housie PDF" do
    fill_in "Number of Players", with: 10
    click_on "Default"
    click_on "Done"
    expect(download_content).to_not be_nil
  end
end
