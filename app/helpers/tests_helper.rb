module TestsHelper
	def attemps_limits_msg
		unless @count.nil?
			if @test.attemps_limits == @count
				content_tag :p, "Este es su último intento", class: "btn red"
			else
				content_tag :span, "Este es intento número #{@count} de #{@test.attemps_limits}", class: "btn"
			end
		end
	end

	def show_answer(answer,question)

		type_id = question.object.type_question_id

		hidden_field_tag(  "test[questions_attributes][#{question.index}][answers][]", "#{answer.description}") +
		content_tag(:p ) do
			if type_id == Constant::QuestionEnum::SeleccionMultiple
				check_box_tag( "test[questions_attributes][#{question.index}][answers_correct][]","#{answer.description}",false, id: "test_questions_attributes_#{question.index}_answers_correct_#{answer.description}")+
				content_tag(:label, "#{answer.description}", for: "test_questions_attributes_#{question.index}_answers_correct_#{answer.description}")
			else

				radio_button_tag( "test[questions_attributes][#{question.index}][answers_correct][]","#{answer.description}",false,id:"test_questions_attributes_#{question.index}_answers_correct_#{answer.description}")+
				content_tag(:label, "#{answer.description}", for: "test_questions_attributes_#{question.index}_answers_correct_#{answer.description}")
			end
		end
	end

	def show_responses(answer,question)

		type_id = question.object.type_question_id
		has_answer = HasAnswer.where(do_test_id: @do_test.id, answer_id: answer.id)

		checked = false
		text_color = ""
		icon = ""
		unless has_answer.empty?
			checked = true
			text_color = "red-text"
			icon = "<i class='fa fa-times'></i>"
			if answer.is_correct == 1
				text_color = "green-text"
				icon = "<i class='fa fa-check'></i>"
			end
		end


		content_tag(:p) do
			if type_id == Constant::QuestionEnum::SeleccionMultiple
				check_box_tag( "","",checked)+
				content_tag(:label,class:"#{text_color}") do
					"#{answer.description}".html_safe+
					"&nbsp&nbsp#{icon}".html_safe

				end
			else
				radio_button_tag( "","",checked)+
				content_tag(:label,class:"#{text_color}") do
					"#{answer.description}".html_safe+
					"&nbsp&nbsp#{icon}".html_safe
				end
			end

end
	end
end
