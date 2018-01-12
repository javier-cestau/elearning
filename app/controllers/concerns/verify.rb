module Verify
	extend ActiveSupport::Concern

	included do
	 before_action :authenticate_user!, only: %i[show check_answer result]
	 before_action :find_course_in_section, only:%i[show check_answer result]
	 before_action :is_enroll, only: %i[show check_answer]
	end

	def evaluate
		if @is_enroll || current_user.is_at_least_medium_admin?
			if  Date.today >= @course.start_date
				yield
			else
				flash[:alert] = "El curso todavía no ha iniciado"
				redirect_to course_path @course
			end
		else
			flash[:alert] = "No está inscrito en el curso"
			redirect_to course_path @course
		end

	end

	def is_enroll
		@is_enroll = DoCourse.is_enroll_in_course?(@course,current_user)
	end
end
