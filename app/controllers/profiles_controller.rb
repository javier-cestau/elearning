class ProfilesController < ApplicationController

  skip_before_action :redirect_to_fill_profile, only: [:new,:create]

  def show
    if params[:id].nil?
      profile_id = Profile.find_by_user_id(current_user.id).id
    else
      user = User.find_by_id(params[:id])
      profile = Profile.find_by_user_id(user.id)
      if profile.nil?
        flash[:alert] = "La persona no ha llenado su perfil"
        redirect_to root_path
      else
        profile_id = profile.id
      end
    end

    @profile = ProfileInfo.where(profile_id: profile_id)
  end

  def new
    @profile = Array.new(9)
  end

  def create
    valid = true
    questions_params[:questions].each do |answer|
      if answer.length == 0
        valid = false
        break
      end
    end

    if valid
      @profile = Profile.find_by_user_id(current_user.id)



      if !@profile.nil?
        ProfileInfo.where(profile_id: @profile.id).destroy_all
      else
        @profile = Profile.create(user_id: current_user.id)
      end

      questions_params[:questions].each do |answer|
        ProfileInfo.create(profile_id: @profile.id,answer: answer)
      end

      session["devise.fill_profile?"] = false
      current_user.name = questions_params[:questions][0]+questions_params[:questions][1]
      current_user.save
      flash[:notice] = "Guardado exitosamente"

      redirect_to root_path
    else
      flash[:alert] = "Debe rellenar todos los campos"
      redirect_back(fallback_location: new_profile_path)
    end
  end

  def edit
    profile_id = Profile.find_by_user_id(current_user.id).id
    @profile = ProfileInfo.where(profile_id: profile_id)
    gon.estado = @profile[4]
  end



  private

  def questions_params
      params.require(:profile).permit(:questions => [])

  end

end
