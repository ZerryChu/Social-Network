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
											$("#messages")
													.append(
															"<div id=\""
																	+ i
																	+ "\" class=\"weiboinfo\"><br><span class=\"weibo_name\">"
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
																	+ "</span>");
											i++;
										}
									});
				}
			});
}
//{"returnmsg":"[{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05 22:15:13.0"},{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05 22:15:12.0"},null,null,null,null,null,null,null,null]"}