class StudentAuditsController < ApplicationController
  before_filter :assign_student

  def index
    @audits = (StudentAuditDecorator.decorate_collection(@student.associated_audits) + StudentAuditDecorator.decorate_collection(@student.audits)).sort_by(&:created_at).reverse
  end
end
