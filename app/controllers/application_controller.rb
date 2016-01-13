class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_user
    user = super || User.new
    user.decorate
  end

  def assign_student
    @student = current_user.students.find(params[:student_id]).decorate
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def authenticate_admin_user!
    unless current_user.admin?
      redirect_to :back, notice: "Not allowed"
    end
  end
end
