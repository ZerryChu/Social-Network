/**
 * Created by zhuzirui on 10/12/15.
 */
function show_messages() {
	$
			.ajax({
				type : "post",
				url : "message/show",
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					type : 1
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
																	+ ")</span></a></div><div class=\"comtxt\" style=\"display: none\"><textarea class=\"comarea\" name=\"content\"></textarea><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"btn\" onclick=\"send_comment()\">评论</button></div>" 
																	+ "<ul class=\"otherCom\" id=\"comment_"
																	+ data.returndata[i].id
																	+ "\" style=\"\"></ul>"
																	+ "</div></div></div></li>")
											i++;
										}
									});
				}
			});
}
// {"returnmsg":[{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:13.0"},{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:12.0"},null,null,null,null,null,null,null,null]}




