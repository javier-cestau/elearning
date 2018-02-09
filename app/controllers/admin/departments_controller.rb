class Admin::DepartmentsController < ApplicationController
  before_action :authenticate_medium_admin!
  before_action :find_department, only: [:edit, :update]

  def index
    @departments = Department.all.order("name ASC").page(params[:page]).per(10)
  end

  def new
    @department = Department.new
  end

  def create
    name = params[:department][:name].strip.capitalize
    # Comprobar si no existe otro igual antes de crearlo

    @name_validate = Department.where("name = ?", name)

    # Si el query WHERE no retorna nada significa que se puede actualizar
    if @name_validate.empty?
      @department = Department.new()
      @department.name = name
      if @department.save
        redirect_to admin_departments_path, notice: "El programa '#{@department.name}' ha sido creado correctamente"
      else
        render :new
      end
    else
      redirect_to new_admin_department_path, alert:  "Ya existe un programa con ese nombre"
    end
  end

  def edit
  end

  def update
    id = params[:id]
    name = params[:department][:name].strip.capitalize
    # Comprobar si no existe otro igual antes de actualizarlo
    @name_validate = Department.where("name = ? AND id != ?", name , id )
    name_old = @department.name.strip

    # Si el query WHERE no retorna nada significa que se puede actualizar
    if @name_validate.empty?

      if @department.update(params_department)
        redirect_to admin_departments_path, notice: "El programa '#{name_old}' se ha actualiazado a '#{@department.name}' correctamente"
      else
        render :edit
      end

    else

      redirect_to edit_admin_department_path(@department), alert:  "Ya existe un programa con ese nombre "

    end
  end

  private

  def params_department
    params.require(:department).permit(:name,:description,:photo)
  end
  def find_department
    @department = Department.find(params[:id])
  end
end
