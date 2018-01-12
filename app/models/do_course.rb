class DoCourse < ApplicationRecord
  belongs_to :course
  belongs_to :user
  has_many :do_tests, dependent: :destroy


  def self.is_enroll_in_course?(course,current_user)
    if find_by(user_id: current_user.id, course_id: course.id,enroll: 1).nil?
      false
    else
      true
    end
  end

  def self.get_current_enroll(user_id,course_id)
    find_by(enroll: 1, user_id: user_id, course_id: course_id)
  end

  # Si paso el curso sin fallar
  def self.approved_enroll?(current_user,course)
    approved = DoCourse.where(user_id: current_user.id, course_id: course.id, failed: 0,enroll: 1).where.not(finished_at: nil)
    if  !approved.empty?
      true
    else
      false
    end
  end

  def self.approved?(current_user,course)
    approved = DoCourse.where(user_id: current_user.id, course_id: course.id, failed: 0).where.not(finished_at: nil)
    if  !approved.empty?
      true
    else
      false
    end
  end

  # Si paso el curso sin importar si fallo o no
  def self.finished?(current_user,course)
     finished = DoCourse.where(user_id: current_user.id, course_id: course.id).where.not(finished_at: nil)
    if  !finished.empty?
      true
    else
      false
    end
  end

  def self.inscription(current_user,course)
    find_by(enroll: 1, user_id: current_user.id, course_id: course.id)
  end

end
