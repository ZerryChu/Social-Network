/**
 * @content 首页条按内容搜索微博功能
 * @param   search_content
 * @notice  弃用
 */
function searchMessagesByContent(search_content) {
	$
			.ajax({
				type : "post",
				url : "search/messages",
				data : {
					content : search_content
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

											var message = "<li  class=\"weibo_message\" id=\"weibo_"
													+ data.returndata[i].id
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\""
													+ "userinfo.jsp?username="
													+ $.query.get("username")
													+ "&targetNickname="
													+ data.returndata[i].author.nickname
													+ "\"><img src=\""
													+ "pic/"
													+ data.returndata[i].author.username
													+ ".jpg"
													+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"weibo_username\"><a href=\""
													+ "userinfo.jsp?targetNickname="
													+ data.returndata[i].author.nickname
													+ "\">"
													+ data.returndata[i].author.nickname
													+ "</a></div><div class=\"txt\">";
											if (data.returndata[i].type == 2) { // 属于转发的微博
												var content = data.returndata[i].content;
												var authorWords = content
														.substr(0, content
																.indexOf(';')); // 转发者说的话
												var id = content.substr(content
														.indexOf(';') + 1); // 原微博id
												message += authorWords
														+ "<div class=\"repostInfo\">"
														+ "</div></div>"
														+ "<div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)</span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
														+ data.returndata[i].id
														+ "\" name=\"\" style=\"height: 40px; width: 498px;\"></textarea><div class=\"repost_btn\"><button class=\"repost_button\">转发</button></div></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
														+ data.returndata[i].id
														+ "\" name=\"content\"></textarea><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"comment_button\">评论</button></div>"
														+ "<ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></ul>"
														+ "</div></div></div></li>";
												$("#weibo").append(message);
												show_sourceMessage(
														id,
														data.returndata[i].id,
														data.returndata[i].source_message.nickname,
														data.returndata[i].source_message.content,
														data.returndata[i].source_message.pic,
														data.returndata[i].source_message.create_time,
														data.returndata[i].source_message.comment_times,
														data.returndata[i].source_message.repost_times,
														data.returndata[i].source_message.support_times);
											} else { // 原创微博
												message += data.returndata[i].content
														+ "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)</span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
														+ data.returndata[i].id
														+ "\" name=\"\" style=\"height: 40px; width: 498px;\"></textarea><div class=\"repost_btn\"><button class=\"repost_button\">转发</button></div></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
														+ data.returndata[i].id
														+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"comment_button\">评论</button></div>"
														+ "<ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></ul>"
														+ "</div></div></div></li>";
												$("#weibo").append(message);
											}

											judgeIfSupport(
													data.returndata[i].id, data.returndata[i].supported);

											i++;
										}
									});
					$(".timeago").timeago();
				}
			});

}

/**
 * type=1 搜人 type=2 搜微博
 */
function search() {
	var search_text = $(".search_text").val();
	if (search_text == undefined || content == "") {
		alert("no content.");
		return;
	}
	
	if ($(".search_type").val() == 1) {
		//searchUsersByNickname(search_text);
		window.open("searchfriend.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&content=" + search_text + "&type=1");
	} else {
		//searchMessagesByContent(search_text)
		window.open("searchfriend.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&content=" + search_text + "&type=2");
	}
}
