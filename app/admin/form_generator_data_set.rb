ActiveAdmin.register FormGeneratorDataSet do
  menu label: "Data Sets", priority: 2
  permit_params :title
  actions :all

  sidebar "Sidebar", only: [:show, :edit] do
    ul do
      li link_to "Items", admin_form_generator_data_set_items_path(form_generator_data_set)
    end
  end
end
