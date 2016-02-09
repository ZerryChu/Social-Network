<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>标签</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<style type="text/css">
.usericon {
	float: left;
}

.username {
	float: left;
	margin-top: 10px;
}

.label_now {
	cursor: pointer;
}

.label_info {
	width: 120px;
	height: 120px;
	background: #dee3e3;
	margin-left: 5px;
	margin-top: 10px;
	cursor: pointer
}

.label_name {
	border-radius: 3px 3px 3px 3px;
	margin-left: 10px;
	background: white;
	width: 50px;
}

.usericon, .master_icon {
	background: silver;
	width: 40px;
	height: 40px;
	margin: 10px;
}

.user_info, .master_info {
	cursor: pointer;
	width: 90%;
	height: 60px;
	background: snow;
	width: 90%;
	border: 1px solid silver;
	margin: 3px;
	margin-left: 5%;
}

.m-menu .w-icn2 {
	clear: both;
	position: absolute;
	right: 15px;
	top: 12px;
	z-index: 2;
	top: 18px;
}
/*
.w-icn2 {
	background: url("images/private_message.png");
	background-position: 0 -830px;
	display: block;
	float: right;
	height: 5%;
	overflow: hidden;
	text-indent: -2000px;
	width: 5%;
	margin-top: 20px;
	margin-right: 5%;
}*/
.rec_nickname, .master_nickname{
	display: block;
	margin-top: 6%;
}

.show_user_info {
	position: absolute;
	z-index: 99999;
	background-color: #444;
	height: 200px;
	width: 300px;
	color: gray;
}

.show_user_subtitle {
	color: white;
	font-weight: bold;
	font-size: 20px;
	margin: 4%;
}

.show_user_usericon {
	float: left;
	padding-top: 2%;
	padding-left: 3%;
	padding-right: 3%;
}

.show_user_nickname {
	float: left;
}

