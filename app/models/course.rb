class Course < ApplicationRecord

  has_attached_file :cover, styles: {small: "100x100"},
  :path => ':rails_root/public/system/cover/:id_course/:style/:filename',
  :url => '/system/cover/:id_course/:style/:filename'
  validates_attachment_content_type :cover, content_type: ["image/jpeg" , "image/png"]

  Paperclip.interpolates :id_course do |attachment, style|
     "course_#{attachment.instance.id}"
  end

  validates :name, presence: true,  length: { minimum: 10 }


  belongs_to :category

  has_many :prelations
  has_many :sections

  #relacion entre cursos y tags
  has_many :has_tags
  has_many :tags, through: :has_tags

  #relacion entre usuario y curso (do_courses)
  has_many :do_courses

  #relacion entre usuario y curso (do_recomendation)
  has_many :do_recomendations

  #relacion entre usuario y curso (has_favorites)
  has_many :has_favorites

  #relacion entre curso y departamento
  has_many :course_has_departments
  has_many :departments, through: :course_has_departments

  #relacion entre usuario y curso (course_has_private_users)
  has_many :course_has_private_users

  has_many :multimedia_courses

  has_many :comment_courses

  include AASM

  aasm whiny_transitions: false do
      state :disabled, :initial => true
      state :active
      state :closed

      event :activate do
        transitions from: :disabled, to: :active
      end

      event :disable do
        transitions from: :active, to: :disabled
        transitions from: :closed, to: :disabled
      end

      event :close do
        transitions from: :active, to: :closed
      end

    end

  def self.search_admin(search)
     id_array =  Course.search_by_tag_admin(search)

     # ILIKE es para que no haga distincion entre mayusculas y minusculas
     where("name  ILIKE ? OR id IN (?)", "%#{search}%", id_array)

  end


  def self.search_user(search)
     id_array =  Course.search_by_tag_user(search)

     # ILIKE es para que no haga distincion entre mayusculas y minusculas
     where("(name  ILIKE ? OR id IN (?)) AND active = ?", "%#{search}%", id_array, '1')

  end

  def self.search_by_department_admin(search, department_id)
    # ILIKE es para que no haga distincion entre mayusculas y minusculas

    id_array = Course.search_by_tag_admin (search)

    department = Department.find(department_id)

    department.courses.where("name  ILIKE ? OR courses.id IN (?)", "%#{search}%", id_array)

  end

  def self.search_by_department_user(search, department_id)
    # ILIKE es para que no haga distincion entre mayusculas y minusculas

    id_array = Course.search_by_tag_user (search)

    department = Department.find(department_id)

    department.courses.where("(name  ILIKE ? OR courses.id IN (?)) AND active = ?", "%#{search}%", id_array, '1')

  end

  def self.search_by_scope_admin(search, scope, current_user)

    id_array = Course.search_by_tag_admin (search)

    if scope == '1'
      if search.empty?

        where("scoping = ? ", scope)
      else
          where("(name ILIKE ? OR id IN (?)) AND scoping = ? ", "%#{search}%",id_array, scope)
      end
    else
      scope = '3'

      if search.empty?


        where("scoping = ?",scope)
      else


          where("(name ILIKE ? OR courses.id IN (?)) AND scoping = 3","%#{search}%",id_array)
      end


    end


  end

  def self.search_by_scope_user(search, scope, current_user)

    id_array = Course.search_by_tag_user (search)

    if scope == '1'
      if search.empty?

        where("scoping = ? AND active = ?", scope, '1')
      else
          where("((name ILIKE ? OR id IN (?)) AND scoping = ?) AND active = 1", "%#{search}%",id_array, scope)
      end
    else
      scope = '3'

      if search.empty?
        where("scoping = ? AND active = 1",scope)
      else
        where("((name ILIKE ? OR courses.id IN (?)) AND active = 1) AND scoping = ?", "%#{search}%", id_array, scope)
      end


    end


  end


  def self.paginate(actual_page)
    page(actual_page).per(8)
  end

  def save_has_course(department_id)
    CourseHasDepartment.create(department_id: department_id, course_id: self.id)
  end
  def save_private_user(id_user)
    user = User.find(id_user)
    if (!user.nil?)
      CourseHasPrivateUser.create(course_id: self.id, user_id: id_user)
    end
  end

  def deadline_course_valid?

    if self.deadline_course.nil?
      true
    else
      if self.start_date <= self.deadline_course
        true
      else
        false
      end
    end
  end

  def start_date_valid?
    if self.start_date.nil?
      @message = "La Fecha de inicio no puede ser nula"
      false
    else
      if self.start_date >= Date.today
        true
      else
        @message = "La Fecha de inicio debe ser mayor a hoy"
        false
      end
    end
  end

  def deadline_inscription_valid?

    if self.deadline_inscription.nil?
      true
    else
      if !self.deadline_course.nil?
        if self.deadline_inscription > self.deadline_course
          return false
        end
      end
      true
    end
  end

  def dates_valid?

    if self.start_date_valid?
      if self.deadline_course_valid?
        if self.deadline_inscription_valid?
          return true
        end
      end
    end

    false
  end

  def dates_invalid_message

    if self.start_date_valid?
      if self.deadline_course_valid?
        if !self.deadline_inscription_valid?
          message  = "La fecha de inscripción no puede ser mayor que la de finalización"
        end
      else
        message = "La fecha de finalización no puede ser menor que la de inicio"
      end
    else
      message = @message
    end

    message
  end

  def all_users_enrolled
    DoCourse.where(course_id: self.id, enroll: 1)
  end


  def finished?
    if !self.deadline_course.nil?
      if DateTime.now > self.deadline_course
        return true
      end
    end
    false
  end


  def inscription_finished?
    if !self.deadline_inscription.nil?
      if DateTime.now > self.deadline_inscription + 1.day
        return true
      end
    end
    false
  end


  private



  def self.search_by_tag_admin (search)
    tags = Tag.search(search)

    courses = Course.none
    id_array = Array.new

    # Se recorren todos los tags que se encontraron con respecto a la bsuqueda del usuario
    tags.each do |tag|

        # Se toma solo los id de los cursos que poseen los cada tag
        if id_array.empty?
          relation = tag.courses.select(:id)
        else
          relation = tag.courses.where("courses.id NOT IN (?)",id_array).select(:id)
        end

        unless relation.empty?
          courses = courses.or(relation)

          courses.each do |c|
            id_array.push(c.id)
          end
        end

      end

    # # Se eliminan cursos iguales
    # courses = courses.distinct.to_a
    # courses.each do |c|
    #   id_array.push(c.id)
    # end

    return id_array
  end

  def self.search_by_tag_user (search)
    tags = Tag.search(search)

    courses = Course.none
    id_array = Array.new

    # Se recorren todos los tags que se encontraron con respecto a la bsuqueda del usuario
    tags.each do |tag|

      # Se toma solo los id de los cursos que poseen los cada tag
      if id_array.empty?
        relation = tag.courses.where("active = 1").select(:id) #TODO cambiar por aasm_state?
      else
        relation = tag.courses.where("(courses.id NOT IN (?)) AND active = 1",id_array).select(:id) #TODO igual aqui
      end

      unless relation.empty?
        courses = courses.or(relation)

        courses.each do |c|
          id_array.push(c.id)
        end
      end

    end

    # # Se eliminan cursos iguales
    # courses = courses.distinct.to_a
    # courses.each do |c|
    #   id_array.push(c.id)
    # end

    return id_array
  end



end
