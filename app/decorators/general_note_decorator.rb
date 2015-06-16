class GeneralNoteDecorator < Draper::Decorator
  delegate_all

  def title
    model.title || "<no title>"
  end

  def updated_at
    date = model.updated_at.strftime("%b %-d, %Y")
    "Last updated on #{date}"
  end
end
