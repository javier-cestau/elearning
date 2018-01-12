class Admin::SystemController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_super_admin!

  def settings
    @files = Dir["#{Rails.root}/backup/*.backup"].sort_by{ |f| File.mtime(f)  }.reverse!
    unless params[:name].nil?
      send_file(
          "#{Rails.root}/backup/"+params[:name]
      )
    end
  end

  def backup
    flash[:notice] = "Respaldo creado"
    system "pg_dump -F c -v -U rails -h localhost elearning_develop -f backup/academia_#{DateTime.now.to_s}.backup" if current_user.is_super_admin?
    redirect_to admin_system_settings_path
  end

  def restore
    system "pg_restore --verbose --host localhost --username rails --clean --no-owner --no-acl --dbname elearning_develop backup/#{params[:name]}" if current_user.is_super_admin?
    flash[:notice] = "Base de datos restaurada"
    redirect_to admin_system_settings_path

  end


end
