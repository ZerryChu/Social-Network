/**
 * Created by zhuzirui on 10/12/15.
 */
// flag ：0 缓存show 1 非缓存show
function show_messages(pageNumber, _flag) {
	$
			.ajax({
				type : "post",
				url : "message/show",
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					page : pageNumber,
					flag : _flag
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
											// ///////////////////////////////////////
											var username;
											var targetNickname = data.returndata[i].author;
											$
													.ajax({
														type : "post",
														url : "user/getTargetinfo",
														data : {
															nickname : targetNickname
														},
														dataType : "json",
														success : function(data) {
															$
																	.each(
																			data,
																			function() {
																				username = data.returndata.username;
																			});
														}
													});
											// ////////////////////////////////////////

											$("#weibo")
													.append(
															"<li  class=\"weibo_message\" id=\"weibo_"
																	+ data.returndata[i].id
																	+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\""
																	+ "userinfo.jsp?targetNickname="
																	+ data.returndata[i].author
																	+ "\"><img src=\""
																	+ "pic/"
																	+ username
																	+ ".jpg"
																	+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"username\"><a href=\""
																	+ "userinfo.jsp?targetNickname="
																	+ data.returndata[i].author
																	+ "\">"
																	+ data.returndata[i].author
																	+ "</a></div><div class=\"txt\">"
																	+ data.returndata[i].content
																	+ "</div><div class=\"info\"><span class=\"create_time\">"
																	+ data.returndata[i].create_time
																	+ "</span><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
																	+ data.returndata[i].comment_times
																	+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
																	+ data.returndata[i].repost_times
																	+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:3%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
																	+ data.returndata[i].support_times
																	+ "</span>)</span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea class=\"comarea_"
																	+ data.returndata[i].id
																	+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"btn\">评论</button></div>"
																	+ "<ul class=\"otherCom\" id=\"comment_"
																	+ data.returndata[i].id
																	+ "\" style=\"\"></ul>"
																	+ "</div></div></div></li>");
											judgeIfSupport(
													data.returndata[i].id, 0); // 引入 judgeIfSupport.js
											i++;
										}
									});
				}
			});
}
