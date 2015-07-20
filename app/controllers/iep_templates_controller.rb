class IepTemplatesController < ApplicationController
  def generate
    @student = current_user.students.find(params[:id])
    send_data IEPTemplate.new(@student).generate, filename: "IEP #{@student.name}.docx", type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
  end
end
