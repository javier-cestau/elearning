class Admin::TestsController < ApplicationController


 before_action :authenticate_medium_admin!
 before_action :find_course_in_section, only: %i[edit new create destroy average list_talent manual_grade]
 before_action :find_section, only: %i[edit new create destroy list_talent manual_grade]
 before_action :all_topic, only: %i[edit average list_talent]
 before_action :get_object_id, only: %i[simple multiple true_false redaction]
 around_action :find_test, only: %i[edit destroy]
 before_action :set_javascript_date, only: %i[edit new]
 around_action :is_active_course , only: %i[destroy create]

 def new
  @test = Test.new
 end

 def create
  @test = Test.new(test_params.except(:questions_attributes))
  if @test.attemps_limits.nil?
    @test.attemps_limits = 0
  end

  if !@test.auto
    @test.min_grade = 10
  end

  # Si se uso el boton de cambiar el estado auto
  if params[:change_auto] == "true"
    @test.auto = !@test.auto
  end

  @test.section_id = @section.id

  params[:test][:required] = params[:test][:required].to_i

  if test_params[:questions_attributes].nil?

   redirect_back(fallback_location: edit_admin_course_section_path(@course, @section))
   flash[:alert] = 'El examen debe contener al menos una pregunta'
  else
   ActiveRecord::Base.transaction do

     Test.where(section_id: @section.id).each do |t|
       Test.destroy(t)
     end

     if @test.save
      unless @test.start_date.nil?
        if @test.start_date < @course.start_date
          flash[:alert] = "La fecha de inicio del examen debe ser mayor o igual a la del curso"
          @test.start_date = nil
          @test.save
        end
      end


      avaible_question_array = Array.new
      test_params.fetch(:questions_attributes).each do |_name, values|
        question = Question.new(values.except(:answers, :answers_correct))

        next if @test.auto && question.type_question.sequence == 4
        avaible_question_array.push(values)

      end

      counter = 0
      test_params.fetch(:questions_attributes).each do |_name, values|


       question = Question.new(values.except(:answers, :answers_correct))
       counter += 1
       next if @test.auto && question.type_question.sequence == 4
       question.sequence = counter
       question.test_id = @test.id
       if !@test.auto || params[:change_auto] == "true"
         if values == avaible_question_array.last
           question.points = 20-(avaible_question_array.length-1)
         else
           question.points = 1
         end
       end

       if question.save
        unless values[:answers].nil?
         values[:answers].each do |description|
          answers_correct = values[:answers_correct]

          if question.type_question.sequence != 4
            is_correct = if answers_correct.include? description
                          1
                         else
                          0
                         end
         else
           is_correct = nil
           description = nil
         end

          question_id = question.id

          answer_created = Answer.new(description: description, question_id: question_id, is_correct: is_correct)

          next if answer_created.save!

          question.errors.full_messages.each do |msg|
           flash[:alert] = "#{flash[:alert]}<br> *#{msg}"
          end
          break
         end
        end
       else
        question.errors.full_messages.each do |msg|
         flash[:alert] = "#{flash[:alert]}<br> *#{msg}"
        end
        redirect_back(fallback_location: edit_admin_course_section_path(@course, @section))
       end
      end
      flash[:notice] = 'Cambios realizados exitosamente' if flash[:alert].nil?
      redirect_to edit_admin_course_section_path(@course, @section)

    else
      redirect_back(fallback_location: edit_admin_course_section_path(@course, @section))
      @test.errors.full_messages.each do |msg|
       flash[:alert] = "#{flash[:alert]}<br> *#{msg}"
      end
    end
   end
  end
 end

 def edit; end

 def destroy

   Test.destroy(@test)
   flash[:notice] = "Examen eliminado exitosamente"
   redirect_to edit_admin_course_section_path(@course, @section)
 end


 def simple
  @val = 1
  @type = 'radio'
  respond_to do |format|
   format.js do
    render '/admin/tests/type_question'
   end
  end
 end

 def multiple
  @val = 2
  @type = 'checkbox'

  respond_to do |format|
   format.js do
    render '/admin/tests/type_question'
   end
  end
 end

 def true_false
  @val = 3
  @type = 'radio'

  respond_to do |format|
   format.js do
    render '/admin/tests/type_question'
   end
  end
 end

 def redaction
  @val = 4
  @type = 'input'

  respond_to do |format|
   format.js do
    render '/admin/tests/type_question'
   end
  end
 end


 def average


   @dotest = DoTest.where(test_id: params[:test_id], active: 1).select(:do_course_id).distinct
   @dotest_last= Array.new
   @section = Section.find_by(id: params[:section_id])
   @test = Test.find_by(section_id: @section.id)
   @approved_users = Hash.new
   @reprobed_users = Hash.new
   @counter = 0


   @dotest.each do |dt|
     user = DoCourse.find(dt.do_course_id).user
     user_last_test = user.last_test(@test,dt.do_course)
     if !user_last_test.nil?
       @counter += 1
       @dotest_last.push(user_last_test)

       if user_last_test.grade >= @test.min_grade
         @approved_users[dt] = user
       else
         @reprobed_users[dt] = user
       end
     end
   end

   gon.test = @test
   gon.dotest = @dotest_last
   gon.counter = @counter

 end

 def list_talent
   @test = Test.find(params[:test_id])
   @do_tests= @test.do_tests.where(grade: nil)
   @talents_info = Hash.new
   for do_test in @do_tests
     @talents_info[do_test.user] = do_test
   end
 end

  def manual_grade
    do_test = DoTest.find(params[:do_test])
    @test = Test.find(params[:test_id])
    user = do_test.user
    do_course = DoCourse.inscription(user,@course)

    if params[:aproved] == "true"
       grade = 20
       flash[:notice] = "Usuario aprobado"
       message = "Usted aprobó el examen del curso #{@course.name}"
    else
       grade = 0
       flash[:notice] = "Usuario reprobado"
       message = "Usted reprobó el examen del curso #{@course.name}"
    end

    url = course_section_test_result_path(@course,@section,@test,do_test,disabled: true)
    do_test.grade = grade

    all_topic()
    if @test.required == 1
      if @test.is_the_last?(@tests_in_course)
        if grade >= @test.min_grade
          do_course.finished_at = Date.today
          do_course.save
          message = "Aprobó el curso #{@course.name}"
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
            message = "Reprobó el curso #{@course.name}"
            url = course_path(@course)
            do_course.save
          end
        end
      end
    end

    Notification.broadcast(user.id, message, url)
    do_test.save!
    redirect_to admin_course_section_test_list_talent_path(@course, @section,@test)

  end

 private

 def get_object_id
  @id = params[:object_id]
 end

 def test_params
  params.require(:test).permit(:auto,:required, :attemps_limits, :time_limit, :min_grade,:deadline, :start_date, :description, questions_attributes: [:description,:points, :type_question_id, answers: [], answers_correct: []])
 end

 def is_active_course

   if !@course.closed?
     yield
   else
     flash[:alert] = "No se puede modificar o eliminar un examen mientras el curso está activo"
     redirect_to edit_admin_course_section_path(@course, @section)
   end
 end

 def check_test_update
   @test.section_id
 end

 def find_test
   @test = Test.find(params[:id])
   if @course.disabled?
     yield
   else
     flash[:alert] = "Acción no permitida, el curso esta activo"
     redirect_to edit_admin_course_section_path(@course, @section)
   end
 end

 def find_section
  @section = Section.find(params[:section_id])
 end

 def set_javascript_date
   gon.start_date_course_attr = @course.start_date
   gon.deadline_course_attr = @course.deadline_course
 end

end
