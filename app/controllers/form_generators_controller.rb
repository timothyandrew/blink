class FormGeneratorsController < ApplicationController
  def new
    @data_sets = FormGeneratorDataSet.pluck(:title)
  end

  def create
    service = FormGenerator::Service.new(form_generator_params)
    send_data service.generate, filename: "form #{DateTime.now.strftime('%d %b %Y')}.pdf", type: :pdf
  end

  private

  def form_generator_params
    params.require(:form_generator).permit(:form_count, :copy_count, :handwritten, :title, fields: [:name, :type])
  end
end
