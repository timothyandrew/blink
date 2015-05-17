class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  alias_method :devise_current_user, :current_user
  def current_user
    devise_current_user.decorate if devise_current_user
  end

  def assign_student
    @student = current_user.students.find(params[:student_id])
  end
end
