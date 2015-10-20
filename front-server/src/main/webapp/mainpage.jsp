<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>主页</title>
<link rel="stylesheet" type="text/css" href="css/mainpage.css">
</head>
<body>
	<div class="bg"></div>
	<div class="top">
		<ul class="top_content">
			<li>首页</li>
			<li>敬请期待</li>
			<!--  at    好友    私信 -->
			<form action="" method="post">
				<input type="text" class="search_text" /> <select class="search_type"
					name="type">
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
					onerror="this.src='images/no_found.png'" /> <br>
				<ul class="user_account">
					<li id="friends_count" class="text"><span>好友：</span> <span
						id="friend_num">0</span></li>
					<li id="messages_count" class="text"><span>广播：</span> <span
						id="message_num">0</span></li>
				</ul>
			</div>
		</div>
		<div class="left_content">
			<div class="post_message">
				<form>
					<h2>说点什么吧~</h2>
					<textarea class="message_content" name="content"></textarea>
					<br> <select class="type" name="type">
						<option value="2">所有人可见</option>
						<option value="1" selected="selected">好友可见</option>
					</select> <input type="button" value="发送" onclick="send_message();showUserInfo();">
				</form>
			</div>
			<div id="messages">
				<div class="messages_class">
					<ul>
						<li id="friend_messages" class="on">好友广播</li>
						<li id="all_messages">全部广播</li>
						<li>敬请期待</li>
					</ul>
				</div>
				<div class="weibolist">
					<ul id="weibo">
						<!-- <li id="weibo_1">
							<div id="" class="weiboinfo">
								<div class="userPic">
									<a href="javascript:void(0);"><img src="" /></a>
								</div>
								<div class="msgBox">
									<div class="username">
										<a href="javascript:void(0);">username</a>
									</div>
									<div class="txt">内容</div>
									<div class="info">
										<span class="create_time">11年1月1日</span> <span
											class="repost_times"></span> <span class="support_times"></span>
										<a href="javascript:void(0);"><span class="comment">评论</span></a>
										<a href="javascript:void(0);"><span class="repost">转发</span>
										</a>
										<a href="javascript:void(0);"><span class="support">赞</span>
										</a>
									</div>
									<div class="comtxt">
										<textarea class="comarea"></textarea>
										<input type="hidden" value="0" />
										<ul class="otherCom">
										</ul>
									</div>
								</div>
							</div>
						</li> -->
					</ul>
				</div>
			</div>
			<!--  
			<div>
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
		</div>
		-->
		</div>
		<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
		<script src="plugins/jquery-migrate-1.2.1.min.js"
			type="text/javascript"></script>
		<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
		<script src="scripts/login.js" type="text/javascript"></script>
		<script src="scripts/showUserInfo.js" type="text/javascript"></script>
		<script src="scripts/show_messages.js" type="text/javascript"></script>
		<script src="scripts/show_comments.js" type="text/javascript"></script>
		<script src="scripts/send_message.js" type="text/javascript"></script>
		<script src="scripts/show_friends.js" type="text/javascript"></script>
		<script src="scripts/showOwnmessages.js" type="text/javascript"></script>
		<script src="scripts/delete_message.js" type="text/javascript"></script>
		<script src="scripts/search.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {

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

				showUserInfo();
				show_messages();
			});

			//$("li[id^='weibo_']").live('click', function() {
			$(".comment").live('click', function() {
				var message_id = $(this).parents("li").attr("id");
				message_id = message_id.substr(6);
				show_comments(message_id);
				var comments_id = "#comment_" + message_id;
				$(comments_id).slideToggle();
			});
			
			$("#friends_count").click(function() {
				//show_friends();

			});
			
			$("#friend_messages").click(function() {
				show_messages();

			});
			
			$("#messages_count").live('click', function() {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname);
			});
		</script>
</body>
</html>