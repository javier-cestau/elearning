class Admin::SectionFilesController < ApplicationController
  before_action :authenticate_medium_admin!

  def create

    @section = Section.find(params[:section_id])

    @file = SectionFile.new(params_file)
    @file.section_id = @section.id
    @file.save
    respond_to do |format|
      format.json { render json: [id: @file.id , name: @file.file_file_name]}
    end
  end

  def destroy
    file = SectionFile.find(params[:id])
    file.destroy
  end

  private

  def params_file
    params.require(:section).permit(:file)
  end
end
