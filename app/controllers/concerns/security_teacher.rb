module SecurityTeacher
	extend ActiveSupport::Concern
  included do
	 around_action :check_teacher
  end

  def check_teacher
		
		if !params[:controller].match(/^admin\/(courses|teachers)/).nil? && !params[:action].match(/(new|index|create)/).nil?
			yield
		else
	    if current_user.is_super_admin? || current_user.is_teacher?(@course.id)
	      yield
	    else
	      redirect_to root_path
	    end
		end
  end
end
