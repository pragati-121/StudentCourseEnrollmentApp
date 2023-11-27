class Course < ApplicationRecord
	has_many :course_students
	has_many :students, through: :course_students

	validates :name, presence: true, length: { minimum: 5 }
	validates :start_date, presence: true
	validates :end_date, presence: true

	before_validation do 
		puts "Message before validations"
	end
	
	before_save :course_save_message


	def course_save_message
		puts "This message is displayed before saving the course"
	end
end
