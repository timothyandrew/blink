class Worksheet < ActiveRecord::Base
  mount_uploader :attachment, WorksheetAttachmentUploader
  belongs_to :user

  validates_presence_of :date
  validates_presence_of :topic
end
