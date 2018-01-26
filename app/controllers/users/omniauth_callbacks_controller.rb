class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :redirect_to_fill_profile

  def facebook
    auth = request.env["omniauth.auth"]
    if !auth.info.email.empty?

      user = User.where(email: auth.info.email).first

      if user.nil?
        user = User.auth_creation(auth)
      end

      if user.persisted?
        sign_in user
        profile = Profile.where(user_id: current_user.id) #kill me plox
        if profile.empty?

          session["devise.first_name"] = auth.info.first_name
          session["devise.last_name"] = auth.info.last_name
          session["devise.fill_profile?"] = true
        end
        redirect_to root_path
      else
        flash[:alert] = "Validación incorrecta"
        redirect_to root_path
      end
    else
      flash[:alert] = "Debe poseer correo electrónico"
      redirect_to root_path

    end
  end

  def google_oauth2
    auth = request.env["omniauth.auth"]
    if !auth.info.email.empty?

      user = User.where(email: auth.info.email).first

      if user.nil?
        user = User.auth_creation(auth)
      end

      if user.persisted?
        sign_in user
        profile = Profile.where(user_id: current_user.id) #kill me plox
        if profile.empty?

          session["devise.first_name"] = auth.info.first_name
          session["devise.last_name"] = auth.info.last_name
          session["devise.fill_profile?"] = true
        end
        redirect_to root_path
      else
        flash[:alert] = "Validación incorrecta"
        redirect_to root_path
      end
    else
      flash[:alert] = "Debe poseer correo electrónico en tu cuenta"
      redirect_to root_path

    end
  end


  def elearning
    raise
    auth = request.env["omniauth.auth"]
    user = User.where(email: auth.info.email).first
    if user.nil?
      redirect_to root_path, alert: "Su cuenta no existe en la Academia Leiros, por favor contactar con el administrador de sistema para más información."
    else

      if user.state == 1
        # inicia sesion el usuario
        user.update(provider: auth.provider, uid: auth.uid)

        sign_in user
        # template = DoTemplate.find_by_user_id(current_user.id)
        template = DoTemplate.where(user_id: current_user.id).last


        # se comprueba si el usuario no posee ninguna planilla creada
        if template.nil?
          # Se revisa el ultimo template que tiene el departamento
          current_user.department.has_templates.reverse_each do |fill_tmp|

              #Si el usuario no tiene ninguna planilla, se le obligara a llenar una antes de avanzar en el sistema
              session["devise.fill_template?"] = true
              session["devise.template"] = fill_tmp.template_id
              redirect_to template_path(fill_tmp.template_id)

              break
          end
        else

          current_user.department.has_templates.reverse_each do |fill_tmp|
              if template.template_id != fill_tmp.template_id

                redirect_to root_path, notice: "Existe una nueva planilla para llenar"
              else
                redirect_to root_path
              end
              break
          end
        end

      else
        redirect_to root_path, alert: "Su cuenta esta deshabilitada, por favor contacte con el administrador del sistema para más información."
      end
    end
  end

end
