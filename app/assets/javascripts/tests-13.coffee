addAnswerTest = (num) ->
	answer = $("#add_answer"+num).val().trim()
	answer_replace = answer.replace(/[\s\:\+]+/g, "-")
	if answer.length > 0
		exist = $("#answers-list"+num+" #i_answer_survey"+answer_replace).val()
		console.log answer_replace
		console.log num
		if  !exist?
			option = $("input[name='test[questions_attributes][#{num}][type_question_id]']:checked").val()
			type = ""

			switch option
				when "1", "3"
					type = "radio"
				when "2"
					type = "checkbox"
				else
					type = "checkbox"

			html =  "<li class='collection-item' id='i_answer_survey"+answer_replace+"'> " +
							"         <input name='test[questions_attributes]["+num+"][answers][]' value='"+answer+"'  type='hidden' >"+
							"         <div >"+
														answer+
							"							<input type='#{type}' name='test[questions_attributes][#{num}][answers_correct][]' value='#{answer}'> "+
							"             <a id='answer_"+answer_replace+"' class=\"secondary-content\">" +
							"               <i class=\"material-icons pointer\">clear</i>" +
							"             </a>" +
							"         </div>" +
							"      </li>"

			$("#answers-list"+num).append("")

			$("#answers-list"+num).append(html)

			$("#answers-list"+num).one "click" ,"#answer_"+answer_replace, ->
				$("#answers-list"+num+" #i_answer_survey"+answer_replace).remove()
				return
			return
		return
	return



dateInit = ->
	$('.datepicker').pickadate
		min: new Date
		selectMonths: false
		selectYears: 15
		hiddenSuffix: ""
		formatSubmit: 'yyyy-mm-dd'
		format: 'mmmm d, yyyy'
		today: 'Hoy'
		min: new Date
		clear: 'Indeterminado'
		close: 'Cerrar'
		monthsFull: [
			'Enero'
			'Febrero'
			'Marzo'
			'Abril'
			'Mayo'
			'Junio'
			'Julio'
			'Agosto'
			'Septiembre'
			'Octubre'
			'Noviembre'
			'Diciembre'
		]
		monthsShort: [
			'Ene'
			'Feb'
			'Mar'
			'Abr'
			'May'
			'Jun'
			'Jul'
			'Ago'
			'Sep'
			'Oct'
			'Nov'
			'Dic'
		]
		weekdaysFull: [
			'Domingo'
			'Lunes'
			'Martes'
			'Miercoles'
			'Jueves'
			'Viernes'
			'Sabado'
		]
		weekdaysShort: [
			'Dom'
			'Lun'
			'Mar'
			'Mie'
			'Jue'
			'Vie'
			'Sab'
		]
	return

OnlyNumbers = (e) ->
	allow = '1234567890'
	k = undefined
	key = e.keyCode
	if key == 8
		true
	else
		k = if document.all then parseInt(e.keyCode) else parseInt(e.which)
		return allow.indexOf(String.fromCharCode(k)) != -1
	return

