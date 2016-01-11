module IntegrationTest
  module Helpers
    def login(user)
      visit '/users/sign_in'
      within("#new_user") do
        fill_in 'Email', :with => user.email
        fill_in 'Password', :with => 'password'
      end
      click_button 'Log in'
      expect(page).to have_content('Signed in')
    end

    def create_student
      click_on "IEP"
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
      expect(page).to have_content("Goal was created")
      click_on "Goals"
      name
    end


    def fill_in_ckeditor(locator, opts)
      expect(page).to have_css "#cke_#{locator}"
      sleep 0.5
      content = opts.fetch(:with).to_json
      page.execute_script <<-SCRIPT
        CKEDITOR.instances['#{locator}'].setData(#{content});
        $('textarea##{locator}').text(#{content});
      SCRIPT
    end

    def create_lesson_plan_item(type, options = {})
      click_on "Add Item"
      fill_in "Start Time", with: options[:start] || "1:00pm"
      fill_in "End Time", with: options[:end] || "2:00pm"

      if type == :elc
        choose "lesson_plan_item_type_elclessonplanitem"
        fill_in "Theme", with: Faker::Company.catch_phrase
        fill_in_ckeditor "lesson_plan_item_elc_data_central_1_activity", with: Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_elc_data_central_1_materials", with: Faker::Lorem.paragraph

        fill_in_ckeditor "lesson_plan_item_elc_data_central_2_activity", with: Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_elc_data_central_2_materials", with: Faker::Lorem.paragraph

        fill_in_ckeditor "lesson_plan_item_elc_data_reading_activity", with: Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_elc_data_reading_materials", with: Faker::Lorem.paragraph

        fill_in_ckeditor "lesson_plan_item_elc_data_technology_activity", with: Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_elc_data_technology_materials", with: Faker::Lorem.paragraph

        fill_in_ckeditor "lesson_plan_item_elc_data_craft_activity", with: Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_elc_data_craft_materials", with: Faker::Lorem.paragraph
      else
        fill_in "Subject", with: options[:subject] || Faker::Company.bs
        fill_in "Topic", with: options[:topic] || Faker::Company.bs
        fill_in_ckeditor "lesson_plan_item_goals", with: options[:goals] || Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_teaching_method", with: options[:method] || Faker::Lorem.paragraph
        fill_in_ckeditor "lesson_plan_item_teaching_aids", with: options[:aids] || Faker::Lorem.paragraph
      end

      click_on "Save"
      expect(page).to have_content('Lesson plan item was created')
    end

    def create_goal_tree
      goals = []

      click_on "Add Subject"
      goal_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
      goals << goal_name
      expect(page).to have_content goal_name
      click_on goal_name

      click_on "Add Long Term Goal"
      goal_name = fill_in_goal("Jan 01, 2015", "Dec 01, 2015")
      goals << goal_name
      click_on "Show All"
      expect(page).to have_content goal_name
      click_on goal_name

      click_on "Add Short Term Goal"
      goal_name = fill_in_goal("Jan 01, 2015", "Jan 21, 2015")
      goals << goal_name
      click_on "Show All"
      expect(page).to have_content goal_name
      click_on goal_name

      click_on "Add Monthly Objective"
      goal_name = fill_in_goal("Jan 02, 2015", "Jan 12, 2015")
      goals << goal_name
      click_on "Show All"
      expect(page).to have_content goal_name
      click_on goal_name

      click_on "Add Weekly Objective"
      goal_name = fill_in_goal("Jan 05, 2015", "Jan 10, 2015")
      goals << goal_name
      click_on "Show All"
      expect(page).to have_content goal_name
      click_on goal_name

      click_on "Add Activity"
      goal_name = fill_in_goal("Jan 6, 2015", "Jan 6, 2015")
      goals << goal_name

      goals
    end
  end
end
