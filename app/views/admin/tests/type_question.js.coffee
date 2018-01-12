num = "<%=@id%>"
$("#test_questions_attributes_<%=@id%>_type_question_id_<%=@val%>").prop("checked", true)


$("#answers-list<%=@id%> > li > div > input").prop("type","<%=@type%>")

$("#add_answer#{num}").prop("disabled",false)
$("a[data-id='#{num}']").prop("disabled",false)
$("a[data-id='#{num}']").removeClass("disabled")

val = parseInt("<%=@val%>")

if val is 3
	$("#answers-list<%=@id%>").prev().css("display","none")
	answer_replace = "Verdadero"
	answer = "Verdadero"
	type = "<%=@type%>"

	html =  "<li class='collection-item' id='i_answer_survey"+answer_replace+"'> " +
					"         <input name='test[questions_attributes]["+num+"][answers][]' value='"+answer+"'  type='hidden' >"+
					"         <div >"+
												answer+
					"							<input type='#{type}' name='test[questions_attributes][#{num}][answers_correct][]' value='#{answer}'> "+
					"         </div>" +
				"      </li>"
	answer_replace = "Falso"
	answer = "Falso"

	html +=  "<li class='collection-item' id='i_answer_survey"+answer_replace+"'> " +
					"         <input name='test[questions_attributes]["+num+"][answers][]' value='"+answer+"'  type='hidden' >"+
					"         <div >"+
												answer+
					"							<input type='#{type}' name='test[questions_attributes][#{num}][answers_correct][]' value='#{answer}'> "+
					"         </div>" +
				"      </li>"
	$("#answers-list#{num}").html(html)
	$("#add_answer#{num}").prop("disabled",true)
	$("a[data-id='#{num}']").addClass("disabled")
	$("#answers-list#{num} li:first-child > div > input").prop("checked", true)
	return
else
	exist = $("#answers-list"+num+" #i_answer_surveyVerdadero").val()
	if  exist?
		$("#answers-list#{num}").html("")
		return
	return
