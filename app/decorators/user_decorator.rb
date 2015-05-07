class UserDecorator < Draper::Decorator
  delegate_all

  def name
    model.email
  end
end
