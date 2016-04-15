/*
 * Created by zhuzirui on 10/12/15.
 */

function show_label() {
	$.ajax({
		type : "post",
		// async : false,
		url : "label/show",
		data : {},
		dataType : "json",
		success : function(data) {
			if (data.returndata != undefined) {
				$(".rec1 .rec_nickname").empty()
						.append(data.returndata[0].name);
				$(".rec2 .rec_nickname").empty()
						.append(data.returndata[1].name);
				$(".rec3 .rec_nickname").empty()
						.append(data.returndata[2].name);
				$(".rec4 .rec_nickname").empty()
						.append(data.returndata[3].name);
				$(".rec1 .val").empty().append(data.returndata[0].times);
				$(".rec2 .val").empty().append(data.returndata[1].times);
				$(".rec3 .val").empty().append(data.returndata[2].times);
				$(".rec4 .val").empty().append(data.returndata[3].times);
				$(".rec1").attr("id", data.returndata[0].id);
				$(".rec2").attr("id", data.returndata[1].id);
				$(".rec3").attr("id", data.returndata[2].id);
				$(".rec4").attr("id", data.returndata[3].id);
			}
		}
	});
}

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
											var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
											var message = "<li  class=\"weibo_message\" id=\"weibo_"
													+ data.returndata[i].id
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\"userinfo.jsp?username="
													+ $.query.get("username")
													+ "&targetNickname="
													+ data.returndata[i].author.nickname
													+ "&userToken="
													+ $.query.get("userToken")
													+ "\"><img title=\"查看用户信息\" src=\"pic/"
													+ data.returndata[i].author.username
													+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"weibo_username\"><a href=\"userinfo.jsp?targetNickname="
													+ data.returndata[i].author.nickname
													+ "&username="
													+ $.query.get("username")
													+ "&userToken="
													+ $.query.get("userToken")
													+ "\">"
													+ data.returndata[i].author.nickname
													+ "</a></div>";

											if (data.returndata[i].type == 2) { // 属于转发的微博
												var content = return_content;
												var authorWords = content
														.substr(0, content
																.indexOf(';')); // 转发者说的话
												var id = content.substr(content
														.indexOf(';') + 1); // 原微博id
												message += authorWords
														+ "<div class=\"repostInfo\"></div>";
												message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)&转发(<span class=\"rpt_num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
														+ data.returndata[i].id
														+ "\" name=\"content\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
														+ data.returndata[i].id
														+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div><ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></div></ul></div></div></div></li>";
												$("#weibo").append(message);
												// 获取原微博
												show_sourceMessage(
														data.returndata[i].source_message.id,
														data.returndata[i].id,
														data.returndata[i].source_message.nickname,
														data.returndata[i].source_message.content,
														data.returndata[i].source_message.pic,
														data.returndata[i].source_message.create_time,
														data.returndata[i].source_message.comment_times,
														data.returndata[i].source_message.repost_times,
														data.returndata[i].source_message.support_times);
											} else { // 原创微博
												message += return_content;
												if (data.returndata[i].label_id != 0)
													message += "<div id=\"lbl"
															+ data.returndata[i].label_id
															+ "\" class=\"msg_label\"><span id=\"l_icon\" class=\"icon\"></span>"
															+ data.returndata[i].label_name
															+ "</div>";
												if (data.returndata[i].pic != undefined
														&& data.returndata[i].pic != "")
													message += "<br><img class=\"msg_pic\" title=\"点击显示原图\" src=\"message/"
															+ data.returndata[i].pic
															+ ".jpg\">";
												message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)&转发(<span class=\"rpt_num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
														+ data.returndata[i].id
														+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
														+ data.returndata[i].id
														+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div><ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></ul></div></div></div></li>";
												$("#weibo").append(message);
											}
											judgeIfSupport(
													data.returndata[i].id,
													data.returndata[i].supported);

											var textarea = ".comarea_"
													+ data.returndata[i].id;
											var emotion = '#cmt_emotion'
													+ data.returndata[i].id;
											$(emotion).qqFace({
												assign : textarea, // 给输入框赋值
												path : 'face/' // 表情图片存放的路径
											});

											i++;
										}
									});
					$(".timeago").timeago();
					$(".msg_pic").bigic();
				}
			});
}

/**
 * @content 显示指定的被转发的微博
 * @param id
 *            原微博id
 * @param _id
 *            转发者id
 */
