# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require_relative 'functions'
@five =  5

# Se crea diferentes departamentos



template = Template.where(name: "Planilla").first_or_create! do |t|
            t.name = "Planilla 2017"
             puts "Planilla creada"
            end

department_array = ["Mercadeo & ventas","Cadena de suministro","Gth", "Servicios legales", "Servicios generales", "Control y gestión","Contraloría","Tesorería"]
contador_departamento = 0
@department = Array.new
department_array.each do |department|
    d = Department.where(name: department).first_or_create! do |depart|
          depart.name =  department
        end
    @department.push(d)
    HasTemplate.create!(template_id: template.id, department_id: @department.at(contador_departamento).id)
     contador_departamento += 1
end

 puts "Departamentos creados"



                      # Los 3 tipos de Survey

                      @survey_corto = TypeSurvey.where(id: 1).first_or_create! do |type|
                        type.name = "Respuesta corta"
                        type.sequence = 1
                        type.id = 1
                         puts "Tipo de survey corto creado"
                      end
                      @survey_redaccion = TypeSurvey.where(id: 2).first_or_create! do |type|
                        type.name = "De redacción"
                        type.sequence = 2
                        type.id = 2
                        puts "Tipo de survey de redaccion creado"
                      end

                      @survey_simple = TypeSurvey.where(id: 3).first_or_create! do |type|
                        type.name = "Selección simple (Si/No)"
                        type.sequence = 3
                        type.id = 3
                        puts "Tipo de survey de seleccion simple creado"
                      end

                      @survey_lista = TypeSurvey.where(id: 4).first_or_create! do |type|
                        type.name = "Selección múltiple"
                        type.sequence = 4
                        type.id = 4
                        puts "Tipo de survey de seleccion multiple creado"
                      end

                      @question_simple = TypeQuestion.where(id: 1).first_or_create! do |type|
                        type.name = "Selección Simple"
                        type.sequence = 1
                        type.id = 1
                         puts "Tipo de pregunta de examen selección simple"
                      end
                      @question_multiple = TypeQuestion.where(id: 2).first_or_create! do |type|
                        type.name = "Selección multiple"
                        type.sequence = 2
                        type.id = 2
                        puts "Tipo de pregunta de examen seleccion multiple"
                      end

                      @question_vf = TypeQuestion.where(id: 3).first_or_create! do |type|
                        type.name = "Verdadero o falso"
                        type.sequence = 3
                        type.id = 3
                        puts "Tipo de pregunta de examen verdadero o falso"

                      end




              # Las 3 cuentas principales


              email_admin = "admin@grupoleiros.com"
              email_medium_admin = "medium_admin@grupoleiros.com"
              email_empleado = "empleado@grupoleiros.com"
              email_inscrito = "inscrito@grupoleiros.com"

              User.where(email: "admin@grupoleiros.com").first_or_create! do |user|

                 user.email = "admin@grupoleiros.com"
                 user.password = "123456789123456789"
                 user.department_id = @department.at(5).id
                 user.privilege = 3
                 user.management = "Gerente"
                 user.position = "Gerente"
                 user.name = "Grupo Leiros admin"
                 user.state = 1
                  puts "Super admin creado!"
              end


                random_index_department = Faker::Number.between(0, contador_departamento-1)
                User.where(email: email_medium_admin).first_or_create! do |user|

                 user.email = email_medium_admin
                 user.password = "123456789123456789"
                 user.department_id = @department.at(0).id
                 user.privilege = 2
                 user.management = "Gerente"
                 user.position = "Desarrollador"
                 user.name = "Grupo Leiros medium admin"
                 user.state = 1
                 puts "Medium admin creado!"
               end


                 random_index_department = Faker::Number.between(0, contador_departamento-1)
                User.where(email: email_empleado).first_or_create do |user|

                 user.email = email_empleado
                 user.password = "123456789123456789"
                 user.department_id = @department.at(1).id
                 user.privilege = 1
                 user.management = "Gerente"
                 user.position = "Recepcionista"
                 user.name = "Grupo Leiros empleado"
                 user.state = 1
                  puts "Empleado creado!"
                end

                random_index_department = Faker::Number.between(0, contador_departamento-1)
               User.where(email: email_inscrito).first_or_create do |user|

                user.email = email_inscrito
                user.password = "123456789123456789"
                user.department_id = @department.at(1).id
                user.privilege = 1
                user.management = "Gerente"
                user.position = "Recepcionista"
                user.name = "inscrito empleado"
                user.state = 1
                 puts "Inscrito empleado creado!"
               end



