var history_data = $('#history-data').data('history')

var render = function(video){
	var template_dom = $("#history-template").html();
	var template = _.template(template_dom)
	var vars = {video: video};
	var html = template(vars)
	$("#history").append(html);
}

var watched_index = history_data.length;
while( watched_index-- ) {
    if( history_data[watched_index].watched === true ) break;
}

var chunk = 10;
var paged_array = [];
var history_length =history_data.length
for (var i=0; i < history_length; i =+ chunk){
	paged_array.push(history_data.slice(i,i+chunk));
}

var watched_page = Math.floor(watched_index/chunk)

$('#page_counter').twbsPagination({
    totalPages: paged_array.length,
    visiblePages: 7,
    startPage: watched_page + 1,
    onPageClick: function (event, page) {
    	$("#history").html('');
        for (var i=0; i < chunk; i++) {
        	render(paged_array[page - 1][i])
        }
    }
});

for (var i=0; i < chunk; i++) {
	render(paged_array[watched_page][i])
}