
class CourseHasDepartment < ApplicationRecord
  belongs_to :department
  belongs_to :course
end