categories= Array.new

categories.push("Arte")
categories.push("Tecnología")
categories.push("Lógica")
categories.push("Derecho")

@categories_id = Array.new
categories_name = Array.new

contador = 0
categories.each do |category|

  contador += 1
   c = Category.where(name: category).first_or_create! do |c|
     c.name = category
     if contador == categories.length
       puts "Categorias creadas"
     end
   end
  @categories_id.push(c)
  categories_name.push(c.name)

end


 # Surveys asociados al unico template

 contador = 1


@template = template
admin = User.find_by_email(email_admin)
@admin = admin


 contador = 1

# Pregunta 1
question = "¿Cuál cree usted que son sus fortalezas?"
answer= "Todas"
type = 1 # 1  = redaccion, 2 = simple , 3 = corto
required = 1 # 0  = no requerido , 1 = requerido

create_question(question,answer,type,contador,required)
contador += 1


# Pregunta 2
question =  "¿Cuál cree usted que son sus debilidades?"
answer= "Ninguna"
type = 1 # 1  = redaccion, 2 = simple , 3 = corto
required = 1 # 0  = no requerido , 1 = requerido

create_question(question,answer,type,contador,required)
contador += 1


# Pregunta 3
question =  "¿En que aspecto cree que puede mejorar?"
answer= "No me hace falta"
type = 1 # 1  = redaccion, 2 = simple , 3 = corto
required = 1 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 4
question =  "De los logros que ha conseguido alcanzar hasta hoy ¿Cuál le gustaría mencionar?"
answer= ""
type = 1 # 1  = redaccion, 2 = simple , 3 = corto
required = 0 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 5
question =  "¿Como se ve en 5 años en adelante?"
answer= "De gerente en la empresa"
type = 1 # 1  = redaccion, 2 = simple , 3 = corto
required = 0 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 6
question =  "¿Le gustaría formar parte de nuestras olimpiadas?"
answer= "Si"
type = 2 # 1  = redaccion, 2 = simple , 3 = corto
required = 1 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 7
question =  "Dentro de la organización ¿Qué cargo le gustaría ocupar?"
answer= "Programador en jefe"
type = 3 # 1  = redaccion, 2 = simple , 3 = corto
required = 0 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 8
question =  "¿Ha realizado alguna capacitación interna?"
answer= "No"
type = 2 # 1  = redaccion, 2 = simple , 3 = corto
required = 0 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1

# Pregunta 9
question =  "¿Ha realizado alguna capacitación externa?"
answer= "Si"
type = 2 # 1  = redaccion, 2 = simple , 3 = corto
required = 0 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required)
contador += 1


# Pregunta 10
question =  "Seleccione aquellas opciones que haya culminado"
answer= ["Primaria","Secundaria","Técnico","Universidad","Master"]
type = 4 # 1  = redaccion, 2 = simple , 3 = corto, 4 = multiple
required = 1 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required,[0,1,3])
contador += 1


# Pregunta 11
question =  "Seleccione las categorias de su interes"
answer= categories_name
type = 4 # 1  = redaccion, 2 = simple , 3 = corto, 4 = multiple
required = 1 # 0  = no requerido , 1 = requerido
create_question(question,answer,type,contador,required,[0,1])
contador += 1

user_array = []
puts "#{contador}".yellow+" preguntas fueron creados"

