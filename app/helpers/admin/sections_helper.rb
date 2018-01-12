# coding: utf-8
 module Admin::SectionsHelper
   include Constant::QuestionEnum

	def show_button_test(section_id)
		test_section = Test.where(section_id: section_id)
		if !test_section.empty?
			test_section = @section.tests.last
			link_to "Editar examen", edit_admin_course_section_test_path( @course, @section,test_section), class: "btn"
		else
			link_to "Crear examen", new_admin_course_section_test_path( @course, @section), class: "btn"
		end

	end

	def delete_button_test(section_id)
		test_section = Test.where(section_id: section_id)
		if !test_section.empty?
			test_section = @section.tests.last
			link_to "Eliminar examen", admin_course_section_test_path( @course, @section,test_section), class: "btn red", method: :delete, data:{confirm: "¿Esta seguro de eliminar el examen?"}
		end

	end

        def average_button_test(section_id)
		test_section = Test.where(section_id: section_id)
		if !test_section.empty?
			test_section = @section.tests.last
			link_to "Promedio de aprobados y reprobados", admin_course_section_test_average_path(@course, @section,test_section), class: "btn"
		end
	end




	def checked_type(object,value)
		if !object.new_record?

				if object.type_question_id == value
					return "checked"
				end

		else
			if value == 2
				return "checked"
			end

		end
		return ""
	end


	def add_answers(answer,question)
		type_id = question.object.type_question_id
		checked = false
		if answer.is_correct == 1
			checked = true
		end

		if type_id == 3
			@disabled = "disabled"
		end


			content_tag :li,"", id: "i_answer_survey#{answer.description}", class: "collection-item" do
				hidden_field_tag(  "test[questions_attributes][#{question.index}][answers][]", "#{answer.description}") +

				content_tag(:div ) do
					content_tag(:span , "#{answer.description}") +
					if type_id == Constant::QuestionEnum::SeleccionMultiple
						check_box_tag( "test[questions_attributes][#{question.index}][answers_correct][]","#{answer.description}", checked)+
						content_tag(:a, id: "answer_#{answer.description}", class: "secondary-content") do
							content_tag(:i, class: "material-icons pointer") do
								"clear"
							end
						end
					else
						radio_button_tag( "test[questions_attributes][#{question.index}][answers_correct][]","#{answer.description}",checked)+
						content_tag(:a, id: "answer_#{answer.description}", class: "secondary-content") do
							content_tag(:i, class: "material-icons pointer") do
								"clear"
							end
						end
					end

				end
			end
	end


end
