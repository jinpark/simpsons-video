$(document).ready(function(){
	videojs('main-video').ready(function() {
		var video = this;
		// setup hotkeys
		this.hotkeys({
	    	volumeStep: 0.1,
	    	seekStep: 5,
	    	enableMute: true,
	    	enableFullscreen: true
		});
		// force focus on video so hotkeys work
		$(this).focus();
		this.on('play', function(){
	  		$(this).focus();
	  	});
	  	this.on('pause', function(){
	  		$(this).focus();
	  	})

	  	// screenshot function
		$('#new_screenshot').on('ajax:before', function() {
			var canvas = document.createElement('canvas');
			canvas.width = video.I.videoWidth * 2;
			canvas.height = video.I.videoHeight * 2;
			var ctx = canvas.getContext('2d');
			ctx.drawImage(video.I, 0, 0, canvas.width, canvas.height);
			var dataURI = canvas.toDataURL('image/png');
			$(this).find('#screenshot_data_uri').val(dataURI);
			$(this).find('#screenshot_time').val(video.currentTime());
		})
		// open new window with screenshot
		$('#new_screenshot').on('ajax:success',function (event, data, status, xhr) {
			window.open(data.attachment.attachment.url, '_blank');
		})
		// clear form to save on dom
		$('#new_screenshot').on('ajax:complete',function (event, data, status, xhr) {
			$(this).find('#screenshot_data_uri').val('');
		})

		// autoplay stuff
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
	})
})
