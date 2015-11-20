<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css">

<title></title>
<style type="text/css">

.targetUsername, .targetNickname, .friend_num, .message_num, form {
	display: inline-block;
}

.targetNickname, .targetUsername {
	margin-left: 20px;
}

.message_num, .friend_num {
	display: inline-block;
	float: right;
	margin-right: 100px;
}

body {
	background-color: #73cff1;
}

.main {
	width: 900px;
	margin: 0px auto;
	margin-top: 27px;
	padding-top: 10px;
}

.topInfo {
	width: 900px;
	margin: 0 auto;
	background: #f8f8f8;
}

.msgBox {
	float: left;
	padding-left: 10px;
	padding-top: 10px;
	width: 580px;
}

.repostInfo {
	background: #e9e8ea none repeat scroll 0 0;
	border: 1px solid #dee3e3;
	cursor: pointer;
	padding: 10px 30px;
	width: 500px;
}

.topInfo img {
	margin-top: 20px;
	margin-left: 20px;
}

.topInfo form {
	margin-left: 20px;
}

.left_content {
	display: inline-block;
	float: left;
	border-left: 0px solid snow;
	border-bottom: 2px solid snow;
	width: 69%;
	background: #fff;
}

.right_content {
	display: inline-block;
	float: right;
	border-right: 0px solid snow;
	border-bottom: 2px solid snow;
	width: 30%;
	background: #fff;
}

#focus, #unfocus {
	width: 70px;
}

.qqFace {
	margin-top: 4px;
}

.qqFace table td {
	padding: 0px;
}

.qqFace table td img {
	cursor: pointer;
	border: 1px #fff solid;
}

.qqFace table td img:hover {
	border: 1px #0066cc solid;
}

.cmt_emotion, .rpt_emotion {
	width: 42px;
	height: 20px;
	background: url(face/icon.gif) no-repeat 2px 2px;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 3px;
	cursor: pointer
}

.cmt_emotion:hover, .rpt_emotion:hover {
	background-position: 2px -28px
}

</style>
</head>
<body>
	<div class="bg"></div>
	<div class="top">
		<ul class="top_content" style="font-weight: bold;">
			<li><a class="link"
				href="main?username=${param.username}&userToken=${param.userToken}">首页</a></li>
			<li>敬请期待</li>
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
		<div class="topInfo">
			<img style="width: 100px; height: 100px;" src=""
				onerror="this.src='images/no_found.png'">
			<div class="targetNickname">
				昵称：
				<div style="color: #006a92; font-weight: bold;"></div>
			</div>
			<br>
			<div class="targetUsername">
				用户名：
				<div style="margin-left: 10px; color: #006a92; font-weight: bold;"></div>
			</div>
			<br> <br>
			<form class="options">
				<!--  暂时不设分组 -->
				<input type="button" id="focus" value="关注"
					onclick="addFriend('normal')"> <input type="button"
					id="unfocus" value="取消关注" onclick="deleteFriend()">
			</form>
			<span class="message_num"> 广播： <span style="color: #006a92; font-weight: bold;"></span>
			</span> <span class="friend_num"> 粉丝： <span style="color: #006a92; font-weight: bold;"></span>
			</span>
		</div>
		<div class="left_content">
			<div class="ownMessage">
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
				</from>
			</div>
		</div>
		<div class="right_content">拓展模块</div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="scripts/showTargetInfo.js" type="text/javascript"></script>
