/**
 * 
 */

function searchUsersByNickname(nickname) {
	
}

function searchMessagesByContent(search_content) {
	alert(search_content);
	$
	.ajax({
		type : "post",
		url : "search/messages",
		data : {
			content : search_content,
		},
		dataType : "json",
		success : function(data) {
			$
					.each(
							data,
							function() {
								$("#weibo").empty();
								var i = 0;
								while (data.returndata[i] != undefined) {
									$("#weibo")
											.append(
													/*
													 * "<li
													 * id=\"weibo_" +
													 * data.returndata[i].id +
													 * "\"><br><img
													 * class=\"weibo_icon\"
													 * src=\"pic/" +
													 * $.query
													 * .get("username") +
													 * ".jpg\"
													 * onerror=\"javascript:this.src='images/no_user_icon.png'\">" + "<span
													 * class=\"weibo_name\">" +
													 * data.returndata[i].author + "</span><span
													 * class=\"create_time\">" +
													 * data.returndata[i].create_time + "</span><br><span
													 * class=\"content\">" +
													 * data.returndata[i].content + "</span><br>转发<span
													 * class=\"repost_times\">" +
													 * data.returndata[i].repost_times + "</span>评论<span
													 * class=\"comment_times\">" +
													 * data.returndata[i].comment_times + "</span>赞<span
													 * class=\"support_times\">" +
													 * data.returndata[i].support_times //
													 * 获取评论模块 + "</span><div
													 * id=\"comment_" +
													 * data.returndata[i].id +
													 * "\"></div>" + "</li>");
													 */
													"<li id=\"weibo_"
															+ data.returndata[i].id
															+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\"javascript:void(0);\"><img src=\"\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"username\"><a href=\"javascript:void(0);\">"
															+ data.returndata[i].author
															+ "</a></div><div class=\"txt\">"
															+ data.returndata[i].content
															+ "</div><div class=\"info\"><span class=\"create_time\">"
															+ data.returndata[i].create_time
															+ "</span> <span class=\"repost_times\"></span> <span class=\"support_times\"></span><a href=\"javascript:void(0);\"><span class=\"comment\">评论("
															+ data.returndata[i].comment_times
															+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"repost\">转发("
															+ data.returndata[i].repost_times
															+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"support\">赞("
															+ data.returndata[i].support_times
															+ ")</span></a></div></div><div class=\"comtxt\">"
															+ "<div id=\"comment_"
															+ data.returndata[i].id
															+ "\" style=\"display: none\"></div>" 
															+ "</li>"
															+ "</div></li>"
											)
									i++;
								}
							});
		}
	});
	
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


