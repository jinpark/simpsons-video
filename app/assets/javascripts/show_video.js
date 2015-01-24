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
	});
	videojs('main-video').ready(function() {
	  this.hotkeys({
	    volumeStep: 0.1,
	    seekStep: 5,
	    enableMute: true,
	    enableFullscreen: true
	  });
	  this.on('play', function(){
	  	$(this).focus();
	  });
	  this.on('pause', function(){
	  	$(this).focus();
	  })
	});
	$('#main-video').focus();

	videojs('main-video').ready(function() {
		var video = this;
		$('#new_screenshot').on('ajax:before', function() {
			var canvas = document.createElement('canvas');
			canvas.width = 1280;
			canvas.height = 720;
			var ctx = canvas.getContext('2d');
			ctx.drawImage(video.I, 0, 0, canvas.width, canvas.height);
			var dataURI = canvas.toDataURL('image/png');
			$(this).find('#screenshot_data_uri').val(dataURI);
			$(this).find('#screenshot_time').val(video.currentTime());
		})
		$('#new_screenshot').on('ajax:success',function (event, data, status, xhr) {
			window.open(data.attachment.attachment.url, '_blank');
		})
		$('#new_screenshot').on('ajax:complete',function (event, data, status, xhr) {
			$(this).find('#screenshot_data_uri').val('');
		})


	})
})