<script src="scripts/show_friends.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script src="scripts/QQFace.js" type="text/javascript"></script>
<script src="scripts/show_comments.js" type="text/javascript"></script>
<script src="scripts/send_comment.js" type="text/javascript"></script>
<script src="scripts/show_messages.js" type="text/javascript"></script>
<script src="scripts/send_message.js" type="text/javascript"></script>
<script src="scripts/repost_message.js" type="text/javascript"></script>
<script src="scripts/judgeIfSupport.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showTargetInfo(1); //重写的js方法
		setTimeout('showOwnmessages(1, 1, true)', 100);
		setTimeout('adjustHeight()', 300);
	});

	/*
	function openFriendList() {
		//$(li).find(".friend_list").slideToggle();
		addFriend($(".targetUsername div").text(), "normal");
	}
	 */

	function addFriend(_group) {
		$.ajax({
			type : "post",
			url : "user/addfriend",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				friendUsername : $(".targetUsername div").text(),
				group : _group
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.msg == 1) {
						//...add content
						judgeIfFriend($(".targetUsername div").text(), 1);
						// 更新数据
					} else {
						//...tell fail
						alert("fail");
					}
				});
			}
		});
	} //关注

	function deleteFriend() {
		$.ajax({
			type : "post",
			url : "user/deletefriend",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				friendUsername : $(".targetUsername div").text(),
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.msg == 1) {
						//...add content
						judgeIfFriend($(".targetUsername div").text(), 1);
						// 更新数据
					} else {
						//...tell fail
						alert("fail");
					}
				});
			}
		});
	} //取消关注

	function showOwnmessages(pageNumber, _flag) {
		$
				.ajax({
					url : 'message/show_ownmessages', // 用于文件上传的服务器端请求地址
					type : 'post',
					data : {
						nickname : $(".targetNickname div").text(),
						page : pageNumber,
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
												var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
												var message = "<li id=\"weibo_"
															+ data.returndata[i].id
															+ "\"><div class=\"weiboinfo\"><div class=\"msgBox\"><div class=\"txt\">";
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
																+ "\" style=\"\"></ul>"
															+ "</div></div></div></li>";
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
														message += "<br><img class=\"msg_pic\" src=\"message/"
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

					}
				});
	}
	
	$(".comment").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		var comtxt = $(this).parents("li").find(".comtxt");
		if (comtxt.css("display") == "none") {
			show_comments(message_id, 1, 1);
			comtxt.slideToggle();
			$(this).parents("li").find(".pageNum").text("1");
		} else {
			comtxt.slideToggle();
		}
	}); // 查看评论

	$(".repost").live('click', function() {
		$(this).parents("li").find(".rpt").slideToggle();
	});

	$(".repost_button").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		var textarea = ".rptarea_" + message_id;
		var content = $(textarea).val();
		repost_message(content, message_id, 1);
		$(textarea).val("");
	}); // 转发微博

	$(".comment_button").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		comarea = ".comarea_" + message_id;
		content = $(comarea).val();
		send_comment(message_id, content);
		$(comarea).val(""); // 清空输入框
	}); //发送评论
	
	$(".top_content li").mouseover(function() {
		this.style.background = "snow";
	});

	$(".top_content li").mouseout(function() {
		this.style.background = "";
	});
	
	function adjustHeight() {
		$(".right_content").css("height", $(".left_content").height());
	}
	
	$(".prePage").click(function() {
		if (pageNum == 1)
			return;
		pageNum--;
		if (pageNum < 1) {
			pageNum = 1;
		}
		showOwnmessages(pageNum, 1, true);
		$(window).scrollTop(0);
		setTimeout('adjustHeight()', 300);
		$(".pageNum").val(pageNum);
	});// 跳转上一页

	var pageNum = 1;
	$(".nextPage").click(function() {
		pageNum++;
		showOwnmessages(pageNum, 1, true);	
		$(window).scrollTop(0);
		setTimeout('adjustHeight()', 300);
		$(".pageNum").val(pageNum);
	});// 跳转下一页

	function goToPage() {
		var num = $(".pageNum").val();
		if (num == "" || isNaN(num)) {
			return;
		}
		pageNum = num;
		showOwnmessages(pageNum, 1, true);	
		$(window).scrollTop(0);
		setTimeout('adjustHeight()', 300);
	} // 跳转指定页面
</script>
</html>