document.addEventListener 'turbolinks:load', ->
	$('.container-slick-menu').slick
		infinite: true
		slidesToShow:2,
		slidesToScroll: 1,
		arrows: true,
		autoplay: true,
		autoplaySpeed: 2000
		prevArrow: $('.arrow-left')
		nextArrow: $('.arrow-right')
