class Admin::SearchController < ApplicationController

  before_action :authenticate_user!

  # Buscar cursos segun una opción


  def courses
    name = params[:course][:name]

    respond_to do |format|

        format.json {
          if !name.empty?
          @courses = Course.search_admin(name)
          end
        }
    end
  end

  def talents
    @option = "0"
    @option = params[:option]
    searching_for = params[:search]

    respond_to do |format|

        format.json {
          if !searching_for.empty?
            @talents = User.search(@option, searching_for)
          end
        }
    end
  end

  def template
    name = params[:search]
    respond_to do |format|
      format.json {

        if !name.empty?
          @template = Template.search(name)
          render json: {template: @template}, status: :ok
        end
      }
    end
  end


end
