/*
 * Created by zhuzirui on 10/13/15.
 * 
 */

var userNickname; // 当前登录用户的昵称
/**
 * @param: _flag : true 使用缓存 ifShow ：true 显示用户信息页面 false 不显示，仅更新cookies
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
												var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
												var message = "<li id=\"weibo_"
														+ data.returndata[i].id
														+ "\"><div style=\"display: none; padding-left: 30%;\" class=\"delete_confirm\">确定删除吗？<button onclick=\"deleteOwnmessage('"
														+ data.returndata[i].id 
														+ "');showUserInfo(1, true);\">确认</button><button onclick=\"$(this).parents('.delete_confirm').slideUp();\">取消</button></div><div class=\"weiboinfo\"><div class=\"userPic\"><img src=\""
														+ "pic/"
														+ $.query
																.get("username")
														+ ".jpg"
														+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"msgBox\"><div class=\"txt\">";
												if (data.returndata[i].type == 2) {
													var content = return_content
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
															+ "</div></div>";
													message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
															+ data.returndata[i].comment_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
															+ data.returndata[i].repost_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"\" onclick=\"\">(<span class=\"num\">"
															+ data.returndata[i].support_times
															+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
															+ data.returndata[i].id
															+ "\" name=\"\" style=\"height: 40px; width: 498px;\"></textarea><span class=\"rpt_emotion\" id=\"rpt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"repost_btn\"><button class=\"repost_button\">转发</button></div></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
															+ data.returndata[i].id
															+ "\" name=\"content\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"comment_button\">评论</button></div>"
															+ "<ul class=\"otherCom\" id=\"comment_"
															+ data.returndata[i].id
															+ "\" style=\"\"></ul>"
															+ "</div></div><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div></li>";
													$("#weibo").append(message);
													show_sourceMessage(
															id,
															data.returndata[i].id,
															1);
												} else {

													message += return_content
															+ "</div>";
													if (data.returndata[i].pic != undefined
															&& data.returndata[i].pic != "")
														message += "<br><img class=\"msg_pic\" alt=\"点击显示原图\" src=\"message/"
																+ data.returndata[i].pic
																+ ".jpg\">";	
													message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
															+ data.returndata[i].comment_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
															+ data.returndata[i].repost_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
															+ data.returndata[i].support_times
															+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
															+ data.returndata[i].id
															+ "\" name=\"\" style=\"height: 40px; width: 498px;\"></textarea><span class=\"rpt_emotion\" id=\"rpt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"repost_btn\"><button class=\"repost_button\">转发</button></div></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
															+ data.returndata[i].id
															+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"comment_btn\"><div class=\"andforward\"><input type=\"checkbox\" value=\"1\" name=\"forward\" id=\"forward\" /><label for=\"forward\">同时转发</label></div><button class=\"comment_button\">评论</button></div>"
															+ "<ul class=\"otherCom\" id=\"comment_"
															+ data.returndata[i].id
															+ "\" style=\"\"></ul>"
															+ "</div></div><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div></li>";
													$("#weibo").append(message);
												}
												judgeIfSupport(
														data.returndata[i].id,
														0);
												// judgeIfSupport.js

												var textarea = ".rptarea_"
														+ data.returndata[i].id;
												var emotion = '#rpt_emotion'
														+ data.returndata[i].id;
												// /////////////////////////////////////
												$(emotion).qqFace({
													assign : textarea, // 给输入框赋值
													path : 'face/' // 表情图片存放的路径
												});

												var textarea = ".comarea_"
														+ data.returndata[i].id;
												var emotion = '#cmt_emotion'
														+ data.returndata[i].id;
												$(emotion).qqFace({
													assign : textarea, // 给输入框赋值
													path : 'face/' // 表情图片存放的路径
												});
												// /////////////////////////////////////
												i++;
											}
										})
						$(".timeago").timeago();
						$(".msg_pic").bigic();
					}

				}
			});
}

/**
 * @content 删除用户发出的微博
 * @param message_id
 */
function deleteOwnmessage(message_id) {
	$.ajax({
		url : 'message/delete',
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
				$("#message_num").text(parseInt(num, 10) - 1); // 广播数-1
				showOwnmessages(userNickname, 1, 1, true);
			} else {
				alert("fail");
			}
		}
	})
}

$(".delete_msg").live('click', function() {
	$(this).parents("li").find(".delete_confirm").slideDown();

	/*var ret = confirm("确认删除?");
	if (ret == true) {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		deleteOwnmessage(message_id);
		showUserInfo(1, true);
	}*/
});
