module Admin::TemplatesHelper

  def template_date(talent_id, template_id, sequence)
    DoTemplate.where(user_id: talent_id, template_id: template_id, sequence: sequence ).last.created_at.strftime("%d-%m-%Y")
  end
end
