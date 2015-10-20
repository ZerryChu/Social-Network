/**
 * Created by zhuzirui on 10/13/15.
 */
function showOwnmessages(target) {
	$
			.ajax({
				url : 'message/show_ownmessages', // 用于文件上传的服务器端请求地址
				type : 'post',
				data : {
					nickname : target,
				},
				dataType : 'json', // 返回值类型 一般设置为json
				success : function(data, status) // 服务器成功响应处理函数
				{
					$
							.each(
									data,
									function() {
										var i = 0;
										$("#weibo").empty();
										while (data.returndata[i] != undefined) {
											$("#weibo")
													.append(
															"<li id=\"weibo_"
																	+ data.returndata[i].id
																	+ "\"><div class=\"txt\">"
																	+ data.returndata[i].content
																	+ "</div><div class=\"info\"><span class=\"create_time\">"
																	+ data.returndata[i].create_time
																	+ "</span> <span class=\"repost_times\"></span> <span class=\"support_times\"></span><span class=\"comment\">评论("
																	+ data.returndata[i].comment_times
																	+ ")</span><span class=\"repost\">转发("
																	+ data.returndata[i].repost_times
																	+ ")</span><span class=\"support\">赞("
																	+ data.returndata[i].support_times
																	+ ")</span></div>"

													)
													i++;
										}
									})
				}
			})
}
