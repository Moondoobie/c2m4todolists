class Profile < ActiveRecord::Base
  belongs_to :user

  validates :gender, inclusion: { within: %w(male female),
    message: "%{value} is not a valid size" }

  validate :both_names_not_nil
  validate :man_cannot_be_sue

  def both_names_not_nil
  	if (first_name.nil? && last_name.nil?)
  		errors.add(:first_name, "Both names cannot be null")
  	end
  end

  def self.get_all_profiles (min, max)
    Profile.where("birth_year BETWEEN ? AND ?", min, max).order(:birth_year).to_a     
  end

  def man_cannot_be_sue
  	if (gender == "male" && first_name == "Sue")
  		errors.add(:first_name, "A man's name cannot be Sue")
  	end
  end
  
end

