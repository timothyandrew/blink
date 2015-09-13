class Student < ActiveRecord::Base
  has_many :goals, dependent: :destroy
  validates_presence_of :name
  belongs_to :user

  audited
  has_associated_audits

  # Take a list of students, and a sequenced list of student_ids.
  # Change the position of each student based on the position of their
  # id in `sequence`.
  def self.order_sequentially!(students, sequence)
    transaction do
      students.each do |student, i|
        position = sequence.index(student.id.to_s) || 0
        student.position = position
        student.save!
      end
    end
  end
end
