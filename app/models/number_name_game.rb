class NumberNameGame < ActiveRecord::Base
  belongs_to :user

  def self.parse_number_string(s)
    match = /\A(\d+)-(\d+)\z/.match(s)
    if match
      lower = match[1].to_i
      upper = match[2].to_i

      if lower <= upper
        (lower..upper).to_a
      end
    end
  end

  def create_parsing_number_string(params)
    self.name = params[:name]
    self.numbers = NumberNameGame.parse_number_string(params[:numbers])
    unless self.numbers
      errors.add(:numbers, "not in the right format")
      return
    end
    self.save
  end
end
