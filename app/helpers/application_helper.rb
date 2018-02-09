module ApplicationHelper

	def url_form_search
		if request.path.include?("admin/")
			admin_courses_path()
		else
			courses_path()
		end
	end

	def link_to_add_tr_field(t, association, table_id)

		new_object = t.object.send(association).klass.new
	  id = new_object.object_id
		fields = t.fields_for(association, new_object, :child_index => id) do |q|
			render "/admin/tests/questions", q:q, id: id
    end
		content_tag(:span,"", id: "button-description" ,class: " input-group-addon back-green btn-floating btn-large waves-effect waves-light",data: { fields: fields, id:id},  ) do
			content_tag(:i,"",class: "fa fa-plus color-white tooltipped", 'data-position': "right", 'data-delay': "50", 'data-tooltip': "Agregar una nueva pregunta")
		end
		# link_to(name.html_safe, '#', id: "add_tr_fields", data: {id: id, fields: fields.gsub("\n", ""), table_id: table_id}, class: "btn btn-info btn-sm add_tr_fields", style: "margin-top: 10px")
	end

	def get_url_type_question(value,object_id)
		 if value == Constant::QuestionEnum::SeleccionSimple
			link = admin_simple_path(object_id: object_id)
		elsif value == Constant::QuestionEnum::SeleccionMultiple
			 link = admin_multiple_path(object_id: object_id)
		 elsif value == Constant::QuestionEnum::TrueFalse
			 link = admin_true_false_path(object_id: object_id)
		 elsif value == Constant::QuestionEnum::Redaccion
			 link = admin_redaction_path(object_id: object_id)
		 end

		 link
	end

	def date_format(date,object)

		if !object.new_record?
			if date.class == Date
				return localize(date)
			end
		end
		return ""
	end

	def to_boolean(params)
		if params.nil?
			 auto = false
		else
			# Comprobar si el valor es true o false
			 auto = params == "true" ? true : false
		 end
	end

end
