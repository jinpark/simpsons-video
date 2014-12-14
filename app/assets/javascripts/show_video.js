$(document).ready(function(){
	if ($.cookie('autoplay') == 'true') {
		$('.autoplay-btn').addClass('active');
		$('video')[0].play();
		$('video').bind("ended", function(){
			window.location = $('.next-link').attr('href');
		})
	} 
	$('.autoplay-btn').on('click', function(){
		if ($.cookie('autoplay') == 'true') {
			$.cookie('autoplay', 'false');
			$('.autoplay-btn').removeClass('active');
			$('video')[0].play();
		} else {
			$.cookie('autoplay', 'true');
			$('.autoplay-btn').addClass('active');
		}
	})
})