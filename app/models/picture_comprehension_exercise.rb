class PictureComprehensionExercise < ActiveRecord::Base
  has_many :images, class: PictureComprehensionImage
  belongs_to :user
  validates_presence_of :user_id

  def save_with_images(images)
    transaction do
      self.images.destroy_all
      self.save!
      images.each do |image|
        self.images.create!(image: image)
      end
    end
  end
end
