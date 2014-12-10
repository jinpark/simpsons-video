$(document).ready(function(){
	if ($.cookie('autoplay') == 'true') {
		$('video')[0].play();
		$('video').bind("ended", function(){
			window.location = $('.next-link').attr('href');
		})
	}

})