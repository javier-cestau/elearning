module SecurityComment
	extend ActiveSupport::Concern

	included do
		around_action :can_delete, only: [:destroy]
		around_action :can_comment, only: [:create]
	end

	def can_delete
		if current_user.is_at_least_medium_admin? || current_user.id == @comment.user_id
			yield
		end
	end

	def can_comment
		if !comment_params[:body].empty? ||
			yield
		end
	end
end
