class ELCLessonPlanItemDecorator < LessonPlanItemDecorator
  delegate_all

  def show_html
    if model.theme.present?
      ('<div class="lesson-plan-subject-span">ELC: ' + model.theme + '</div>').html_safe
    else
      '<div class="lesson-plan-subject-span">ELC</div>'.html_safe
    end
  end

  def display_title
    model.theme
  end

  def central_1_activity
    (model.central_1["activity"] || "").html_safe
  end

  def central_1_material
    (model.central_1["materials"] || "").html_safe
  end

  def central_2_material
    (model.central_2["materials"] || "").html_safe
  end

  def central_2_activity
    (model.central_2["activity"] || "").html_safe
  end

  def reading_material
    (model.reading["materials"] || "").html_safe
  end

  def reading_activity
    (model.reading["activity"] || "").html_safe
  end

  def technology_material
    (model.technology["materials"] || "").html_safe
  end

  def technology_activity
    (model.technology["activity"] || "").html_safe
  end

  def craft_material
    (model.craft["materials"] || "").html_safe
  end

  def craft_activity
    (model.craft["activity"] || "").html_safe
  end
end
