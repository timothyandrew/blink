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

    def fill_in_ckeditor(locator, opts)
      content = opts.fetch(:with).to_json
      page.execute_script <<-SCRIPT
        CKEDITOR.instances['#{locator}'].setData(#{content});
        $('textarea##{locator}').text(#{content});
      SCRIPT
    end
  end
end
