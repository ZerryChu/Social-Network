/**
 * Created by zhuzirui on 10/12/15.
 */
function show_comments(message_id, pageNum) {
	$
			.ajax({
				type : "post",
				url : "comment/show",
				data : {
					id : message_id,
					page : pageNum
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
															"<div class=\"msgBox\" style=\"width:100%;\"><div class=\"txt\">"
																	+ "<a class=\"comer_name\" href=\"javascript:void(0);\">"
																	+ data.returndata[i].nickname
																	+ "</a>:<span class=\"content\">"
																	+ data.returndata[i].content 
																	+ "</span><div class=\"info\"><span class=\"comment_time\">" 
																	+ data.returndata[i].create_time
																	+ "</span><span class=\"comment_createtime\">"
																	+ data.returndata[i].create_time
																	+ "</span></div></div></div>");
											i++;
										}
										/*$(target)
												.append(
														"<div><form class=\"send_comment\"><textarea style=\"width: 60%; height: 48%;\" name=\"content\"></textarea><input type=\"button\" value=\"发送\" onclick=\"send_comment()\"></form></div>");
										*/
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
// {"returndata":[{"content":"good","create_time":"2015-10-07
// 19:18:50.0","nickname":"zerrychu"},{"content":"very
// good","create_time":"2015-10-08
// 19:19:25.0","nickname":"zerrychu"},{"content":"good good
// good","create_time":"2015-10-01 19:20:01.0","nickname":"lucy"}]}
