def multiple_choises(posible_responses,survey_id,answers,response_id)
  counter = 0
  posible_responses.each_with_index do |r,index|
    choise = Choise.create(description: r,survey_id: survey_id)
    if answers[counter] == index
      HasChoise.create(choise_id: choise.id, response_id: response_id)
    end
    counter += 1
  end


end

def create_question(question,answer,type,contador,required,answer_choises = [])

   if type == 1
     type = @survey_redaccion.id
   elsif type == 2
     type = @survey_simple.id
   elsif type == 3
     type = @survey_corto.id
   else
     posible_responses = answer
     answer = ""
     type = @survey_lista.id
   end

   survey = Survey.create!(
   description: question,
   type_survey_id: type,
   sequence: contador,
   template_id: @template.id,
   required: required
   )


  response = Response.create!(description: answer)

  if type == 4
    multiple_choises(posible_responses, survey.id,answer_choises,response.id)
  end
  @template.do_templates.create!(sequence: 1, user_id: @admin.id, survey_id: survey.id, response_id: response.id)

end

def enroll_user(current_user,course,failed, finish,enroll)


	start_date = course.start_date + 10

	finished_at = nil

	if !finish.nil?
		finished_at = finish - 10
	end


	DoCourse.create!(user_id: current_user.id, start_date: start_date, finished_at: finished_at, course_id: course.id, enroll: enroll, failed: failed)
	puts ""
	puts "El usuario '"+"#{current_user.email}".yellow+"' fue inscrito en el curso '"+"#{course.name}".green+"'"
end

def create_section (name,father,state,description,course_id,url)
  section = Section.create!(name: name,prv_section: father,course_id: course_id)

  if !section.id.nil?
    puts "Sección "+"#{name}".green+" creada!"
  end

  if !url.empty?
    begin
      multimedia = create_image_section(url,section)
      image_name = multimedia.image_file_name
      image_id = multimedia.id.to_s

      section_id = section.id.to_s
      description = description.sub 'section_id', section_id
      description = description.sub 'image_id', image_id
      description = description.sub 'image_name', image_name
    rescue
      puts "Error cargando imagen en #{section.name}"
    end
  end

  section.description = description
  section.save!
  return section

end


def create_course (name,scoping,prelation,active,category_id,start_date,deadline_course,deadline_inscription,description,url,url_cover)
  course = Course.where(name: name).first_or_create! do |course|
      course.name = name
      course.scoping = scoping
      course.prelation = prelation
      course.active = active
      course.category_id = category_id
      course.start_date = start_date
      if active == 1
        day_counter_update = Date.today
      end
      course.deadline_course = deadline_course
      course.deadline_inscription = deadline_inscription
      if !url_cover.empty?
        course.cover = URI.parse(url_cover)
      end
      puts ""
      puts "Curso "+"#{name}".green+" creado!"
  end

  if !course.cover.nil?
    puts " |"
    puts " |--Portada cargada!"
  end

  if !url.empty?

    begin
      multimedia = create_image(url,course)
      image_name = multimedia.image_file_name
      image_id = multimedia.id.to_s
      course_id = course.id.to_s
      description = description.sub 'course_id', course_id
      description = description.sub 'image_id', image_id
      description = description.sub 'image_name', image_name
    rescue
      puts "Error al crear la imagen  #{course.name}"
    end
  end
  course.description = description
  course.save
  return course
end

def create_image(url,course)
  @multimedia = MultimediaCourse.new
  @multimedia.image =  URI.parse(url)
  @multimedia.course_id = course.id
  @multimedia.save!
  @multimedia.destroy_image_original
  puts " |"
  puts " |--Imagen de la descripción creada!"
  return @multimedia
end

def create_image_section(url,section)
  begin
    @multimedia = MultimediaSection.new
    @multimedia.image =  URI.parse(url)
    @multimedia.section_id = section.id
    @multimedia.save!
    @multimedia.destroy_image_original
    puts "  |"
    puts "  |--Imagen de la sección creada!"
    return @multimedia
  rescue
    puts "Error cargando imagen en la descripcion de #{section.name}"
  end
end

def create_tag (name_tags,course)
  imprimir_espacio = true

  name_tags.each do |name|
    tag = Tag.where(name: name).first_or_create! do |tag|
      tag.name = name
    end


    HasTag.where(tag_id: tag.id,course_id: course.id).first_or_create! do |r|
      r.tag_id = tag.id
      r.course_id = course.id
      puts " |"
      puts " |--Tag '"+"#{name}".yellow+"' agregado"
    end
  end
end

def prelation(c1,prelation_c)

    Prelation.where(course_id: c1.id, prelated_by: prelation_c.id).first_or_create do |pre|
      pre.course_id =  c1.id
      pre.prelated_by = prelation_c.id
      puts "Aviso:".red+" El curso '"+"#{c1.name}".green+"' es prelado por '"+"#{prelation_c.name}'".green+"'"
    end

end

def create_relation_private_course(course,user)

  CourseHasPrivateUser.where(course_id: course.id, user_id: user.id).first_or_create do |r|
    r.course_id = course.id
    r.user_id = user.id
    puts (" |")
    puts (" |-- El usuario '"+"#{user.name}".yellow+"' fue invitado en el curso ")
  end
end

def create_relation_department_course(course,departments)

  departments.each do |department|

    CourseHasDepartment.where(course_id: course.id, department_id: department.id).first_or_create do |r|
      r.course_id = course.id
      r.department_id = department.id
      puts (" |")
      puts (" |-- El departmento '"+"#{department.name}".yellow+"' fue vinculado al curso ")
    end
  end
end
