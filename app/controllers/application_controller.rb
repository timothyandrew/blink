class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  alias_method :devise_current_user, :current_user
  def current_user
    devise_current_user.decorate if devise_current_user
  end

  def assign_student
    @student = current_user.students.find(params[:student_id]).decorate
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
end
