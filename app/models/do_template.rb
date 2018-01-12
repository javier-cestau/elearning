class DoTemplate < ApplicationRecord
  belongs_to :template
  belongs_to :user
  belongs_to :response
  belongs_to :survey

  def self.template_made_by(id)
    where(user_id: id).select(:sequence, :template_id).order("sequence ASC").distinct.distinct(true)
  end


end
