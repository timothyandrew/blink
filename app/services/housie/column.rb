module Housie
  class Column
    include ActiveModel::Validations
    attr_reader :lower, :higher

    validates_presence_of :lower
    validates_presence_of :higher

    validate do |column|
      if self.lower && self.higher
        errors.add(:lower, 'Lower limit must be higher than upper limit') if self.lower > self.higher
        errors.add(:lower, 'Difference between limits must be at least 8') if (self.higher - self.lower) < 8
      end
    end

    def initialize(options)
      @lower = options[:lower].to_i if options[:lower].present?
      @higher = options[:higher].to_i if options[:higher].present?
    end

    def range
      if @lower && @higher
        @lower..@higher
      end
    end
  end
end
