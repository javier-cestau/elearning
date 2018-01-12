class CommentSection < ApplicationRecord
  belongs_to :section
  belongs_to :user
end
