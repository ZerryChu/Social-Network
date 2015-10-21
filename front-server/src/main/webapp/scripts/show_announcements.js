/**
 * Created by zhuzirui on 10/13/15.
 */
function show_announcements() {
	$
			.ajax({
				url : 'message/show_announcements', // 用于文件上传的服务器端请求地址
				type : 'post',
				data : {
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
																	+ "\" class=\"msgBox\"><div class=\"txt\">"
																	+ data.returndata[i].content
																	+ "</div><div class=\"info\"><span class=\"create_time\">"
																	+ data.returndata[i].create_time
																	+ "</span></div>"

													)
													i++;
										}
									})
				}
			})
}