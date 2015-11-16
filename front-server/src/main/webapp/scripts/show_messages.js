/*
 * Created by zhuzirui on 10/12/15.
 */

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
											// ///////////////////////////////////////
											var username;
											var targetNickname = data.returndata[i].author;
											$
													.ajax({
														type : "post",
														url : "user/getTargetinfo",
														data : {
															nickname : targetNickname
														},
														async : false,
														dataType : "json",
														success : function(data) {
															$
																	.each(
																			data,
																			function() {
																				username = data.returndata.username;
																			});
														}
													});
											// ////////////////////////////////////////

											var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
											var message = "<li  class=\"weibo_message\" id=\"weibo_"
													+ data.returndata[i].id
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\""
													+ "userinfo.jsp?username="
													+ $.query.get("username")
													+ "&targetNickname="
													+ data.returndata[i].author
													+ "&userToken="
													+ $.query.get("userToken")
													+ "\"><img src=\""
													+ "pic/"
													+ username
													+ ".jpg"
													+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"weibo_username\"><a href=\""
													+ "userinfo.jsp?targetNickname="
													+ data.returndata[i].author
													+ "&username="
													+ $.query.get("username")
													+ "&userToken="
													+ $.query.get("userToken")
													+ "\">"
													+ data.returndata[i].author
													+ "</a></div>";
							
											if (data.returndata[i].type == 2) { // 属于转发的微博
												var content = return_content;
												var authorWords = content
														.substr(0, content
																.indexOf(';')); // 转发者说的话
												var id = content.substr(content
														.indexOf(';') + 1); // 原微博id
												message += authorWords
														+ "<div class=\"repostInfo\">"
														+ "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)</span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
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
														+ "\" style=\"\"></div>"
														+ "</ul>"
														+ "</div></div></div></li>";
												$("#weibo").append(message);
												show_sourceMessage(id,
														data.returndata[i].id,
														1);
											} else { // 原创微博
												message += return_content;
												if (data.returndata[i].pic != undefined
														&& data.returndata[i].pic != "")
													message += "<img class=\"msg_pic\" src=\"message/"
															+ data.returndata[i].pic
															+ ".jpg\">";
												message += "<div class=\"txt\">";
												message += "</div><div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"repost\">转发(<span class=\"num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)</span></span></div><div class=\"rpt\" style=\"display: none\"><textarea class=\"rptarea_"
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
														+ "</div></div></div></li>";
												$("#weibo").append(message);
											}

											judgeIfSupport(
													data.returndata[i].id, 0);
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
									});
					$(".timeago").timeago();
				}
			});

}

/**
 * @content 显示指定的被转发的微博
 * @param id
 *            原微博id
 * @param _id
 *            转发者id
 * @param _flag
 *            是否缓存
 */
function show_sourceMessage(id, _id, _flag) {
	$
			.ajax({
				type : "post",
				// async : false,
				url : "message/show_message",
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					message_id : id,
					flag : _flag
				},
				dataType : "json",
				success : function(data) {
					if (data.returndata != undefined) {
						var weiboId = "#weibo_" + _id;
						var repostInfo = $(weiboId).find(".repostInfo");
						repostInfo.attr("id", id);
						$(repostInfo)
								.append(
										"<div class=\"weibo_username\"><span style=\"color: #006a92;\">"
												+ data.returndata.author
												+ "</span></div><div class=\"txt\">"
												+ data.returndata.content
												+ "</div>"
												+ "<div class=\"info\"><time class=\"timeago\" datetime=\""
												+ data.returndata.create_time
												+ "\"></time><span class=\"num_info\"><span>评论(<span class=\"comment_num\">"
												+ data.returndata.comment_times
												+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>转发(<span class=\"repost_num\">"
												+ data.returndata.repost_times
												+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>点赞(<span class=\"support_num\">"
												+ data.returndata.support_times
												+ "</span>)</span></span></div>");
						$(".timeago").timeago();
					}
				}
			});
}

$(".repostInfo").live('click', function() {
	 var param = "username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&id=" + $(this).attr("id");
	 window.open("message.jsp?" + param);
});