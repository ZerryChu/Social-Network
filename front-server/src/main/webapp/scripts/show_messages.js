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
										var i = 0;
										while (data.returndata[i].author != null) {
											$(".weibo")
													.append(
															"<li id=\"weibo_"
																	+ data.returndata[i].id
																	+ "\"><br><img class=\"weibo_icon\" src=\"pic/"
																	+ $.query
																			.get("username")
																	+ ".jpg\" onerror=\"javascript:this.src='images/no_user_icon.png'\">"
																	+ "<span class=\"weibo_name\">"
																	+ data.returndata[i].author
																	+ "</span><span class=\"create_time\">"
																	+ data.returndata[i].create_time
																	+ "</span><br><span class=\"content\">"
																	+ data.returndata[i].content
																	+ "</span><br>转发<span class=\"repost_times\">"
																	+ data.returndata[i].repost_times
																	+ "</span>评论<span class=\"comment_times\">"
																	+ data.returndata[i].comment_times
																	+ "</span>赞<span class=\"support_times\">"
																	+ data.returndata[i].support_times
																	// 获取评论模块
																	+ "</span><div id=\"comment_"
																	+ data.returndata[i].id
																	+ "\"></div>"
																	+ "</li>");
											i++;
										}
									});
				}
			});
}
// {"returnmsg":[{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:13.0"},{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05
// 22:15:12.0"},null,null,null,null,null,null,null,null]}
