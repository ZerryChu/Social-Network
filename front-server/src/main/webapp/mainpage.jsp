<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/mainpage.css" rel="stylesheet" type="text/css" />

<title>欢迎登陆</title>
</head>
<body>

	<jsp:include page="topContent.jsp"></jsp:include>
	<div class="main">
		<div class="right_content">
			<div class="user_info">
				<img width="50%" class="user_icon" src=""
					onerror="javascript:this.src='images/no_user_icon.png'"> <span
					class="nickname">nickname</span> <br>
				<ul class="user_account">
					<li id="friend_num">好友：</li>
					<li id="message_num">广播：</li>
				</ul>
			</div>
			<div class="heated_topic">
				<div class="sub_title">热门话题</div>
				<ul class="topic">
					<li id="topic_1">旅游</li>
					<li id="topic_2">游戏</li>
					<li id="topic_3">美食</li>
					<li id="topic_4">电影</li>
					<li id="topic_5">动漫</li>
				</ul>
			</div>
			<div class="friend_recommand">
				<div class="sub_title">好友推荐</div>
				<ul class="rec_content">
					<li id="rec_1"><span class="rec_nickname">nickname</span> <br>
						<span>原因</span></li>
				</ul>
			</div>
		</div>
		<div class="left_content">
			<div class="post_message">
				<form class="post_message_form">
					说点什么吧~ <br>
					<textarea style="width: 60%; height: 48%;" name="content"></textarea>
					<br> <select name="type">
						<option value="1">所有人可见</option>
						<option value="2">好友可见</option>
					</select> <input type="submit" value="发送">
				</form>
			</div>
			<div id="messages">
				<ul class="messages_class">
					<li>好友广播</li>
					<li>敬请期待</li>
				</ul>
				<br>
				<div class="weibo_info">
					<ul class="weibo">
					
					</ul>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="copyright.jsp"></jsp:include>


	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="scripts/login.js" type="text/javascript"></script>
	<script src="scripts/showUserInfo.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/send_message.js" type="text/javascript"></script>
	<script src="scripts/delete_message.js" type="text/javascript"></script>
	<SCRIPT type="text/javascript">
		$(document).ready(function() {
			showUserInfo();
			show_messages();
		});
	</SCRIPT>

</body>
</html>