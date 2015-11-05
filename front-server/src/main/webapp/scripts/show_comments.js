/**
 * Created by zhuzirui on 10/12/15.
 */
function delete_comment(comment_id, _nickname, _message_id) {
	var ret = confirm("确认删除?");
	if (ret == false)
		return;
	$.ajax({
		type : "post",
		url : "comment/delete",
		async : false, //发帖同步执行
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
					alert("succeed.");
					var weibo = "#weibo_" + _message_id;
					var num = $(weibo).find(".comment").find(".num").text();
					$(weibo).find(".comment").find(".num").text(
							Number.parseInt(num) - 1); // 评论数-1
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
											$(target)
													.append(
															"<li><div class=\"msgBox\" style=\"width:100%;\"><div class=\"txt\">"
																	+ "<a href=\"javascript:void(0);\" class=\"comer_name\">"
																	+ data.returndata[i].nickname
																	+ "</a>:<span class=\"content\">"
																	+ data.returndata[i].content
																	+ "</span><div class=\"info\"><img class=\"delete_cmt\" align=\"right\" style=\"width: 10px; height: 10px;\" src=\"images/delete.jpg\" onclick=\"delete_comment("
																	+ data.returndata[i].id
																	+ ", '"
																	+ data.returndata[i].nickname
																	+ "', "
																	+ message_id
																	+ ")\"><time class=\"timeago\" datetime=\""
																	+ data.returndata[i].create_time
																	+ "\"></time></span></div>"
																	+ "</div></div></li>");
											i++;
										}
										$(".timeago").timeago();
									});
				},
				error : function(data) {
					var target = "#comment_" + message_id;
					$(target).empty();
					/*$(target)
							.append(
									"<div><form class=\"send_comment\"><textarea style=\"width: 60%; height: 48%;\" name=\"content\"></textarea><input type=\"button\" value=\"发送\" onclick=\"send_comment()\"></form></div>");
					 */

				}
			});
}

//"<div class=\"getPageNum\" align=\"center\"><span class=\"cmt_prePage\">上一页</span><span class=\"cmt_nextPage\">下一页</span><form style=\"display: inline-block;\">第<input style=\"width: 30px;\" class=\"cmt_pageNum\" type=\"number\">页<input type=\"button\" value=\"跳转\" onclick=\"cmt_goToPage()\"></form></div>"
