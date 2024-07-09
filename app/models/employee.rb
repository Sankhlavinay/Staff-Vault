class Employee < ApplicationRecord

	has_many :documents

	validates :first_name, :last_name, presence: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/ , message: "Only Letters are allowed" }
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

  JOB_TITLE = [
    "Senior ROR Developer",
    "Junior ROR Developer",
    "Full Stack ROR Developer",
    "Senior Full Stack MERN Developer",
    "Junior Full Stack MERN Developer",
    "Junior Full Stack Java Developer",
    "Senior Full Stack Java Developer"
  ].freeze

end