function show_sourceMessage(id, _id, nickname, content, pic, create_time,
		comment_times, repost_times, support_times) {
	var weiboId = "#weibo_" + _id;
	var repostInfo = $(weiboId).find(".repostInfo");
	repostInfo.attr("id", id);
	var message = "<div class=\"weibo_username\"><span style=\"color: #006a92;\">"
			+ nickname
			+ "</span></div><div class=\"txt\">"
			+ content
			+ "</div>";
	if (pic != undefined && pic != "")
		message += "<img class=\"msg_pic\" src=\"message/" + pic + ".jpg\">";
	message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
			+ create_time
			+ "\"></time><span class=\"num_info\"><span>评论(<span class=\"comment_num\">"
			+ comment_times
			+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>转发(<span class=\"repost_num\">"
			+ repost_times
			+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>点赞(<span class=\"support_num\">"
			+ support_times + "</span>)</span></span></div>";
	$(repostInfo).append(message);
	$(".timeago").timeago();

}

$(".repostInfo").live(
		'click',
		function() {
			var param = "username=" + $.query.get("username") + "&userToken="
					+ $.query.get("userToken") + "&id=" + $(this).attr("id");
			window.open("message.jsp?" + param);
		});

/*
 * Created by zhuzirui on 10/13/15.
 */

/**
 * @content 接收系统公告（管理员发的微博）
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
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><img src=\"pic/"
													+ data.returndata[i].author.nickname
													+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"msgBox\"><div class=\"txt\">";
											message += data.returndata[i].content
													+ "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
													+ data.returndata[i].create_time
													+ "\"></time></div></div></div></li>";
											$("#weibo").append(message);
											i++;
										}
										$(".timeago").timeago();
									})
				}
			})
}

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
														+ "');showUserInfo(1, true);\">确认</button><button onclick=\"$(this).parents('.delete_confirm').slideUp();\">取消</button></div><div class=\"weiboinfo\"><div class=\"userPic\"><img src=\"pic/"
														+ $.query
																.get("username")
														+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"msgBox\"><div class=\"txt\">";
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
															+ "<div class=\"repostInfo\"></div></div>";
													message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
															+ data.returndata[i].comment_times
															+ "</span>)&转发(<span class=\"rpt_num\">"
															+ data.returndata[i].repost_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"\" onclick=\"\">(<span class=\"num\">"
															+ data.returndata[i].support_times
															+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
															+ data.returndata[i].id
															+ "\" name=\"content\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div><ul class=\"otherCom\" id=\"comment_"
															+ data.returndata[i].id
															+ "\" style=\"\"></ul></div></div><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div></li>";
													$("#weibo").append(message);
													show_sourceMessage(
															data.returndata[i].source_message.id,
															data.returndata[i].id,
															data.returndata[i].source_message.nickname,
															data.returndata[i].source_message.content,
															data.returndata[i].source_message.pic,
															data.returndata[i].source_message.create_time,
															data.returndata[i].source_message.comment_times,
															data.returndata[i].source_message.repost_times,
															data.returndata[i].source_message.support_times);
												} else {

													message += return_content;
													if (data.returndata[i].label_id != 0)
														message += "<div id=\""
																+ data.returndata[i].label_id
																+ "\" class=\"msg_label\"><span id=\"l_icon\" class=\"icon\"></span>"
																+ data.returndata[i].label_name
																+ "</div>";
													message += "</div>";
													if (data.returndata[i].pic != undefined
															&& data.returndata[i].pic != "")
														message += "<br><img class=\"msg_pic\" title=\"点击显示原图\" src=\"message/"
																+ data.returndata[i].pic
																+ ".jpg\">";
													message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
															+ data.returndata[i].create_time
															+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
															+ data.returndata[i].comment_times
															+ "</span>)&转发(<span class=\"rpt_num\">"
															+ data.returndata[i].repost_times
															+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
															+ data.returndata[i].support_times
															+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
															+ data.returndata[i].id
															+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
															+ data.returndata[i].id
															+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div><ul class=\"otherCom\" id=\"comment_"
															+ data.returndata[i].id
															+ "\" style=\"\"></ul></div></div><img align=\"right\" class=\"delete_msg\" style=\"width:10px; height:10px;\" src=\"images/delete.jpg\"></div></li>";
													$("#weibo").append(message);
												}
												judgeIfSupport(
														data.returndata[i].id,
														data.returndata[i].supported);

												var textarea = ".comarea_"
														+ data.returndata[i].id;
												var emotion = '#cmt_emotion'
														+ data.returndata[i].id;
												$(emotion).qqFace({
													assign : textarea, // 给输入框赋值
													path : 'face/' // 表情图片存放的路径
												});
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

	/*
	 * var ret = confirm("确认删除?"); if (ret == true) { var message_id =
	 * $(this).parents("li").attr("id"); message_id = message_id.substr(6);
	 * deleteOwnmessage(message_id); showUserInfo(1, true); }
	 */
});

/**
 * @content 转发微博 flag = 0: 不更新userinfo
 */
function repost_message(_content, message_id, flag) {
	if (checkSubmit(2000)) {
		$.ajax({
			type : "post",
			url : "message/repost",
			async : false, // 发帖同步执行
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				content : _content,
				id : message_id
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.msg == 1) {
						// ...add content
						alert("succeed");
						// 页面数据更新
						if (flag == 1)
							showUserInfo(1, true);
						var nickname = $("#nickname").text();
						// showOwnmessages(nickname, 1, 1, false);
						var textarea = ".comarea_" + message_id;
						$(textarea).val("");
						var weibo = "#weibo_" + message_id;
						var num = $(weibo).find(".comment").find(".rpt_num")
								.text();
						$(weibo).find(".comment").find(".rpt_num").text(
								parseInt(num, 10) + 1); // 转发数+1
					} else {
						// ...tell fail
						alert("fail");
					}
				});
			}
		});
	}
}

