ActiveAdmin.register FormGeneratorDataSetItem, as: "item" do
  belongs_to :form_generator_data_set
  permit_params :text
  actions :all

  action_item :import, only: :index do
    link_to "Import Items", import_admin_form_generator_data_set_items_path(form_generator_data_set)
  end

  collection_action :import, method: [:get, :post] do
    @items = params[:items] || {}
    if request.post?
      text_lines = params[:items][:text_lines]
      data_set = FormGeneratorDataSet.find(params[:form_generator_data_set_id])
      if data_set.import_items(text_lines)
        redirect_to collection_path(form_generator_data_set_id: data_set.id)
      else
        flash[:warning] = "There were some invalid items here."
        render :import
      end
    end
  end
end
