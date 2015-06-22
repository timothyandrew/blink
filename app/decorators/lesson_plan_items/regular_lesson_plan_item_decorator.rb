class RegularLessonPlanItemDecorator < LessonPlanItemDecorator
  delegate_all

  def span?
    model.subject.present? && model.topic.blank? && model.goals.blank? && model.teaching_method.blank? && model.teaching_aids.blank?
  end

  def show_html
    html = ""

    if model.subject.present?
      html << '<div class="lesson-plan-subject-span">' + model.subject + '</div>'
    end

    html << show_html_attr(:topic)
    html << show_html_attr(:goals)
    html << show_html_attr(:teaching_method)
    html << show_html_attr(:teaching_aids)

    html.html_safe
  end

  def display_title
    model.subject
  end
end
