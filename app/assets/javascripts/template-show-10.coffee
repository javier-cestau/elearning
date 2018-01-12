document.addEventListener 'turbolinks:load', ->

	Initialize = ->
		minimum = 10
		$(".required-textarea").keyup (event) ->
			id = event.target.id.split("textarea_")[1]
			CharacterCounter(id,minimum)
			return
		$(".required-textarea").focus (event) ->
			id = event.target.id.split("textarea_")[1]
			CharacterCounter(id,minimum)
			return

		$(".type_3_required > label > input").prop("checked", true)

		$("#submit-template").click (e) ->

			has_respond_all_1 = has_respond_all_2 = has_respond_all_3 = has_respond_all_4 = true

			textarea_boxes = $(".edit_template").find("div > .required_input_2 textarea")
			$(textarea_boxes).each ->
				if($(this).val().trim().length < 10)
					has_respond_all_1 = false

			inputs_boxes = $(".edit_template").find("div > .required_input_1 input")
			$(inputs_boxes ).each ->
				console.log($(this).val().length)
				if($(this).val().trim().length < 1)
					has_respond_all_2 = false

			has_respond_all_3 = check_required_boxes(3)
			has_respond_all_4 = check_required_boxes(4)

			if !has_respond_all_1 || !has_respond_all_2 || !has_respond_all_3 || !has_respond_all_4
				alert "Debe llenar todos los campos obligatorios"
			else
				$(".edit_template").submit()
			return

	check_required_boxes = (type) ->
		check_boxes = $(".edit_template").find("div > .required_input_#{type} label input")
		array_id = []
		$(check_boxes).each ->
			array_id.push(parseInt($(this)[0].id.split("_")[1]))

		unique = onlyUnique(array_id)
		for num in unique
			group = $(".edit_template div > .required_input_#{type} label input[id^='template_#{num}']")
			temp_boolean = false
			$(group).each ->
				if $(this).is(":checked")
					temp_boolean = true

			if !temp_boolean
				return false
				break
		return true

	onlyUnique = (array_id)  ->
		set = new Set(array_id)
		array_id = Array.from(set)


	CheckType4 = (id) ->
		if $("type_4_required_#{id} .required:checked").length
			return false

	CharacterCounter = (id,min) ->
		characters = $("#textarea_#{id}").val().length

		$("#limit_textarea_#{id}").hide()

		if characters < min
			$(this).css("border-color","red")
			$("#limit_textarea_#{id}").show()
			return false
		return true
	if PageFile == 10

		Initialize()
	return
return
