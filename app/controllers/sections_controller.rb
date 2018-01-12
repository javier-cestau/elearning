class SectionsController < ApplicationController

  include Verify

  before_action :is_course_avaible, only: [:show]
  before_action :all_topic, only: [:show]
  around_action :evaluate


  def show
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

        @section_files = Hash.new

        @section.section_files.each do |file|
          @section_files[file.id] = file.file_file_name
        end


        @comments = CommentSection.where(section_id: @section.id, prv_comment: nil).order("created_at DESC")
        @comments_count = CommentSection.where(section_id: @section.id).count

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file"   # Excluding ".pdf" extension.
      end
    end

  end

  private



end
