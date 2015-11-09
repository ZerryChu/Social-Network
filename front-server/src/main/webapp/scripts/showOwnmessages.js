/*
 * Created by zhuzirui on 10/13/15.
 * 
 */

var userNickname; // 当前登录用户的昵称
/**
 *  @param: _flag : true 使用缓存 
 *  ifShow ：true 显示用户信息页面 false 不显示，仅更新cookies
 */
function showOwnmessages(target, pageNumber, _flag, ifShow) {
	userNickname = target;
	$
			.ajax({
				url : 'message/show_ownmessages', // 用于文件上传的服务器端请求地址
				type : 'post',
				data : {
					nickname : userNickname,
					page : pageNumber,
					flag : _flag
				},
				dataType : 'json', // 返回值类型 一般设置为json
				success : function(data, status) // 服务器成功响应处理函数
				{
					if (ifShow) {
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
														+ $.query
																.get("username")
														+ ".jpg"
														+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"msgBox\"><div class=\"txt\">";
												if (data.returndata[i].type == 2) {
													var content = data.returndata[i].content;
													var authorWords = content
															.substr(
																	0,
																	content
																			.indexOf(';')); // 转发者说的话
													var id = content
															.substr(content
																	.indexOf(';') + 1); // 原微博id
													message += authorWords
															+ "<div class=\"repostInfo\">"
															+ "</div></div><div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"comment\">评论("
															+ data.returndata[i].comment_times
															+ ")</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发("
															+ data.returndata[i].repost_times
															+ ")</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\">赞("
															+ data.returndata[i].support_times
															+ ")</span><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div>"
															+ "</div></li>";
													$("#weibo").append(message);
													show_sourceMessage(
															id,
															data.returndata[i].id,
															1);
												} else {

													message += data.returndata[i].content
													        + "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"comment\">评论("
															+ data.returndata[i].comment_times
															+ ")</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发("
															+ data.returndata[i].repost_times
															+ ")</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\">赞("
															+ data.returndata[i].support_times
															+ ")</span><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div>"
															+ "</div></div></li>";
													$("#weibo").append(message);
												}
												i++;
											}
										})
						$(".timeago").timeago();
					}

				}
			});
}

/**
 * @content 删除用户发出的微博
 * @param   message_id
 */
function deleteOwnmessage(message_id) {
	$.ajax({
		url : 'message/delete', // 用于文件上传的服务器端请求地址
		type : 'post',
		async : false,
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			id : message_id
		},
		dataType : 'json', // 返回值类型 一般设置为json
		success : function(data, status) // 服务器成功响应处理函数
		{
			if (data.msg == 1) {
				var num = $("#message_num").text();
				$("#message_num").text(Number.parseInt(num) - 1); // 广播数-1
				showOwnmessages(userNickname, 1, 1, true);
			} else {
				alert("fail");
			}
		}
	})
}

$(".delete_msg").live('click', function() {
	var ret = confirm("确认删除?");
	if (ret == true) {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		deleteOwnmessage(message_id);
		showUserInfo(1, true);
	}
});

