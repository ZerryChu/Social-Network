/**
 * 
 */

function searchUsersByNickname(nickname) {
	
}

function searchMessagesByContent(content) {
	
	
}

function search() {
	var search_text = $(".search_text").val();
	if($(".search_type").val() == 1) {
		searchUsersByNickname(search_text);
	}
	else {
		searchMessagesByContent(search_text)
	}
}


