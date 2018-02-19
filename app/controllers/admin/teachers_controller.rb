class Admin::TeachersController < ApplicationController

  before_action :authenticate_medium_admin!
  before_action :find_course_in_section
  before_action :all_topic
  include SecurityTeacher
  around_action :check_teacher_ajax, except: [:index]

  def index
    gon.teachers = User.get_teachers(@course.id).to_json
    gon.users = User.get_not_teachers(@course.id).to_json
    gon.course_id = @course.id
  end

  def add
    HasTeacher.create(user_id: @user.id,course_id: @course.id)
  end

  def remove
    HasTeacher.find_by(user_id: @user.id,course_id: @course.id).destroy
  end

  private

  def check_teacher_ajax
    @user = User.find_by_id(params[:user_id])
    @course = Course.find_by_id(params[:course_id])
    if @user.is_at_least_medium_admin?
      yield
    else
      render head 500
    end
  end

end
