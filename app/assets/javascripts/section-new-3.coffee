document.addEventListener 'turbolinks:load', ->
	id_section = ""
	id_course = ""
	GetCourseId = ->
		id_course = $(location).attr('href').split("/courses/")[1].split("/")[0]
	GetSectionId = ->
		id_section = $(location).attr('href').split("/sections/")[1].split("/")[0]
		console.log id_section

	InitializeModals = ->

		$('.modal').modal()

		$("#image-form").fileupload
			maxFileSize: 10000000000 * 10000
			dataType: 'json'
			done: (e, data) ->
				id_image = data.result[0].id;
				name =data.result[0].name;

				html = '<li class="collection-item avatar">'+
					'<a>'+
					'<img class="circle" src=" /system/multimedia_sections/images/section_'+id_section+'/'+id_image+'/medium/'+name+'">'+
					'</a>'+
					'<span class="title">'+
					name+
					'</span>'+
					'<div class="secondary-content">'+
					'<button class="btn" name="'+name+'" value="'+id_image+'">'+
					'Agregar'+
					'</button>'+
					'<p class="btn red" data-method="delete" data-confirm="" data_id="'+id_image+'">'+
					'Eliminar'+
					'</p>'+
					'</div>'+
					'</li>'

				$("#images").append html
			fail: ->
				alert("La imagen debe de ser con extensión  .jpg, .jpeg , .png y .gif")
			#  Indica la cantidad que se ha subido
			progressall:(e, data) ->
				console.log(data.loaded)
				console.log(data.total)


		$("#video-btn").click ->
			file = $("#input-file-video")[0].files[0]
			data = new FormData
			data.append "multimedia[video]",file
			jQuery.ajax
				url: "/admin/courses/#{id_course}/sections/#{id_section}/multimedia_sections"
				data: data
				cache: false
				contentType: false
				processData: false
				type: 'POST'

			$('#modal-video').modal('close')
			alert "Se le notificará cuando el video este listo para su uso."

			return

		$("#images").on "click", "p[data-method='delete']", (event)->

			id = $(this).attr("data_id")
			jQuery.ajax
				url: "/admin/courses/#{id_course}/sections/#{id_section}/multimedia_sections/#{id}"
				cache: false
				contentType: false
				processData: false
				type: 'DELETE'
				success: ->
					event.target.parentElement.parentElement.remove()
					return
				error: ->
					console.log "files error"
					return

		#Agregar la etiqueta al editor Tinymce sobre una imagen o video
		$("#videos").on "click", "button", ->
			name = ($(this).attr("name"))
			html = "<p style='font-size: 25px'> #video{"+$(this).attr("value")+"/"+name+"} </p>"
			$(".fr-view").append(html)
			$('#modal-video').modal('close')
			return
			
	InitializeMaterialFile = ->
		counter_file = 0

		$("#files-list > li").on "click", "button", (event) ->
			id = event.target.id
			jQuery.ajax
				url: "/admin/courses/#{id_course}/sections/#{id_section}/section_files/#{id}"
				cache: false
				contentType: false
				processData: false
				type: 'DELETE'
				success: ->
					$("#li-#{id}").remove()
					alert "Archivo eliminado exitosamente"
					return
				error: ->
					console.log "files error"
					return



		$("#file-form").fileupload
			dataType: 'json'
			add: (e, data) ->
				goUpload = true
				file = data.files[0]
				types = /(\.|\/)(xlsx|xls|pptx|pdf|docx|iso)$/i

				if types.test(file.type) || types.test(file.name)

					extension = file.name.split(".")
					extension = extension[extension.length-1]
					$("#message-file").remove()
					html = '<li class="collection-item avatar">
													<a>
														<img class="circle" src=" /system/icons_documents/'+extension+'.png">
													</a>
													<span class="title" id="title'+counter_file+'">
														<div id="bar'+counter_file+"\"
														<div class=\"progress\" style=\"top: 19px\">
															<div class=\"indeterminate\"></div>
														</div>
													</span>
													<div class=\"secondary-content\" style=\"right: 60px;\" id=\"secondary"+counter_file+'">
													</div>
												</li>'

					$("#files-list").append(html)

					data.submit()
				else
					alert("El archivo complementario debe ser de formato .docx(Word), .xlsx(Excel), .pptx(PowerPoint) o .pdf ")

			done: (e, data) ->
				name = data.result[0].name
				id = data.result[0].id
				$("#bar#{counter_file}").remove()
				$("#title#{counter_file}").append(name)
				$("#secondary#{counter_file}").append('<button class="btn red lighten-1" id="'+id+'">Eliminar</button>')
				$("#secondary#{counter_file}").append('<a href=" /system/section_files/files/section_'+id_section+'/'+id+'/original/'+name+'" class="btn">Descargar</button>')
				counter_file++;
				$("#files-list > li").off "click", "button", (event) ->
					return
				$("#files-list > li").on "click", "button", (event) ->
					id = event.target.id
					jQuery.ajax
						url: "/admin/courses/#{id_course}/sections/#{id_section}/section_files/#{id}"
						cache: false
						contentType: false
						processData: false
						type: 'DELETE'
						success: ->
							event.target.parentElement.parentElement.remove()
							alert "Archivo eliminado exitosamente"
							return
						error: ->
							console.log "files error"
					return
				return


	InitializeComponentsSections = ->
		$(".submit-form-section").click ->
			if $( "#section-name" ).val().length  > 5
				$("#form-section").submit()
			else
				window.scrollTo(0,0)
			return

		GetSectionId()
		GetCourseId()

		InitializeTinymiceEditor()
		InitializeModals()
		InitializeMaterialFile()


	if PageFile == 3

		InitializeComponentsSections()

return
