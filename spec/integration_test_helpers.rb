module IntegrationTest
  module Helpers
    def login(user)
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => 'password'
      end
      click_button 'Log in'
    end

    def create_student
      name = Faker::Name.name
      click_on "New Student"
      fill_in "Name", with: name
      click_on "Save"
      name
    end


    def fill_in_goal(start_date, end_date)
      name = Faker::Company.bs
      fill_in "Title", with: name
      fill_in_ckeditor "goal_description", with: Faker::Lorem.paragraph
      fill_in "Start Date", with: start_date
      fill_in "End Date", with: end_date
      click_on "Save"
      name
    end


    def fill_in_ckeditor(locator, opts)
      content = opts.fetch(:with).to_json
      page.execute_script <<-SCRIPT
        CKEDITOR.instances['#{locator}'].setData(#{content});
        $('textarea##{locator}').text(#{content});
      SCRIPT
    end
  end
end
