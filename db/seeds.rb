
# employee = Employee.create(
# 	 first_name: 'Vinay',
# 	 last_name: 'Sankhla',
# 	 personal_email: 'vinay@123',
# 	 city: 'Indore',
# 	 state: 'M.P.',
# 	 country: 'India',
# 	 pincode: '452001',
# 	 address_line_1: 'vijay nagar indore'
# 	)

# employee = Employee.create(
# 	 first_name: 'Raaj',
# 	 last_name: 'Sankhla',
# 	 personal_email: 'raaj@123',
# 	 city: 'Indore',
# 	 state: 'M.P.',
# 	 country: 'India',
# 	 pincode: '452001',
# 	 address_line_1: 'vijay nagar indore'
# 	)

# employee = Employee.create(
# 	 first_name: 'Tushar',
# 	 last_name: 'Sankhla',
# 	 personal_email: 'tushar@123',
# 	 city: 'Indore',
# 	 state: 'M.P.',
# 	 country: 'India',
# 	 pincode: '452001',
# 	 address_line_1: 'vijay nagar indore'
# 	)

# employee = Employee.create(
# 	 first_name: 'Tushar',
# 	 last_name: 'Bhiya',
# 	 personal_email: 'tushar@123',
# 	 city: 'Indore',
# 	 state: 'M.P.',
# 	 country: 'India',
# 	 pincode: '452001',
# 	 address_line_1: 'vijay nagar indore'
# 	)
 
# # employee = Employee.new
# # employee.save

ActiveRecord::Base.transaction do 
  10.times do |i| 
    employee = Employee.create(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      personal_email: Faker::Internet.email,
      address_line_1: Faker::Address.street_address,
      date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country,
      pincode: Faker::Address.postcode,
      date_of_joining: (Date.today - 3.years),
      job_title: Employee::JOB_TITLE.sample,
      bio: Faker::Lorem.paragraph_by_chars(number: 500)
    )

    puts "Employee #{i+1} created Successfully."
  end
end