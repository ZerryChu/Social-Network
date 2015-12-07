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
.label_info {
	width: 120px;
	height: 120px;
	background: #dee3e3;
	margin-left: 5px;
	margin-top: 10px;
}

.label_name {
	border-radius: 3px 3px 3px 3px;
	margin-left: 10px;
	background: white;
	width: 50px;
}

.usericon {
	background: silver;
	width: 40px;
	height: 40px;
	margin: 10px;
}

.user_info {
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

.w-icn2 {
	background: rgba(0, 0, 0, 0) url("images/icon2-8.png") no-repeat scroll
		999px 999px;
	background-position: 0 -830px;
	display: block;
	float: right;
	height: 16px;
	overflow: hidden;
	text-indent: -2000px;
	width: 18px;
	margin-top: 20px;
	margin-right: 5%;
}
</style>
<body>
	<div class="bg"></div>
	<div class="top">
		<ul class="top_content" style="font-weight: bold;">
			<li><a class="link"
				href="main?username=${param.username}&userToken=${param.userToken}">首页</a></li>
			<li><a class="link"
				href="label.jsp?username=${param.username}&userToken=${param.userToken}">标签</a></li>
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
					onerror="this.src='images/no_found.png'" onclick="" /> <br> <img
					class="logout" src="images/sign-out.png" alt="sign-out"
					style="width: 20px; height: 20px;">
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
				<div class="sub_title">用户推荐</div>
				<div class="user_list">
					<div class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
					<div class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
					<div class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
					<div class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
					<div class="user_info">
						<img class="usericon"><span class="username">zerry</span><a
							class="w-icn2 itag" style="" href="#">关注</a>
					</div>
					<div align="right">换一组</div>
				</div>
			</div>
		</div>
		<div class="left_content">
			<div align="center" class="heated_label">
				<table>
					<tr align="right">
						<td colspan="5">换一组</td>
					</tr>
					<tr>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
					</tr>
					<tr>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
					</tr>
					<tr>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div></td>
						<td><div class="label_info">
								<div
									style="font-weight: bold; padding-right: 60%; padding-top: 60%;">
									<div align="center" class="label_name">游戏</div>
								</div>
							</div></td>
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
						<li id="friend_messages" class="on" style="font-weight: bold;">最新</li>
						<li id="all_messages" style="font-weight: bold;">最热</li>
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

		showUserInfo(1, true);
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

		$(".top_content li").mouseover(function() {
			this.style.background = "snow";
		});

		$(".top_content li").mouseout(function() {
			this.style.background = "";
		});

		$(".prePage").click(function() {
			if (flag == 3)
				return;
			if (pageNum == 1)
				return;
			pageNum--;
			if (pageNum < 1) {
				pageNum = 1;
			}

			if (flag == 1)
				show_messages(pageNum, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, pageNum, 0, true);
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
			$(".pageNum").val(pageNum);
		});// 跳转上一页

		$(".nextPage").click(function() {
			if (flag == 3)
				return;
			pageNum++;
			if (flag == 1)
				show_messages(pageNum, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, pageNum, 0, true);
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
				show_messages(num, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, num, 0, true);
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
		} // 跳转指定页面
	</script>
</body>
</html>
