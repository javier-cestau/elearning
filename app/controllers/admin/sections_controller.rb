class Admin::SectionsController < ApplicationController
# TODO mensaje cuando se intente guardar un section sin nombre
before_action :authenticate_medium_admin!
before_action :find_course_in_section, only: %i[edit create update destroy]


  before_action :all_topic, only:[:edit]

  def edit
    @section = Section.find(params[:id])
    # Si la seccion es un subdivision de otra se guardara aqui
    @list_sections = Array.new

    # Aqui entra cuando deriva de otra seccion
    if !@section.prv_section.nil?

      # Esta variable es en el caso de que se este editando una seccion que sea padre
      # Para que asi cuando se este editando se muestren sus hijos en el menu
      @section_is_a_father = Section.find_by(prv_section: @section.id)

      # Este condicion se entra es cuando la seccion es solamente hijo
      if @section_is_a_father.nil?
        @sections = Section.where(prv_section: @section.prv_section).order("created_at ASC")
        # En el caso de que no sea un padre se busca el padre de dicha seccion
        @section_father = Section.find(@section.prv_section)
        # en el caso de que el padre venga de una seccion tambien
        if !@section_father.prv_section.nil?

          # Esta variable se debe a que el usuario estara editando el hijo de un padre de la seccion
          # Esta variable sera el padre del padre de la seccion
          # Para asi tener una referencia y brindar en el menu el ir atras hacias ese padre
          #
          # Seccion super padre
          # |--Seccion padre
          # |--|---Seccion hijo
          # |--|---Seccion hijo
          # |--|---Seccion hijo

          @section_super_father = Section.find(@section_father.prv_section)
        end
      else
        # En el caso de que el hijo que se quiera entrar sea un padre
        # Se toman todos sus hijos
        @sections = Section.where(prv_section: @section.id).order("created_at ASC")
        # Y se busca al padre de dicha seccion
        @section_father = Section.find(@section.prv_section)

      end
    else
      @sections = Section.where(prv_section: @section.id).order("created_at ASC")
    end

    @sections.each do |s|
      @list_sections.push(s)
    end

    @list_name_video = Array.new
    @list_name_image = Array.new
    @section_files = Hash.new

    @section.multimedia_sections.each do |medias|
      if !medias.video_file_name.nil?
       video_name = medias.video_file_name.split(".webm")[0]
       @list_name_video.push(video_name => medias.id)
     else
       image_name = medias.image_file_name
       @list_name_image.push(image_name => medias.id)

      end
    end

    @section.section_files.each do |file|
      @section_files[file.id] = file.file_file_name
    end
  end

  def update
    @section = Section.find(params[:id])
    description = params_section[:description]
    name = params_section[:name]

    # Si coloca el tags de video se analiza la descripcion en busca de dichos tags
    while(!description.index("#video{").nil?)
      # html = "video_id/name} ......."
      html = description.split("#video{")[1]
      #html = video_id/name
      html = html.split("}")[0]

      video_id = html.split("/")[0]
      video_name = html.split("/")[1]

      new_html =   '<p style=""><span contenteditable="false" draggable="false" class="fr-video fr-dvb fr-draggable">'+
                    '<video src=" /system/multimedia_sections/videos/section_'+@section.id.to_s+'/'+video_id+'/mobile/'+video_name+'.webm" data-status="OK" style="width: 600px;" "="" controls="" class="fr-draggable">'
                    'Your browser does not support HTML5 video.</video>'+
                  '</span></p>';
      old_label = "#video{#{video_id}/#{video_name}}"
      description =   description.sub(old_label, new_html)
    end


    # Si coloca el tags de video se analiza la descripcion en busca de dichos tags
    while(!description.index("#image{").nil?)
      # html = "image_id/name} ......."
      html = description.split("#image{")[1]
      #html = image_id/name
      html = html.split("}")[0]

      image_id = html.split("/")[0]
      image_name = html.split("/")[1]

      new_html = "<p><img alt='.' src='/system/multimedia_sections/images/section_"+@section.id.to_s+"/"+image_id+"/medium/"+image_name+"' width='160' height='119' /></p>"

      old_label = "#image{#{image_id}/#{image_name}}"
      description =   description.sub(old_label, new_html)
    end

    if @section.update(name: name, description: description)
      redirect_to edit_admin_course_section_path(@course,@section), notice: "Actualizado exitosamente"
    else
      redirect_to edit_admin_course_section_path(@course,@section) , alert: "Error al actualizar, por favor contacte con el administrador del sistema"
    end

  end
  def create
      prv_section_id = params[:prv_section]
      valid = true
      if !prv_section_id.nil?
        prv_section = Section.find(prv_section_id)
        if (prv_section.course_id != @course.id)
          valid = false
        end
      end

      if valid
        section = @course.sections.create(name: "Nueva sección", prv_section: prv_section_id )

        redirect_to edit_admin_course_section_path(@course,section)
      else
        redirect_to admin_courses_path
      end

  end

  def destroy
    @section = Section.find(params[:id])
    @sub_section = Section.where(prv_section: @section.id)

    if @course.active == 0
        @sub_section.each do |s|
          destroy_section_child(s)
        end

        MultimediaSection.where(section_id: @section.id).destroy_all
        @section.try_destroy
        flash[:notice] = "Sección eliminada exitosamente"
        redirect_to edit_admin_course_path @course
    else
      @sub_section_test = false
      @sub_section.each do |s|
        check_section_child(s)
      end

      if @sub_section_test
        flash[:alert] = "Está sección posee subsecciones con al menos un examen en un curso activo"
        redirect_to edit_admin_course_section_path(@course,@section)
      else
        @sub_section.each do |s|
          destroy_section_child(s)
        end
        # Se analiza si la sección tiene exámenes o tuvo
        if !Test.find_by(section_id: @section.id).nil?
          flash[:alert] = "No se puede eliminar una sección que posee un examen en un curso activo"
          redirect_to edit_admin_course_section_path(@course,@section)
        else
          flash[:notice] = "Sección eliminada exitosamente"
          @section.try_destroy
          redirect_to edit_admin_course_path(@course)
        end
      end
    end
  end

  private




    def params_section
      params.require(:section).permit(:description,:name)
    end



    def destroy_section_child (s)

      has_child =  Section.where(prv_section: s.id)

      if !has_child.empty?

         has_child.each do |c|
            destroy_section_child(c)
        end
      end
        # Se destruyen todas las multimedia asociados a esa seccion
        MultimediaSection.where(section_id: s.id).destroy_all
        s.try_destroy
    end

    def check_section_child (s)

      has_child =  Section.where(prv_section: s.id)

      if !has_child.empty?
         has_child.each do |c|
            check_section_child(c)
        end
      end
        # Se destruyen todas las multimedia asociados a esa seccion
        MultimediaSection.where(section_id: s.id).destroy_all
        if !Test.find_by(section_id: s.id).nil?
          @sub_section_test = true
        end
    end





end
