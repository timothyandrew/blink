class ELCLessonPlanItem < LessonPlanItem
  def central_1
    self.elc_data["central_1"]
  end

  def reading
    self.elc_data["reading"]
  end

  def craft
    self.elc_data["craft"]
  end

  def technology
    self.elc_data["technology"]
  end

  def central_2
    self.elc_data["central_2"]
  end

  def elc?
    true
  end
end
