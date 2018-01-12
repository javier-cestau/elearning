document.addEventListener 'turbolinks:load', ->
	Materialize.updateTextFields();
	if gon.sections_url?
		$('input.autocomplete').autocomplete
			data:
				JSON.parse(gon.sections_url)
			limit: 20
			onAutocomplete: (val,val2) ->
				sections_url = JSON.parse(gon.sections_url)
				id = sections_url[val]
				url_string = $(location).attr('href');
				url = new URL(url_string);
				if url.pathname.split("/admin").length == 2
					Turbolinks.visit("/admin/courses/#{gon.course_id}/sections/#{id}/edit");
				else
					Turbolinks.visit("/courses/#{gon.course_id}/sections/#{id}/");
				return
			minLength: 1
	$('select').material_select();
	$(".button-collapse").sideNav();
	$(".button-collapse-nav").sideNav();
	$('.modal').modal();
	$('.collapsible').collapsible()
	$('.tooltipped').tooltip
		delay: 50
	$('.dropdown-button-progress').dropdown
		inDuration: 300
		outDuration: 225
		constrainWidth: true
		belowOrigin: false
		alignment: 'left'
