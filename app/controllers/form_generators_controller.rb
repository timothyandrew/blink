class FormGeneratorsController < ApplicationController
  def new
  end

  def create
    service = FormGeneratorService.new(form_generator_params)
    send_data service.generate, filename: "form #{DateTime.now.strftime('%d %b %Y')}.pdf", type: "application/pdf"
  end

  private

  def form_generator_params
    params.require(:form_generator).permit(:form_count, :copy_count, :title, fields: [:name, :type])
  end
end
