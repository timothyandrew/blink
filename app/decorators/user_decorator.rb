class UserDecorator < Draper::Decorator
  delegate_all

  def name
    model.name.presence || model.email
  end
end
