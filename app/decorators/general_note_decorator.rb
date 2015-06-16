class GeneralNoteDecorator < Draper::Decorator
  delegate_all

  def title
    model.title || "<no title>"
  end
end
