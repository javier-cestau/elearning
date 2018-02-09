# coding: utf-8
	class User < ApplicationRecord
	 include  Constant::StateEnroll

	validates :privilege, presence: true
	# validates :name, presence: true, numericality: false ,length: { minimum: 5 }
	# validates :position, presence: true

	has_attached_file :photo, styles: {small: ["128x128",:jpg], thumb: ["60x60",:jpg]},
	:convert_options => {
	:all => '-background white -flatten +matte'
},
	:path => ':rails_root/public/system/users_profile/:id_user/:style/:filename',
	:url => '/system/users_profile/:id_user/:style/:filename'
	validates_attachment_content_type :photo, content_type: ["image/jpeg" , "image/png"]

	Paperclip.interpolates :id_user do |attachment, style|
		 "user_#{attachment.instance.id}"
	end

	devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

 devise :omniauthable, omniauth_providers: [:facebook,:google_oauth2]

	belongs_to :department

	#relacion entre usuario y curso (do_courses)
	has_many :do_courses ,  dependent: :destroy


	#relacion entre usuario y curso(do_recomendation)
	has_many :do_recomendations ,  dependent: :destroy

	#relacion entre usuario y curso (has_favorites)
	has_many :has_favorites ,  dependent: :destroy


	#relacion entre usuario y examenes
	has_many :do_tests,   dependent: :destroy
	has_many :tests, through: :do_tests

	#relacion entre usuario y planilla
	has_many :do_templates
	has_many :templates, through: :do_templates

	#relacion entre usuario y curso (course_has_private_users)
	has_many :course_has_private_users


	has_many :comment_courses
	has_many :comment_sections

	has_many :notifications

	 def self.new_with_session(params,session)
		 if session["devise.user_attributes"]
			 new(session["devise.user_attributes"], without_protection: true) do |user|
				 user.attributes = params
				 user.valid?
			 end
		 else
			 super
		 end
	 end


	 def self.search (option, searching_for)
		 searching_by = "name"

		 if option == "0"
			 searching_by = "name"
		 end
		 if option == "1"
			 searching_by = "email"
		 end


			where("#{searching_by} ILIKE ? ", "%#{searching_for}%")
		 #code
	 end



		def self.search_index (option, searching_for, page,scoping)
			searching_by = "name"

			if option == "0"
				searching_by = "name"
			end
			if option == "1"
				searching_by = "email"
			end

			if scoping
				where("#{searching_by} ILIKE ? ", "%#{searching_for}%").order("#{searching_by} ASC").page(page).per(10)
			else
				where("#{searching_by} ILIKE ?  AND privilege = 1", "%#{searching_for}%").order("#{searching_by} ASC").page(page).per(10)
			end
		end
	#  Comprobar niveles del usuario
	# Al comprobar un nivel bajo se comprueban los demas niveles tambien
 def is_employed?
	 self.privilege == 1
 end
 def is_medium_admin?
	 self.privilege == 2
 end

 def is_at_least_medium_admin?
	 self.privilege >= 2
 end

 def is_super_admin?
	 self.privilege >= 3
 end

 def self.auth_creation(auth)

	 password =  BCrypt::Password.create("#{auth.uid}")

	 where(email: auth.email).first_or_create do |user|
		 user.provider = auth.provider
		 user.uid = auth.uid
		 user.email = auth.info.email
		 if !auth.info.image.empty?
			 user.photo = auth.info.image+"?type=normal"
		 end
		 user.privilege = "1"
		 user.password = password
		 user.department_id = Department.first.id
		 user.save
	 end
 end


 def self.get_system_privileges
	 privilege = [["Empleado",1],["Administrador intermedio", 2],["Administrador general", 3]]
 end

 def last_test(test,docourse)


	#Si realizó todos los intentos posibles
	if test.attemps_limits == docourse.do_tests.where(test_id: test.id).count

		#  Automaticamente devuelve el ultimo examen que realizó el usuario
		DoTest.where(test_id: test.id, do_course_id: docourse.id).last

	else

		#Si no hizo todos los intentos posibles, es necesario saber si aprobo alguno
		#pero los examenes reprobados no importan porque aun quedan intentos

		#Por eso se pide el último examen, ya que cuando se aprueba un examen no se puede volver a hacer
		 dt = DoTest.where(test_id: test.id, do_course_id: docourse.id).last
			#Se evalua si en ese ultimo intento que realizó se aprobó el examen o no
			if dt.grade >= test.min_grade
				#Si lo aprobó, se devuelve el examen
				return dt
			end

		end

	end


	def can_enroll?(course)
		if !DoCourse.is_enroll_in_course?(course,self)

			approved_all = true

			if course.prelation == 1
				Prelation.where(course_id: course.id).each do |pre|
					course_pre = Course.find_by(id: pre.prelated_by)
					if !DoCourse.approved?(self,course_pre)
						approved_all = false
						break
					end
				end
			end

			if approved_all
				if course.scoping == 1
					Constant::StateEnroll::Active
				else
					if course.scoping == 2
						# Se evalua si el curso esta disponible para su programa
						if !course.departments.where(id: self.department_id).empty?
							Constant::StateEnroll::Active
						else
							Constant::StateEnroll::CanNotDepartment
						end
					else
						# Se evalua si el curso tiene añadido al usuario en su lista de usuarios privados
						course.course_has_private_users.each do |relation|
							if relation.user.email == self.email
								return Constant::StateEnroll::Active
							end
						end
						Constant::StateEnroll::CanNotPrivate
					end
				end
			else
				Constant::StateEnroll::CanNotPrelation
			end
		else
			Constant::StateEnroll::AlreadyEnroll
		end
	end
end
