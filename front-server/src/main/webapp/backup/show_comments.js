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
																	+ "</a>:<span class=\"content\">"
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
								showComments(1);
							} else {
								//...tell fail
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
