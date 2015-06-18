class ELCLessonPlanItemDecorator < LessonPlanItemDecorator
  delegate_all

  def show_html
    ('<div class="lesson-plan-subject-span">' +  display_title + '</div>').html_safe
  end

  def span?
    true
  end

  def display_title
    if model.theme.present?
      "ELC - #{model.theme}"
    else
      "ELC"
    end
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
