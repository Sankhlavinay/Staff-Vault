class Employee < ApplicationRecord

	has_many :documents

	validates :first_name, :last_name, presence: true
	validates :personal_email, presence: true, uniqueness: true
	validates :city, :state, :country, :pincode, :address_line_1, presence: true
  validates :date_of_birth, :date_of_joining, :job_title, presence: true

  ransack_alias :name, :first_name_or_last_name_or_personal_email


	def name
		"#{first_name} #{middle_name} #{last_name}".strip
	end

	def full_address
		"#{address_line_1} #{city}, #{state}, #{country}, #{pincode}" 
	end

  def name_with_email
    "#{name}(#{personal_email})"
  end

  def self.ransackable_associations(auth_object = nil)
    ["documents"]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "city", "country", "date_of_birth", "date_of_joining", "first_name", "id", "job_title", "last_name", "middle_name", "personal_email", "state", "name"]
  end

end