InitializeSubmit = ->
	$(".btn-submit").click (e)->
		question_alert = false
		at_least_one_question = false
		test_description = $("#test_description").val().length
		two_answer = false
		has_correct_answer = true
		$("#test_description").css
			'background-color': 'inherit'
			'border-bottom': '1px solid #9e9e9e;'

		$(".test_questions_description").each ->
			$(this).children().css
				'background-color': 'inherit'
				'border-bottom': '1px solid #9e9e9e'

			at_least_one_question = true
			input_question = $(this).children().val().trim();
			if input_question.length < 5
				$(this).children().css
					'background-color': '#fbc0c0'
					'border-bottom': '1px solid #f44336'
				question_alert = true
			return

		$(".container_answer").each ->
			element = $(this).children().length
			$(this).prev().css 'display': 'none'
			if element < 2
				$(this).prev().css 'display': 'block'
				two_answer = true
			else
				inputs_boxes = $(this).find("li > div > input")
				$(inputs_boxes).each ->
					if!($("input[name='#{$(this).prop("name")}']").is(':checked'))
						has_correct_answer = false

		note_submit = 0
		some_question_has_0 = false
		$(".puntaje input").each ->
			point = parseInt($(this).val()) || 0;
			if point == 0
				some_question_has_0 = true
			note_submit += point


		min_grade = parseInt($("#test_min_grade").val()) || 0;

		deadline_test = new Date($("input[name='test[deadline]']:last-child").val())
		start_date_test = new Date($("input[name='test[start_date]']:last-child").val())
		start_date_course_attr = new Date(gon.start_date_course_attr)
		deadline_course_attr = new Date(gon.deadline_course_attr)


		is_deadline_test_empty = false
		is_start_date_test_empty = false

		if start_date_test.toString() == "Invalid Date"
			is_start_date_test_empty = true
		if deadline_test.toString() == "Invalid Date"
			is_deadline_test_empty = true


		valid_date = true
		message_date = ""
		# Validar fecha del examen con respecto a las del curso y las propias del examen
		if deadline_course_attr.toString() != "Invalid Date"
			if !is_start_date_test_empty
				if start_date_test > deadline_course_attr
					message_date = " - La fecha de inicio del examen no puede ser mayor que la de finalización del curso"
					valid_date = false
				if start_date_test < start_date_course_attr
					message_date = " - La fecha de inicio del examen no puede ser menor que la de inicio del curso"
					valid_date = false
				if !is_deadline_test_empty
					if start_date_test > deadline_test
						if message_date != ""
							message_date += "\n"
						message_date += " - La fecha de inicio del examen no puede ser mayor que la de finalización del examen"
						valid_date = false
			if !is_deadline_test_empty
				if deadline_test > deadline_course_attr
					if message_date != ""
						message_date += "\n"
					message_date += " - La fecha de finalización del examen no puede ser mayor que la de finalización del curso"
					valid_date = false
				if deadline_test < start_date_course_attr
					if message_date != ""
						message_date += "\n"
					message_date += " - La fecha de finalización del examen no puede ser menor que la de inicio del curso"
					valid_date = false
		else
			if !is_start_date_test_empty || !is_deadline_test_empty
				valid_date = false

		if !valid_date
			alert message_date
		else if $("#test_description").val().length < 20
			$("#test_description").css
				'background-color': '#fbc0c0'
				'border-bottom': '1px solid #f44336;'
				$("html, body").animate({
					scrollTop: 0
				}, 1500);
		else unless at_least_one_question
			alert 'Debe crear al menos una pregunta'
		else if question_alert
			alert 'Las preguntas deben tener al menos 5 caracteres'
		else if two_answer
			alert 'Debe agregar al menos dos respuestas'
		else if !has_correct_answer
			alert 'Cada pregunta debe tener al menos una respuesta correcta'
		else if note_submit != 20
			alert 'La suma de todos los puntos de las preguntas debe dar un total de 20'
		else if some_question_has_0
			alert 'Todas las preguntas deben tener un valor distinto a cero (0)'
		else if min_grade < 1 || min_grade > 20
			alert 'Los valores permitidos de la nota mínima es desde 1 hasta 20'
		else
			$("form").submit()
		return

AddNote = ->
	note = 0
	$(".puntaje input").each ->
		point = parseInt($(this).val()) || 0;
		note += point
	$(".fl-btn").removeClass("green amber red")
	$(".total-point").html(note+"/20")
	if note > 20
		$(".fl-btn").addClass("red")
	else if note < 20
		$(".fl-btn").addClass("amber")
	else
		$(".fl-btn").addClass("green")
	return

document.addEventListener 'turbolinks:load', ->
	IniatilizeComponentsTest = ->

		$('#button-description').click (e) ->
			time = new Date().getTime()
			regexp = new RegExp($(this).data('id'), 'g')
			$(".panel-element" ).append($(this).data('fields').replace(regexp, time))
			return

		$("#panel-element").sortable revert: true

		$('.panel').on 'click', '.borrar', ->
			id = $(this).data("id")
			$("#basic-addon#{id}").remove()
			return

		$(".panel-element").on "click", ".add-answer", ->
			addAnswerTest($(this).data("id"))

		dateInit()

		clock = new FlipClock($('.clock'), 100,
			clockFace: 'MinuteCounter'
			language: "es-es"
			seconds: ""
		)

		$("#test_attemps_limits, #test_min_grade, #test_time_limit").keypress (e) ->
			OnlyNumbers(e)

		timer = null;
		$(".panel").on "keypress", ".puntaje", (e)->
			clearTimeout(timer)
			timer = setTimeout AddNote, 500
			OnlyNumbers(e)
		$(".panel").on "change", ".puntaje > input",  (e)->
			clearTimeout(timer)
			timer = setTimeout AddNote, 500
		InitializeSubmit()

	if PageFile == 13
		IniatilizeComponentsTest()
		return
