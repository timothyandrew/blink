ActiveAdmin.register User do
  actions :all, except: [:new, :edit, :destroy]
end
