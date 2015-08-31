ActiveAdmin.register Goal do
  actions :all, except: [:new, :edit, :destroy]
  menu label: "Goals", priority: 1
end
