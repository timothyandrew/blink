class PictureComprehensionExercise < ActiveRecord::Base
  has_many :images, class: PictureComprehensionImage, dependent: :destroy
  belongs_to :user
  validates_presence_of :user_id

  def save_with_images(images)
    transaction do
      self.images.destroy_all
      self.save!
      images.each_with_index do |image, i|
        self.images.create!(image: image, position: i)
      end
    end
  end
end