if User.count < 20
  ten = 10
  # Cuentas falsas
  ten.times do
       random_index = Faker::Number.between(0, contador_departamento-1)
       name =  "Seed "
       name +=  Faker::Name.first_name
       name += " "+Faker::Name.last_name
       email = Faker::Internet.user_name+"@grupoleiros.com"

       created = false

       u = User.where(email: email).first_or_create! do |user|

        user.email = email
        user.password = "123456789"
        user.department_id = @department.at(random_index).id
        user.privilege = Faker::Number.between(1,3)
        user.management = "Gerente"
        user.position = "Desarrollador"
        user.state = 1
        user.name = name

        user.save!
        created = true
      end
      user_array.push(u)
      if !created
        ten += 1
      end
  end

  puts 'Diez(10) usuarios falsos creados'
end





              @admin = User.find_by_email(email_admin)
              @medium_user = User.find_by_email(email_medium_admin)
              @normal_user = User.find_by_email(email_empleado)

              puts "-------------------------------------------------------------".yellow
              puts "----------------Creacion de los cursos-----------------------".yellow
              puts "-------------------------------------------------------------".yellow

              require_relative "create_course"

              puts ""

              Category.all.each do |ca|
                puts " Hay "+"#{ca.courses.count}".red+" cursos en la categoria '"+"#{ca.name}".yellow+"'"
              end

              puts ""
              prelation(@course_2,@course_1)
              prelation(@course_8,@course_7)
              prelation(@course_9,@course_2)




              puts "-------------------------------------------------------------".yellow
              puts "----------------Creacion de las secciones-+------------------".yellow
              puts "-------------------------------------------------------------".yellow
              puts ""

              require_relative 'sections_creation'
              puts ""

              puts "-------------------------------------------------------------".yellow
              puts "----------------Inscripción de los usuarios------------------".yellow
              puts "-------------------------------------------------------------".yellow


               enroll_user(admin,@course_1, 0,@course_1.nil,1) #Aprueba el curso 1
               enroll_user(admin,@course_2,1,@course_2.deadline_course,1) #Reprueba el curso 2
               enroll_user(admin,@course_3,0,@course_3.deadline_course,1) #Aprueba el curso 3
               enroll_user(admin,@course_4,1,@course_4.deadline_course,1) #Reprueba el curso 4
               enroll_user(admin,@course_5,nil,nil,1) #Inscrito en el curso 5
               enroll_user(admin,@course_6,0,@course_6.start_date + 20,1) #Aprueba el curso 6
               enroll_user(admin,@course_7,nil,nil,1) #Inscrito en el curso 7
               enroll_user(admin,@course_8,1,@course_8.deadline_course,1) #Reprueba el curso 8
               enroll_user(admin,@course_9,1,@course_8.deadline_course,1) #Reprueba el curso 9
               enroll_user(admin,@course_9,0,@course_8.deadline_course,1) #Aprueba el curso 9


              # enroll_user(normal_user,@course_1,0,@course_2.nil,1) #Aprueba el curso 2
              # enroll_user(normal_user,@course_4,nil,nil,1) #Inscrito en el curso 4
              # enroll_user(normal_user,@course_5,nil,nil,1) #Inscrito en el curso 5
              # enroll_user(normal_user,@course_6,0,@course_6.start_date + 20,1) #Aprueba el curso 6
              # enroll_user(normal_user,@course_8,nil,nil,1) #Inscrito en el curso 8
              # enroll_user(normal_user,@course_9,1,@course_9.deadline_course,1) #Reprueba el curso 9



              inscrito = User.find_by_email(email_inscrito)

              # Para que se muestre en el grafico las cantidades de personas inscritas
              if DoCourse.count < 50
                counter = 1
                150.times do
                  # El reporte de inscripciones toma tanto como enroll 0 y 1
                  DoCourse.create(id: counter,course_id: Faker::Number.between(3,5), user_id: user_array.at(Faker::Number.between(0,9)).id,enroll: Faker::Number.between(0,1),  start_date: Faker::Date.between(3.years.ago, Date.today), failed: 0)
                  counter += 1
                end

                puts "Se inscribieron los usuarios para el reporte"
              end


            rows = DoCourse.all.count+1

            ActiveRecord::Base.connection.execute("ALTER SEQUENCE do_courses_id_seq RESTART WITH #{rows}")


            Course.all.each do |c|
              if c.active == 1
                c.day_counter_update = Date.today
                c.save
              end
            end
