class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,  
         :rememberable, 
         :validatable, 
         :confirmable, 
         :trackable,
         authentication_keys: [:login]

  validates :username, presence: true, uniqueness: true
  validates :contact_number, numericality: true, length: { minimum: 10, maximum: 10 }
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/ , message: "Only Letters are allowed" }, presence: true

  attr_accessor :login

  def login
    @login || self.username || self.email || self.contact_number
  end

private
  def after_confirmation
    WelcomeMailer.send_greetings_notification(self)
                 .deliver_now
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup  
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value OR lower(contact_number) = :value ", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:contact_number)
      where(conditions.to_h).first
    end
        
  end
end
