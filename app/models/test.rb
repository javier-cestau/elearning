class Test < ApplicationRecord
  acts_as_paranoid
  validates :description, presence: true,  length: { minimum: 20 }
  validates :min_grade ,  numericality: { less_than_or_equal_to: 20,  only_integer: true,message:"Debe tener un nota para aprobar el examen" }



  validates :start_date,
    date: {
            allow_blank: true,
            before_or_equal_to: Proc.new{|obj|
              if !obj.deadline.nil?
                obj.deadline
              else
                obj.start_date + 1.day
              end
            }

          }

  validates :deadline,
            date:{
                  allow_blank: true,
                  after_or_equal_to: Proc.new{|obj|
                    if !obj.start_date.nil?
                      obj.start_date
                    else
                      obj.deadline
                    end
                  },
                  }



  belongs_to :section
  has_many :questions

  #relacion entre usuario y examenes
  has_many :do_tests
  has_many :users , through: :do_tests
  accepts_nested_attributes_for :questions

  def self.destroy(t)
    do_test = DoTest.find_by(test_id: t.id)
    if do_test.nil?
     #  Para no preservar basura en la base de datos
     # Solo si un usuario ha realizado el examen no se borrar completamente d ela base de datos
      Question.where(test_id: t.id).each do |q|
        Answer.where(question_id: q.id).destroy_all
        q.destroy
      end
      t.really_destroy!
      # true cuando lo destruye de verdad
      true
    else
      t.destroy
      false
      # false cuando no lo destruye de verdad
    end
  end

  def can_do_it?(tests_in_course,do_course)

    unless do_course.nil?
      # Si ya aprobastes el examen no puedes volver a hacerlo
      do_tests = do_course.do_tests.where(test_id: self.id)
      do_tests.each do |do_t|
        if do_t.grade > self.min_grade
          return false
        end
      end

      # Solo se evalua si el examen es obligatorio
      if self.required == 1
        # buscar el indice del examen
        index_test = tests_in_course.find_index(self)

        # Se evalua solo si el examen no es el primero
        if (index_test - 1 ) != -1
          # Se analiza si el examen anterior se realizó


          # Se busca que el examen anterior que sea obligatorio
          while index_test != -1
            index_test -= 1
            if index_test != -1
              prev_test = tests_in_course[index_test]
              if prev_test.required == 1
                break
              end
            end
          end

          # Se toma el ultimo examen que hizo el usuario que deberia ser el que aprobo si es que aprobo
          do_test = do_course.do_tests.where(test_id: prev_test.id).last

          # Si es diferente a uno significa que encontro un examen obligatorio
          if index_test != -1
            if !do_test.nil?
              # Evaluan si el usuario aprobo el examen anterior
              if do_test.grade < prev_test.min_grade
                return false
              end
            else
              return false
            end
          end
        end
      end

      true
    else
      false
    end
  end

  def is_the_last?(tests_in_course)

    index_test = tests_in_course.find_index(self)
    total = tests_in_course.count-1
    tests_in_course[index_test+1..total].each do |t|
      if t.required == 1
        return false
      end
    end
  
    true
  end

  def amount_of_try(do_course_id)
    DoTest.where(do_course_id: do_course_id,test_id: self.id).count
  end

end
