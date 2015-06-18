class LessonPlanItemDecorator < Draper::Decorator
  delegate_all

  def range
    "#{model.start.strftime('%-l:%M%P')} - #{model.end.strftime('%-l:%M%P')}"
  end

  def show_html_attr(attr)
    html = ""
    if model.send(attr).present?
      html << '<div class="lesson-plan-item-attribute-value">'
      html << '<span class="lesson-plan-item-attribute">' + model.class.human_attribute_name(attr).titleize + '</span>'
      html << model.send(attr)
      html << '</div>'
    end
    html.html_safe
  end
end
