ActiveAdmin.register User do
  actions :all, except: [:destroy]
  permit_params :email, :name, :password, :admin
  index do
    selectable_column
    column :email
    column :name
    column :admin
    column :sign_in_count
    actions
  end
  form do |f|
    f.semantic_errors
    if f.object.new_record?
      f.inputs :email, :name, :password, :admin
    else
      f.inputs :email, :name, :admin
    end
    f.actions
  end
end