/*
 * Created by zhuzirui on 10/12/15.
 */

/**
 * @content 删除评论
 */

function show_delete_confirm(id) {
	var div = "#cmt_" + id;
	$(div).find(".delete_confirm").slideDown();
}

function delete_comment(comment_id, _nickname, _message_id) {
	/*
	 * var ret = confirm("确认删除?"); if (ret == false) return;
	 */

	$.ajax({
		type : "post",
		url : "comment/delete",
		async : false, // 发帖同步执行
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			nickname : _nickname,
			message_id : _message_id,
			id : comment_id
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					var weibo = "#weibo_" + _message_id;
					var num = $(weibo).find(".comment").find(".num").text();
					$(weibo).find(".comment").find(".num").text(
							parseInt(num, 10) - 1); // 评论数-1
					show_comments(_message_id, 1, 1);
				} else {
					alert("fail.");
				}
			});
		}
	});
}

function show_comments(message_id, pageNumber, _flag) {
	$
			.ajax({
				type : "post",
				url : "comment/show",
				async : false, // 发帖同步执行
				data : {
					id : message_id,
					page : pageNumber,
					flag : _flag
				},
				dataType : "json",
				success : function(data) {
					$
							.each(
									data,
									function() {
										var i = 0;
										var target = "#comment_" + message_id;
										$(target).empty();
										while (data.returndata[i] != undefined) {
											var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
											$(target)
													.append(
															"<li><div id=\"cmt_"
																	+ data.returndata[i].id
																	+ "\" class=\"msgBox\" style=\"width:100%;\"><div style=\"display: none; padding-left: 30%;\" class=\"delete_confirm\">确定删除吗？<button onclick=\"delete_comment("
																	+ data.returndata[i].id
																	+ ",'"
																	+ data.returndata[i].nickname
																	+ "',"
																	+ message_id
																	+ ")\">确认</button><button onclick=\"$(this).parents('.delete_confirm').slideUp();\">取消</button></div><div class=\"txt\">"
																	+ "<a href=\"javascript:void(0);\" class=\"comer_name\">"
																	+ data.returndata[i].nickname
																	+ "</a>: <span class=\"content\">"
																	+ return_content
																	+ "</span><div class=\"info\"><img class=\"delete_cmt\" align=\"right\" style=\"margin-right: 30px; width: 10px; height: 10px;\" src=\"images/delete.jpg\" onclick=\"show_delete_confirm("
																	+ data.returndata[i].id
																	+ ")\"><time class=\"timeago\" datetime=\""
																	+ data.returndata[i].create_time
																	+ "\"></time></span></div>"
																	+ "</div></div></li>");
											i++;
										}
										$(target)
												.append(
														"<div class=\"cmt_getPageNum\" align=\"center\"><span class=\"cmt_prePage\" onclick=\"cmt_prePage("
																+ message_id
																+ ")\">上一页</span><span class=\"cmt_nextPage\" onclick=\"cmt_nextPage("
																+ message_id
																+ ")\">下一页</span><span class=\"pageNum\"></span></div>");
										$(".timeago").timeago();
									});
				},
				error : function(data) {
					var target = "#comment_" + message_id;
					$(target).empty();

				}
			});
}

/*
 * Created by zhuzirui on 10/12/15.
 */

/**
 * @content 评论微博
 */
function send_comment(message_id, comment_content) {
	if (checkSubmit(2000)) {
		$.ajax({
			type : "post",
			url : "message/comment",
			async : false, // 发帖同步执行
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				id : message_id,
				content : comment_content,
			},
			dataType : "json",
			success : function(data) {
				$.each(data,
						function() {
							if (data.msg == 1) {
								var weibo = "#weibo_" + message_id;
								var num = $(weibo).find(".comment")
										.find(".num").text();
								$(weibo).find(".comment").find(".num").text(
										parseInt(num, 10) + 1); // 评论数+1
								show_comments(message_id, 1, 1);
							} else {
								// ...tell fail
								alert("fail");
							}
						});
			}
		});
	}
}

function cmt_prePage(message_id) {
	var target = "#comment_" + message_id;
	pageNum = $(target).find(".pageNum").text();
	if (pageNum == 1)
		return;
	pageNum--;
	if (pageNum < 1) {
		pageNum = 1;
	}
	show_comments(message_id, pageNum, 1);
	$(target).find(".pageNum").text(pageNum);
} // 跳转上一页

function cmt_nextPage(message_id) {
	var target = "#comment_" + message_id;
	pageNum = $(target).find(".pageNum").text();
	pageNum++;
	show_comments(message_id, pageNum, 1);
	$(target).find(".pageNum").text(pageNum);
} // 跳转下一页

$(".icon").live('click', function() {
	var classUsername = $(this).parents("li").find("name");
	var tag_a = classUsername.children("a");
	var targetNickname = tag_a.text();
	window.location = "userinfo.jsp?targetNickname=" + targetNickname; // +
	// "&userToken="
	// +
	// $.query.get("userToken");
})
