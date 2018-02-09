# coding: utf-8
class TestsController < ApplicationController
	include Verify

  before_action :find_section
	before_action :find_test
	before_action :all_topic
	around_action :evaluate, except: [:result]
	around_action :finished!, except: [:result]
	around_action :can_do_it!, except: [:result]


	def show

		@deadline = @test.deadline
		@start_date = @test.start_date
		if @test.start_date.nil?
			@start_date = Date.today
		end
		if @test.deadline.nil?
			@deadline = Date.today
		end

		if Date.today >= @start_date  && Date.today <= @deadline
			gon.time_limit = @test.time_limit
			# Para saber cuantos intentos ha realizado el usuario
			do_course = DoCourse.inscription(current_user,@course)
			user_id = current_user.id
			test_id = @test.id
			already_pass = false

			if @test.can_do_it?(@tests_in_course,do_course)
				if @test.attemps_limits != 0


					@count = DoTest.where(do_course_id: do_course.id,test_id: @test.id).count
					@count += 1
					if @count <= @test.attemps_limits
						DoTest.create(user_id: user_id,test_id: test_id,do_course_id: do_course.id, active: 1 )
					else
						flash[:alert] = "Superó el límite de intentos en este examen"
						redirect_to course_section_path(@course,@section)
					end
				else
					DoTest.create(user_id: user_id,test_id: test_id,do_course_id: do_course.id, active: 1 )
				end
			else
				flash[:alert] = "Usted ya aprobó el examen"
				redirect_to course_section_path(@course,@section)
			end
		else
			if !@test.start_date.nil? && Date.today <= @test.start_date
				flash[:alert] = "El examen inicia el #{localize(@test.start_date)}"
			end

			if !@test.deadline.nil? && Date.today >= @test.deadline
				flash[:alert] = "El examen culminó el #{localize(@test.deadline)} "
			end

			redirect_to course_section_path(@course,@section)
		end
	end

	def check_answer
		do_course = DoCourse.inscription(current_user,@course)
		@do_test = DoTest.where(test_id: @test.id,do_course_id: do_course.id).last

		grade = 0
		if in_time?
			test_params[:questions_attributes].each do|q,values|
				question_object = Question.find_by(id: values[:id].to_i)
				amount_correct_answer = Answer.where(question_id: question_object.id,is_correct: 1).count

				counter_correct = 0
				counter_incorrect = 0
				if !values[:answers_correct].nil?
					values[:answers_correct].each do |c|
						answer = Answer.find_by(question_id: question_object.id,description: c)
						HasAnswer.create(do_test_id: @do_test.id,answer_id: answer.id)
						
						if answer.is_correct == 1
							counter_correct += 1
						else
							counter_incorrect += 1
						end
					end

					# Si las incorrectas son menores que las correctas se suma la nota del usuario
					if counter_incorrect < counter_correct
						values_answer = question_object.points/amount_correct_answer
						grade +=  values_answer*(counter_correct-counter_incorrect)
					end

				end

			end
			# Se evalua si es el ultimo examen para aprobar el curso
			all_topic()
			if @test.required == 1
				if @test.is_the_last?(@tests_in_course)
					if grade >= @test.min_grade
						session[:approved_course] = 1
						do_course.finished_at = Date.today
						do_course.save
					end
				end
				# Si el usuario reprobo se analiza si es el ultimo intento
				if @test.attemps_limits != 0
					if grade < @test.min_grade
						amount_of_try = @test.amount_of_try(do_course.id)

						if amount_of_try >= @test.attemps_limits
							do_course.enroll = 0
							do_course.failed = 1
							do_course.finished_at = Date.today
							do_course.save
							flash[:alert] = "Usted ha reprobado el curso"
						end
					end
				end
			end


		end

		@do_test.grade = grade
		@do_test.duration = @duration
		@do_test.save

		redirect_to course_section_test_result_path(@course,@section,@test,@do_test)
	end


	def result
		@do_test = DoTest.find(params[:id])
		#  En caso de que un usuario coloque un id de do_test que no corresponde al examen de la url
		if @do_test.test_id == @test.id
			#  Asegurar que los unicos que lo puedan ver son el que hizo el examen y los administradores
			if current_user.is_at_least_medium_admin? || current_user.id == @do_test.user_id
			else
			 root_path
			end
		else
			flash[:alert] = "Hubo un error en enlace para mostrar los resultados"
			root_path
		end
	end


	private

	def test_params
		params.require(:test).permit(  questions_attributes: [:id, answers: [], answers_correct: []])

	end

	def in_time?

		@duration = (Time.now - @do_test.created_at)/60

		if @test.time_limit.nil?
			true
		else
			if @duration <=  (@test.time_limit+1)
				true
			else
				false
			end
		end
	end

	def find_test
		if params[:test_id].nil?
		 @test = Test.find(params[:id])
	 else
		 @test = Test.with_deleted.find(params[:test_id])
	 end
	end

	def find_section
	 @section = Section.find(params[:section_id])
	end

	def finished!

		if DoCourse.approved_enroll?(current_user,@course)
			flash[:notice] = "Usted ya aprobó el curso"
			redirect_to course_path @course
		else
			yield
		end
	end

	def can_do_it!
		do_course = DoCourse.find_by(enroll: 1, user_id: current_user.id, course_id: @course.id,finished_at:nil)

		if @test.can_do_it?(@tests_in_course, do_course)
			yield
		else

			do_tests = do_course.do_tests.where(test_id: @test.id)
			do_tests.each do |do_t|
				if do_t.grade > @test.min_grade
					flash[:alert] = "Usted ya aprobó el examen"
					break
				end
			end

			if flash[:alert].nil?
				flash[:alert] = "Usted debe realizar los exámenes anteriores primero"
			end
			redirect_to course_section_path(@course,@section)
		end
	end

end
