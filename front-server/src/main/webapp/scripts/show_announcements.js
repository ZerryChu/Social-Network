/**
 * Created by zhuzirui on 10/13/15.
 */
function show_announcements(_flag) {
	$
			.ajax({
				url : 'message/show_announcements',
				type : 'post',
				data : {
					flag : _flag
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
											var message = "<li id=\"weibo_"
													+ data.returndata[i].id
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><img src=\""
													+ "pic/"
													+ data.returndata[i].author
													+ ".jpg"
													+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"msgBox\"><div class=\"txt\">";
											message += data.returndata[i].content
													+ "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
													+ data.returndata[i].create_time
													+ "\"></time></div>"
													+ "</div></div></li>";
											$("#weibo").append(message);
											i++;
										}
										$(".timeago").timeago();
									})
				}
			})
}