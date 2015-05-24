describe "the signin process", :type => :feature do
  let(:user) { create(:user) }

  it "logs in" do
    login(user)
  end
end
