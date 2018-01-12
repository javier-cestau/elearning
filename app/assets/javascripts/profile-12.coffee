document.addEventListener 'turbolinks:load', ->
	listHeight = "185px"
	$('.toggle-list a').click ->

		class_ul = $(this).data("list")
		$(".toggleList-#{class_ul}").toggleClass 'toggleExpanded'
		$(".mask-#{class_ul}").toggle()

		max_height = $(".#{class_ul}").css "max-height"
		height =  $(".#{class_ul}").prop('scrollHeight'); #scrollHeight es el tamaño real del contenedor sin contar el min-height
		# Si el tamaño actual es diferente al tamaño minimo significa que el menu esta expandido
		height_to_list = if max_height != listHeight then listHeight else height+"px"

		$(".#{class_ul}").css("max-height","#{height_to_list}")
