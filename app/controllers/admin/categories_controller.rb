class Admin::CategoriesController < ApplicationController
  before_action :authenticate_medium_admin!
  before_action :find_category, only: [:edit, :update, :destroy]



  def index
    @categories = Category.all.order("name ASC").page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    name = params[:category][:name].strip.capitalize
    # Comprobar si no existe otra categoría igual antes de crearla
    @name_validate = Category.where("name = ?", name)

      # Si el query WHERE no retorna nada significa que se puede actualizar
      if @name_validate.empty?

        @category = Category.new()
        @category.name = name
        if @category.save
          redirect_to admin_categories_path, notice: "La categoría '#{@category.name}' ha sido creada correctamente"
        else
          render :new
        end

      else
        redirect_to new_admin_category_path, alert:  "Ya existe una categoría con ese nombre"
      end


  end


  def edit

  end


  def update

    id = params[:id]
    name = params[:category][:name].strip.capitalize

    # Comprobar si no existe otra categoría igual antes de actualizar
    @name_validate = Category.where("name = ? AND id != ?", name , id )
    name_old = @category.name

    # Si el query WHERE no retorna nada significa que se puede actualizar
    if @name_validate.empty?
      if @category.update(name: name)
        redirect_to admin_categories_path, notice: "La categoría '#{name_old}' se ha actualiazado a '#{@category.name}' correctamente"
      else
        render :edit
      end

    else
      redirect_to edit_admin_category_path(@category), alert:  "Ya existe una categoría con ese nombre "
    end

  end

  def destroy

    @courses = Course.all
    can_delete = true

    #Se busca si un curso con dicha categoria existe
    course_with_this_category = Course.where(category_id: @category.id)

      #De ser asi, no podrá ser eliminada
      if !course_with_this_category.empty?
        can_delete = false
      end

    # En caso contrario, se puede eliminar sin problemas
    if can_delete
      @category.destroy
      redirect_to admin_categories_path, notice: "La categoría '#{@category.name}' ha sido eliminada correctamente"
    else
      redirect_to admin_categories_path, alert: "La categoría no pudo ser eliminada debido a que existen cursos que la usan."
    end

  end




  private

  def params_category
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end

end
