class WelcomeController < ApplicationController

    # skip_before_action :redirect_to_fill_profile, only: [:profile]

    def index
    @recomendation_courses = Array.new
    if user_signed_in?


      # response_id = DoTemplate.where(user_id: current_user.id).last.response_id
      # responses = HasChoise.where(response_id: response_id)
      # # Tomar todos los cursos realizados por el usuario
      course_by_the_user = current_user.do_courses

      courses_id_by_user = Array.new

      course_by_the_user.each do |c|

        courses_id_by_user.push(c.course_id)
      end

      no_active_course = Course.where("active = 0 OR '#{Date.today}' >= deadline_course OR '#{Date.today}' >= deadline_inscription  ")

      no_active_course.each do |c|

        if courses_id_by_user.find_index(c.id) == nil
          courses_id_by_user.push(c.id)
        end
      end

      # Recomendacion por planilla
      # Se obtienen las respuestas del usuario en la planilla
      @recomendation_courses = Array.new
      @counter_recomendation_array = Array.new
      # responses.each do |r|
      #   # Se obtiene la categorias segun la respuesta
      #   category  = Category.find_by_name(r.choise.description)
      #   if !category.nil?
      #
      #     # Se obtienen los cursos que posean la categoria y los que el usuario no este inscrito
      #     course = Course.where(category_id: category.id, scoping: 1).where.not(id: courses_id_by_user)
      #
      #     if @recomendation_courses.length < 6
      #       counter = @recomendation_courses.length
      #     else
      #       counter = 0
      #     end
      #     # Se recorren dichos cursos
      #     course.each do |c|
      #
      #
      #       # Se toma la cantidad de recomendaciones que tiene
      #       counter_recomendation =  DoRecomendation.where(course_id: c.id).count
      #
      #       if @recomendation_courses.length < 6
      #
      #         @recomendation_courses[counter] = c
      #         @counter_recomendation_array[counter] = counter_recomendation
      #       else
      #         # Tomar el index y el valor de recomendacion del que posea menor recomendaciones
      #         index = @counter_recomendation_array.each_with_index.min[1]
      #         value = @counter_recomendation_array.each_with_index.min[0]
      #         if counter_recomendation > value
      #           @recomendation_courses[index] = c
      #           @counter_recomendation_array[index] = counter_recomendation
      #
      #         end
      #       end
      #       counter += 1
      #     end
      #   end
      # end


      @recomendation_courses.each do |course|
        courses_id_by_user.push(course.id)
      end


      # Cursos por departamento
      relation_courses_to_department = CourseHasDepartment.where(department_id: current_user.department_id).where.not(course_id: courses_id_by_user)

      courses_id = Array.new

      relation_courses_to_department.each do |relation|
        courses_id.push(relation.course_id)
      end


      courses = Course.where(id: courses_id)

      if @recomendation_courses.length < 6
          counter = @recomendation_courses.length
      else
        counter = 1
      end



      # Se recorren dichos cursos(por departamento)
      courses.each do |c|


        # Se toma la cantidad de recomendaciones que tiene
        counter_recomendation =  DoRecomendation.where(course_id: c.id).count

        if @recomendation_courses.length < 6
          @recomendation_courses[counter] = c
          @counter_recomendation_array[counter] = counter_recomendation
        else
          # Tomar el index y el valor de recomendacion del que posea menor recomendaciones
          index = @counter_recomendation_array.each_with_index.min[1]
          value = @counter_recomendation_array.each_with_index.min[0]
          if counter_recomendation > value
            # Para que no sustituya al primer cursos dado por la planilla
            if index >= 1

              @recomendation_courses[index] = c
              @counter_recomendation_array[index] = counter_recomendation
              index_id = courses_id_by_user.find_index(c)
              courses_id_by_user[index_id] = c
              courses_id_by_user(c.id)
            end
          end
        end
        counter += 1
      end


      if @recomendation_courses.length < 6
        counter = @recomendation_courses.length
      else
        counter = 3
      end
      # Cursos realizados
      current_user.do_courses.each do |course_rel|

       index_id = courses_id_by_user.find_index(course_rel.course.id)
       if index_id == nil
      # Se toma la cantidad de recomendaciones que tiene
         counter_recomendation =  DoRecomendation.where(course_id: course_rel.course.id).count

         if @recomendation_courses.length < 6

           @recomendation_courses[counter] = course_rel.course
           @counter_recomendation_array[counter] = counter_recomendation
         else
           # Tomar el index y el valor de recomendacion del que posea menor recomendaciones
           index = @counter_recomendation_array.each_with_index.min[1]
           value = @counter_recomendation_array.each_with_index.min[0]
           if counter_recomendation > value
             if index >= 3

               @recomendation_courses[index] = course_rel.course
               @counter_recomendation_array[index] = counter_recomendation
               index_id = courses_id_by_user.find_index(course_rel.course)
               courses_id_by_user[index_id] = course_rel.course
               courses_id_by_user(course_rel.course.id)
             end
           end
         end
         counter += 1
       end
      end

      if @recomendation_courses.length < 6
        counter = @recomendation_courses.length
      else
        counter = 5
      end

      current_user.has_favorites.each do |favorite|

         index_id = courses_id_by_user.find_index(favorite.course.id)

         if index_id == nil
        # Se toma la cantidad de recomendaciones que tiene
           counter_recomendation =  DoRecomendation.where(course_id: favorite.course.id).count

           if @recomendation_courses.length < 6

             @recomendation_courses[counter] = favorite.course
             @counter_recomendation_array[counter] = counter_recomendation
           else
             # Tomar el index y el valor de recomendacion del que posea menor recomendaciones
             index = @counter_recomendation_array.each_with_index.min[1]
             value = @counter_recomendation_array.each_with_index.min[0]
             if counter_recomendation > value
               if index >= 3
                 @recomendation_courses[index] = favorite.course
                 @counter_recomendation_array[index] = counter_recomendation
                 index_id = courses_id_by_user.find_index(favorite.course)
                 courses_id_by_user[index_id] = favorite.course
                 courses_id_by_user(favorite.course.id)
               end
             end
           end
           counter += 1
         end

      end

      end

  end
end