#focus, #unfocus {
	cursor: pointer;
}
</style>
<body>
	<div class="bg">
		<img style="heigth: 100%; width: 100%;" src="images/index_bg.jpg" />
	</div>
	<div class="top">
		<ul class="top_content" style="font-weight: bold;">
			<li><a class="link"
				href="main?username=${param.username}&userToken=${param.userToken}">首页</a></li>
			<li><a class="link"
				href="label.jsp?username=${param.username}&userToken=${param.userToken}">标签</a></li>
			<li><a class="link"
				href="topic.jsp?username=${param.username}&userToken=${param.userToken}">话题</a></li>
			<!--  at    好友    私信 -->
			<form action="" method="post">
				<input type="text" class="search_text" /> <select
					class="search_type" name="type">
					<option value="2">搜微博</option>
					<option value="1" selected="selected">搜昵称</option>
				</select> <input type="button" value="搜索" onclick="search()">
			</form>
		</ul>
	</div>
	<div class="main">
		<div class="right_content">
			<div id="userinfo">
				<div id="nickname"></div>
				<img id="user_icon" src="pic/${param.username}.jpg"
					onerror="this.src='images/no_found.png'" onclick="" /> <br>
				<div class="option">
					<img class="logout" src="images/sign-out.png" title="登出"
						alt="sign-out" style="width: 20px; height: 20px;"> <a
						href="privateMsgList.jsp?username=${param.username}&userToken=${param.userToken}"><img
						class="private_msg" src="images/private_message.png" title="私信"
						alt="private_msg" style="width: 20px; height: 20px;"></a>
				</div>
				<ul class="user_account">
					<li class="user_friend_text"><span id="friends_count"
						style="font-weight: bold;">粉丝：</span> <br> <span
						id="friend_num">0</span></li>
					<li class="user_message_text"><span id="messages_count"
						style="font-weight: bold;">广播：</span> <br> <span
						id="message_num">0</span></li>
				</ul>
			</div>
			<div class="user_recommend">
				<div class="sub_title">推荐用户</div>
				<div class="user_list">
					<div id="u1" class="user_info">
						<img class="usericon"><span class="rec_nickname"></span>
					</div>
					<div id="u2" class="user_info">
						<img class="usericon"><span class="rec_nickname"></span>
					</div>
					<div id="u3" class="user_info">
						<img class="usericon"><span class="rec_nickname"></span>
					</div>

					<!--  <div class="next_one" id="changeRecUsers" align="right">换一组</div>  -->
				</div>
			</div>
			<div class="user_recommend">
				<div class="sub_title">圈内大神</div>
				<div class="master_list">
					<div id="u1" class="master_info">
						<img class="master_icon"><span class="master_nickname"></span>
					</div>
					<div id="u2" class="master_info">
						<img class="master_icon"><span class="master_nickname"></span>
					</div>
					<div id="u3" class="master_info">
						<img class="master_icon"><span class="master_nickname"></span>
					</div>

					<!--  <div class="next_one" id="changeRecUsers" align="right">换一组</div>  -->
				</div>
			</div>
		</div>
		<div class="left_content">
			<div class="search" style="float: right;">
				<form>
					<input type="text" class="search_text" /><input class="btn"
						type="button" value="搜索">
				</form>
			</div>
			<div
				style="background-color: #dee3e3; padding-left: 1%; color: gray;"
				class="label_now"></div>
			<div align="center" class="heated_label">
				<table>
					<!--  <tr align="right">
						<td colspan="5"><div class="next_one" align="right">更多</div></td>
					</tr>-->
					<tr>
						<td><div id="lb0" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb1" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb2" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb3" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb4" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
					</tr>
					<tr>
						<td><div id="lb5" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb6" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb7" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb8" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div id="lb9" class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
					</tr>
					<!--  
					<tr>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">空</div>
								</div>
							</div></td>-->
					</tr>
				</table>
			</div>
			<div class="post_message">
				<form id="MsgForm" action="message/send?type=1" method="post"
					target="upframe" enctype="multipart/form-data">
					<h2
						style="font-size: 20px; font-weight: bold; color: #999; padding-top: 10px;">说点什么吧~</h2>
					<textarea class="message_content" id="content" name="content"></textarea>
					<br> <span id="msg_emotion" class="msg_emotion"></span><input
						type="file" style="width: 150px;" class="fileOnLoad" name="pic">标签<input
						type="text" style="width: 70px;" class="label" name="label">
					<!-- <select
						class="type" name="type">
						<option value="2">暂无</option>
						<option value="1" selected="selected">好友可见</option>
					</select> -->
					<input type="hidden" name="username" value="${param.username}">
					<input type="hidden" name="userToken" value="${param.userToken}"><input
						style="float: right;" type="reset"><input
						style="float: right;" class="send_button" type="submit"
						value="推送广播">
				</form>
			</div>
			<div style="display: none" class="send_success">发送成功，可点击广播查看个人广播...</div>
			<div id="messages">
				<div class="new_msg">您有未接受消息...请点击此处或者刷新页面接收</div>
				<div class="messages_class">
					<ul>
						<li class="new_Msg" class="on" style="font-weight: bold;">最新</li>
						<li class="heated_msg" style="font-weight: bold;">最热</li>
						<li>敬请期待</li>
					</ul>
				</div>
				<div class="weibolist">
					<ul id="weibo">

					</ul>
				</div>
			</div>
			<div class="getPageNum" align="center">
				<span style="font-weight: bold;" class="prePage">上一页</span><span
					style="font-weight: bold;" class="nextPage">下一页</span>
				<form style="display: inline-block;">
					第<input style="width: 30px;" class="pageNum" type="number">页<input
						type="button" class="btn" value="跳转" onclick="goToPage()">
				</form>
			</div>
		</div>
	</div>
	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/timeago.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="scripts/jquery-bigic.js" type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/showUserInfo.js" type="text/javascript"></script>
	<script src="scripts/support.js" type="text/javascript"></script>
	<script src="scripts/search.js" type="text/javascript"></script>
	<script src="scripts/update.js" type="text/javascript"></script>
	<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
	<script src="scripts/checkSubmit.js" type="text/javascript"></script>
	<script type="text/javascript">
		var flag = 1; // 1: 最热 2: 最新 3、。。。
		var pageNum = 1;

		$(document).ready(function() {
			showUserInfo(1, true);
			$(".label_now").hide();
			show_recommendedlabel();
			show_recommendedUsers();
			var label;
			if ((label = $.query.get("label")) != null) {
				id = label;
				if (id == 0)
					return;
				var name = $.query.get("content");
				$(".label_now").empty().append(name + " (点击显示标签菜单)");
				$(".heated_label").slideUp();
				$(".label_now").show();
				show_msgByLabel(label, 1, 1);
			}
		});

		function show_recommendedUsers() {
			/*
					<div id="u1" class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
			 */
			$
					.ajax({
						type : "post",
						// async : false,
						url : "user/show_rec_users",
						data : {
							username : $.query.get("username")
						},
						dataType : "json",
						success : function(data) {
							if (data.returndata != undefined) {
								var num = 1;
								for (var i = 0; i < data.returndata.length; i++)
									if (data.returndata[i] != undefined) {
										var if_friend = false;

										$
												.ajax({
													type : "post",
													url : "friend/iffriends",
													async : false,
													data : {
														username : $.query
																.get("username"),
														targetUsername : data.returndata[i].username,
														flag : 1
													},
													// dataType : "json",
													success : function(data) {
														var i = 0;
														if (data == "1") { // 两者是好友关系
															if_friend = true;
														} else { // 两者不是好友关系
															if_friend = false;
														}
													}
												});

										if (if_friend == true) {
											continue;
										}

										var id = "#u" + num;

										$(id + " .usericon")
												.attr(
														"src",
														"pic/"
																+ data.returndata[i].username
																+ ".jpg");
										$(id + " .rec_nickname").append(
												data.returndata[i].nickname);
										$(id + " .rec_nickname").after("<img class=\"send_msg\" title=\"私信\" style=\"cursor: pointer; width: 5%; height: 20%; float: right; margin-right: 10%; margin-top: -6%;\" src=\"images/private_message.png\">");
										num++;
										if (num == 4) {
											break;
										}
									}
							}
						}
					});

		}

		//flag 1 show_msgByLabel 2 show_msgByLabelAndHeat
		function show_msgByLabel(id, pageNumber, flag) {
			var myUrl = "";
			if (flag == 1) {
				myUrl = "message/show_by_label";
			} else {
				myUrl = "message/show_by_labelAndHeat";
			}
			$
					.ajax({
						type : "post",
						url : myUrl,
						data : {
							username : $.query.get("username"),
							userToken : $.query.get("userToken"),
							label_id : id,
							page : pageNumber
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
																success : function(
																		data) {
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
															+ $.query
																	.get("username")
															+ "&targetNickname="
															+ data.returndata[i].author
															+ "&userToken="
															+ $.query
																	.get("userToken")
															+ "\"><img title=\"查看用户信息\" src=\""
													+ "pic/"
													+ username
													+ ".jpg"
													+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"weibo_username\"><a href=\""
															+ "userinfo.jsp?targetNickname="
															+ data.returndata[i].author
															+ "&username="
															+ $.query
																	.get("username")
															+ "&userToken="
															+ $.query
																	.get("userToken")
															+ "\">"
															+ data.returndata[i].author
															+ "</a></div>";

													if (data.returndata[i].type == 2) { // 属于转发的微博
														var content = return_content;
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
																+ "</div>";
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
														+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div>"
																+ "<ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></div>"
																+ "</ul>"
																+ "</div></div></div></li>";
														$("#weibo").append(
																message);
														show_sourceMessage(
																id,
																data.returndata[i].id,
																1);
													} else { // 原创微博
														message += return_content;
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
														+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div>"
																+ "<ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></ul>"
																+ "</div></div></div></li>";
														$("#weibo").append(
																message);
													}
													judgeIfSupport(
															data.returndata[i].id,
															0);
													// judgeIfSupport.js

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

		// 获取推荐标签
		function show_recommendedlabel() {
			$.ajax({
				type : "post",
				// async : false,
				url : "label/show_rec",
				data : {
					username : $.query.get("username")
				},
				dataType : "json",
				success : function(data) {
					if (data.returndata != undefined) {
						if (data.returndata[0] != null) {
							$("#lb0 .label_name").empty().append(
									data.returndata[0].name);
							$("#lb0").attr(
									"onclick",
									"show_Label(" + data.returndata[0].id
											+ ", 0)");
						}
						if (data.returndata[1] != null) {
							$("#lb1 .label_name").empty().append(
									data.returndata[1].name);
							$("#lb1").attr(
									"onclick",
									"show_Label(" + data.returndata[1].id
											+ ", 1)");
						}
						if (data.returndata[2] != null) {
							$("#lb2 .label_name").empty().append(
									data.returndata[2].name);
							$("#lb2").attr(
									"onclick",
									"show_Label(" + data.returndata[2].id
											+ ", 2)");
						}
						if (data.returndata[3] != null) {
							$("#lb3 .label_name").empty().append(
									data.returndata[3].name);
							$("#lb3").attr(
									"onclick",
									"show_Label(" + data.returndata[3].id
											+ ", 3)");
						}
						if (data.returndata[4] != null) {
							$("#lb4 .label_name").empty().append(
									data.returndata[4].name);
							$("#lb4").attr(
									"onclick",
									"show_Label(" + data.returndata[4].id
											+ ", 4)");
						}
						if (data.returndata[5] != null) {
							$("#lb5 .label_name").empty().append(
									data.returndata[5].name);
							$("#lb5").attr(
									"onclick",
									"show_Label(" + data.returndata[5].id
											+ ", 5)");
						}
						if (data.returndata[6] != null) {
							$("#lb6 .label_name").empty().append(
									data.returndata[6].name);
							$("#lb6").attr(
									"onclick",
									"show_Label(" + data.returndata[6].id
											+ ", 6)");
						}
						if (data.returndata[7] != null) {
							$("#lb7 .label_name").empty().append(
									data.returndata[7].name);
							$("#lb7").attr(
									"onclick",
									"show_Label(" + data.returndata[7].id
											+ ", 7)");
						}
						if (data.returndata[8] != null) {
							$("#lb8 .label_name").empty().append(
									data.returndata[8].name);
							$("#lb8").attr(
									"onclick",
									"show_Label(" + data.returndata[8].id
											+ ", 8)");
						}
						if (data.returndata[9] != null) {
							$("#lb9 .label_name").empty().append(
									data.returndata[9].name);
							$("#lb9").attr(
									"onclick",
									"show_Label(" + data.returndata[9].id
											+ ", 9)");
						}

					}
				}
			});
		}

		var id = 0;
		$(".new_Msg").click(function() {
			if (id == 0)
				return;
			show_msgByLabel(id, 1, 1);
			flag = 1;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);
		});// 好友广播

		$(".heated_msg").click(function() {
			if (id == 0)
				return;
			show_msgByLabel(id, 1, 2);
			flag = 2;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);
		});// 好友广播

		$("#focus").live(
				'click',
				function() {
					$.ajax({
						type : "post",
						url : "user/addfriend",
						data : {
							username : $.query.get("username"),
							userToken : $.query.get("userToken"),
							friendUsername : $(this).parent().next().find(
									".show_user_username").text().substr(4),
							group : "normal"
						},
						dataType : "json",
						success : function(data) {
							$.each(data, function() {
								if (data.msg == 1) { // bug
									$(this).text("取消关注");
									$(this).attr("id", "unfocus");
								} else {
									alert("error");
								}
							});
						}
					});
				})

		$("#unfocus").live('click', function() {

		})

		$(".send_msg").live(
				'click',
				function() {
					var item = "#s" + $(this).parent().attr("id").substr(1);
					var targetUsername = $(item).find(".show_user_username").text().substr(4);
					window.location = "privateMsg.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&targetUsername=" + targetUsername;
					
				});
		/*	$("#changeRecUsers").click(function() {
				show_recommendedUsers();
			});*/
		/*
		var pos = 0;

		$(".show_user_info").live('mouseover', function() {
			pos = 1;
		})
			
		$(".show_user_info").live('mouseout', function() {
			if (pos == 1)
				$(this).fadeOut();
		})
		*/
		$(".user_info")
				.mouseover(
						function() {
							//pos = 0; // pos
							var id = $(this).attr("id").substr(1);
							$(".show_user_info").hide();
							var temp = "#s" + id;
							if ($(temp).length > 0) {
								$(temp).fadeIn();
							} else {
								var left = $(this).offset().left
										- $(this).width() - 35;
								var top = $(this).offset().top + 20;
								var nickname = $(this).find(".rec_nickname")
										.text();
								var username;
								var msg_count;
								var fan_count;
								var pic;
								var if_friend;
								$
										.ajax({
											type : "post",
											async : false,
											url : "user/getinfoByNickname",
											data : {
												nickname : nickname,
												flag : 1
											},
											dataType : "json",
											success : function(data) {
												if (data.returndata != undefined) {
													username = data.returndata.username;
													pic = "pic/" + username
															+ ".jpg";
													msg_count = data.returndata.message_num;
													fan_count = data.returndata.friend_num;
												}
											}
										});
								/*
								$.ajax({
									type : "post",
									url : "friend/iffriends",
									async : false,
									data : {
										username : $.query.get("username"),
										targetUsername : username,
										flag : 1
									},
									// dataType : "json",
									success : function(data) {
										var i = 0;
										if (data == "1") { // 两者是好友关系
											if_friend = true;
										} else { // 两者不是好友关系
											if_friend = false;
										}
									}
								});
								 */
								id = temp.substr(1);
								var str = "<div id=\"" + id + "\" class=\"show_user_info\"><div class=\"show_user_top\"><span class=\"show_user_subtitle\">用户资料</span>";
								str += "<button id=\"focus\" style=\"float: right;margin: 3%;\">添加关注</button>";
								str += "</div><div class=\"show_user_content\"><img class=\"show_user_usericon\" src=\""
										+ pic
										+ "\" style=\"width: 25%; height: 25%;\"><span class=\"show_user_username\">用户名："
										+ username
										+ "</span><span class=\"show_user_nickname\">昵称："
										+ nickname
										+ "</span><div style=\"padding-top: 23%;margin-left: 5%;\"><span class=\"show_user_fans_count\">粉丝数："
										+ fan_count
										+ "</span><span class=\"show_user_msg_count\">&nbsp;&nbsp;&nbsp;广播数："
										+ msg_count
										+ "</span><div>常用标签</div><button style=\"\">爬山</button><button style=\"\">游泳</button><button style=\"\">购物</button></div></div></div>";
								$("body").append(str);
								$(temp).offset(function(n, c) {
									newPos = new Object();
									newPos.left = left;
									newPos.top = top;
									return newPos;
								});
							}
						});

		//$(".user_info").mouseout(function() {
		//if ($("#s1").length > 0)
		//	$("#s1").hide();
		//});

		$("#messages_count").live('click', function() {
			var nickname = $("#nickname").text();
			showOwnmessages(nickname, 1, 1, true);
			flag = 3;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);

		});

		function show_Label(id_chosen, lb_id) {
			id = id_chosen;
			if (id == 0)
				return;
			var name = $("#lb" + lb_id + " .label_name").text();
			$(".label_now").empty().append(name + " (点击显示标签菜单)");
			$(".heated_label").slideUp();
			$(".label_now").show();
			show_msgByLabel(id, 1, 1);
		}

		$(".top").keypress(function(e) {
			// 回车键事件 
			if (e.which == 13) {
				search();
			}
		});

		$("#MsgForm")
				.submit(
						function() {
							var num = $("#message_num").text();
							$("#message_num").text(parseInt(num, 10) + 1); // 广播数+1
							$(".send_success").slideDown();
							setTimeout(
									'$("#MsgForm")[0].reset();$(".send_success").slideUp()',
									3000);

						});

		/////////////      表情包        /////////////////////////////////////////////////////////////
		$(function() {
			$('#msg_emotion').qqFace({
				assign : '#content', //给输入框赋值 
				path : 'face/' //表情图片存放的路径 
			});

		});
		//////////////////////////////////////////////////////////////////////////////////////////

		$(".messages_class li").each(function(index) {
			var $this = $(this);
			$this.hover(function() {
				$(this).addClass("hover");
			}, function() {
				$(this).removeClass("hover");
			});
			$this.click(function() {
				if (!($(this).hasClass("on"))) {
					$(".on").removeClass("on");
					$(this).addClass("on");
				}
			});
		});

		//show mes
		//setInterval("update()", 30000);

		/*
		 $(document).scroll(function(){
		 var content = $(".right_info");
		 if(293 <= $(window).scrollTop()) {
		 content.css("margin-top", $(window).scrollTop() - 270);
		 }
		 else {
		 content.css("margin-top", 0);
		 }
		 });
		 */

		$(".user_info").click(function() {
			var targetNickname = $(this).find(".rec_nickname").text();
			window.location = "userinfo.jsp?username=" + $.query.get("username") + "&targetNickname=" + targetNickname + "&userToken=" + $.query.get("userToken");
		});
		 
		$(".user_info").mouseover(function() {
			$(this).css("color", "blue");
		});

		$(".user_info").mouseout(function() {
			$(this).css("color", "black");
		});

		$(".top_content li").mouseover(function() {
			this.style.background = "snow";
		});

		$(".top_content li").mouseout(function() {
			this.style.background = "";
		});

		$(".label_now").click(function() {
			$(".heated_label").slideDown();
		});

		$(".prePage").click(function() {
			if (pageNum == 1)
				return;
			pageNum--;
			if (pageNum < 1) {
				pageNum = 1;
			}

			if (flag == 1)
				show_msgByLabel(id, pageNum, 1);
			else if (flag == 2) {
				show_msgByLabel(id, pageNum, 2);
			} else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, pageNum, 1, true);//check
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
			$(".pageNum").val(pageNum);
		});// 跳转上一页

		$(".nextPage").click(function() {
			pageNum++;
			if (flag == 1)
				show_msgByLabel(id, pageNum, 1);
			else if (flag == 2) {
				show_msgByLabel(id, pageNum, 2);
			} else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, pageNum, 1, true);
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
			$(".pageNum").val(pageNum);
		});// 跳转下一页

		function goToPage() {
			if (flag == 3)
				return;
			var num = $(".pageNum").val();
			if (num == "" || isNaN(num)) {
				return;
			}
			if (num <= 1) {
				pageNum = 1;
				$(".pageNum").val(pageNum);
			} else
				pageNum = num;
			if (flag == 1)
				show_msgByLabel(id, pageNum, 1);
			else if (flag == 2) {
				show_msgByLabel(id, pageNum, 2);
			} else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, num, 1, true);
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
		} // 跳转指定页面

		$(".next_one").mouseover(function() {
			$(this).css("color", "#eb7350");
		});

		$(".next_one").mouseout(function() {
			$(this).css("color", "black");
		});

		$(".label_info").mouseover(function() {
			$(this).css("background-color", "gray");
			$(this).find(".label_name").css("background-color", "#dee3e3");
		});

		$(".label_info").mouseout(function() {
			$(this).css("background-color", "#dee3e3");
			$(this).find(".label_name").css("background-color", "white");
		});
	</script>
</body>
</html>
