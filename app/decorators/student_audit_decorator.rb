class StudentAuditDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def verb
    return "updated" if model.action == "update"
    return "created" if model.action == "create"
    return "deleted" if model.action == "destroy"
    return "changed"
  end

  def summary_sentence
    "#{auditable_type_link} was #{verb} on #{model.created_at.strftime('%d %b %Y')} at #{model.created_at.in_time_zone.strftime('%-l:%M%P')}."
  end

  def changes
    return update_changes if model.action == "update"
  end

  private

  def update_changes
    model.audited_changes.map do |column, change|
      old, new = change
      if new == true || new == false
        "<div class='changed-from-literal'>It was marked #{'not' if new == false} #{column}</div>"
      else
        "<div class='changed-from-literal'>The #{column} field was changed from</div> <div class='old'>#{old}</div> <div class='changed-to-literal'>to</div> <div class='new'>#{new}</div>"
      end
    end
  end

  def auditable_type_link
    return "A " + link_to("goal", student_goal_path(model.associated, model.auditable_id)) if auditable_type == "Goal"
    return "This student" if auditable_type == "Student"
    return auditable_type.downcase
  end
end
