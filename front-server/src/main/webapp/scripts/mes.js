/**
 * Created by zhuzirui on 10/12/15.
 */

/**
 * @content 通过author获取用户的用户名
 */
function getUsernameByNickname(targetNickname) {
	$.ajax({
		type : "post",
		url : "user/getTargetinfo",
		data : {
			nickname : targetNickname
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				return data.returndata.username;
			});
		}
	});
}

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
															"<li id=\"weibo_"
																	+ data.returndata[i].id
																	+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\""
																	+ "userinfo.jsp?targetNickname="
																	+ data.returndata[i].author
																	+ "\"><img class=\"icon\" src=\""
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
																	+ "</span> <span class=\"repost_times\"></span> <span class=\"support_times\"></span><a href=\"javascript:void(0);\"><span class=\"comment\">评论("
																	+ data.returndata[i].comment_times
																	+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"repost\">转发("
																	+ data.returndata[i].repost_times
																	+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"support\"><img class=\"zan\" style=\"width:3%; height:50%;\" src=\"judgeIfSupport(10);\">("
																	+ data.returndata[i].support_times
																	+ ")</span></a></div><div style=\"display: none\" id=\"comment_"
																	+ data.returndata[i].id
																	+ "\" class=\"comtxt\"><textarea class=\"comarea\"></textarea>"
																	+ "<ul class=\"otherCom\"><li></li>"
																	+ "</div></div></div></li></ul>")
											i++;
										}
									});
				}
			});
}
// {"returnmsg":[{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:13.0"},{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:12.0"},null,null,null,null,null,null,null,null]}

