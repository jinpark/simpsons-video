$(document).ready(function(){
	if ($.cookie('autoplay') == true) {
		$('video').play();
		$('video').bind("ended", function(){
			window.location($('.next-link').src)
		})
	}

})