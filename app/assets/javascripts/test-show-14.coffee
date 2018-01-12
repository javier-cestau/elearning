$("body").on "click", ".ui-widget-overlay", ->
	$('#dialog-confirm').dialog 'close'


# File to init devTool checking
devToolTest = ->
	devtools =
		open: false
		orientation: null
	threshold = 160

	emitEvent = (state, orientation) ->
		window.dispatchEvent new CustomEvent('devtoolschange', detail:
			open: state
			orientation: orientation)
		return

	setInterval (->
		widthThreshold = window.outerWidth - (window.innerWidth) > threshold
		heightThreshold = window.outerHeight - (window.innerHeight) > threshold
		orientation = if widthThreshold then 'vertical' else 'horizontal'
		if !(heightThreshold and widthThreshold) and (window.Firebug and window.Firebug.chrome and window.Firebug.chrome.isInitialized or widthThreshold or heightThreshold)
			if !devtools.open or devtools.orientation != orientation
				emitEvent true, orientation
			devtools.open = true
			devtools.orientation = orientation
		else
			if devtools.open
				emitEvent false, null
			devtools.open = false
			devtools.orientation = null
		return
	), 500
	if typeof module != 'undefined' and module.exports
		module.exports = devtools
	else
		window.devtools = devtools
	return

InitCss = ->
	$('[type="radio"] + label:before').css("display", "block")
	$('[type="radio"] + label:after').css("display", "block")


InitTestShow= ->
	InitCss()
	devToolTest()
	window.addEventListener 'devtoolschange', (e) ->
		console.log "Función bloqueada por motivos de seguridad"
		console.log 'is DevTools open?', e.detail.open
		return
	form = $(".edit_test")
	if gon.time_limit > 0
		send_it = false
		clock = new FlipClock($('.clock'), gon.time_limit*60,
			clockFace: 'MinuteCounter'
			language: "es-es"
			countdown: true
			stop: ->
				if !send_it
					$(form).submit()
				send_it = true
		)

	$(".submit").click ->
		has_respond_all = true
		inputs_boxes = $(".edit_test").find(".container_answer > p > input")
		$(inputs_boxes).each ->
			if!($("input[name='#{$(this).prop("name")}']").is(':checked'))
				has_respond_all = false
		if !has_respond_all
			$('#dialog-confirm').dialog
				resizable: false
				height: 'auto'
				width: 400
				modal: true
				buttons:
					'Enviar de todas formas': ->
						$(form).submit()
						$(this).dialog 'close'
						return
					"Cancelar": ->
						$(this).dialog 'close'
						return
		else if confirm("¿Quiere enviar el examen para ser corregido?")
			$(form).submit()

document.addEventListener 'turbolinks:load', ->

	if PageFile == 14
		InitTestShow()
