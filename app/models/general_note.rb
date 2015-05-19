class GeneralNote < ActiveRecord::Base
  belongs_to :user
  audited
end
