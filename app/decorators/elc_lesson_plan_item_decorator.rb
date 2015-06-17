class ELCLessonPlanItemDecorator < LessonPlanItemDecorator
  delegate_all

  def show_html
    if model.theme.present?
      ('<div class="lesson-plan-subject-span">ELC: ' + model.theme + '</div>').html_safe
    else
      '<div class="lesson-plan-subject-span">ELC</div>'.html_safe
    end
  end
end
