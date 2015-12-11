<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>主页</title>
<link rel="stylesheet" type="text/css" href="css/main.css">

<style type="text/css">
.msg_emotion, .cmt_emotion, .rpt_emotion {
	width: 42px;
	height: 20px;
	background: url(face/icon.gif) no-repeat 2px 2px;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 3px;
	cursor: pointer
}

.msg_emotion:hover, .cmt_emotion:hover, .rpt_emotion:hover {
	background-position: 2px -28px
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
</style>
</head>
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
					onerror="this.src='images/no_found.png'" /> <br>
				<div class="option">
					<img class="logout" src="images/sign-out.png" title="登出"
						alt="sign-out" style="width: 20px; height: 20px;"> <img
						class="private_msg" src="images/private_message.png" title="私信"
						alt="private_msg" style="width: 20px; height: 20px;">
				</div>
				<ul class="user_account">
					<li class="user_friend_text"><span id="friends_count"
						style="font-weight: bold;">粉丝：</span> <br>
					<span id="friend_num">0</span></li>
					<li class="user_message_text"><span id="messages_count"
						style="font-weight: bold;">广播：</span> <br>
					<span id="message_num">0</span></li>
				</ul>
			</div>
			<div class="right_info">
				<div id="heated_message">
					<div class="sub_title" style="padding-left: 20px; font-size: 20px;">热门微博</div>
					<div class="heated_msg_content">
						<div style="height: 90px;">
							<img
								style="float: left; display: inline-block; width: 70px; height: 70px;"
								src="pic/zhouzhou.jpg">
							<div style="padding-top: 10px; color: #006a92;">周周</div>
							<div style="float: left; height: 70px; display: inline-block;">aaaaaaaaaa</div>
						</div>
					</div>
					<div align="right" class="next_one">换一组</div>
				</div>
				<div id="heated_topic">
					<div class="sub_title" style="padding-left: 20px; font-size: 20px;">热门标签</div>
					<ul class="heated_subtitle">
						<li class="heated_topic" id="topic_1">旅游<span class="val"
							id="val_1">0<!--  热度 --></span></li>
						<li class="heated_topic" id="topic_2">游戏<span class="val"
							id="val_2">0<!--  热度 --></span></li>
						<li class="heated_topic" id="topic_3">美食<span class="val"
							id="val_3">0<!--  热度 --></span></li>
						<li class="heated_topic" id="topic_4">电影<span class="val"
							id="val_4">0<!--  热度 --></span></li>
						<li class="heated_topic" id="topic_5">动漫<span class="val"
							id="val_5">0<!--  热度 --></span></li>
					</ul>
					<div align="right" class="next_one">换一组</div>
				</div>
				<div id="friend_recommand">
					<div class="sub_title" style="padding-left: 20px; font-size: 20px;">推荐收听</div>
					<ul class="rec_content">
						<li id="rec1"><span class="rec_nickname">nickname</span> <span
							style="color: gray;">原因</span></li>
						<li id="rec2"><span class="rec_nickname">nickname</span> <span
							style="color: gray;">原因</span></li>
					</ul>
					<div align="right" class="next_one">换一组</div>
				</div>
				<div id="chat">
					<div class="sub_title" style="padding-left: 20px; font-size: 20px;">发送私信</div>
					<ul class="group">
						<!--
						<li id="rec_1"><div class="cls1" onclick="">好友分组1</div><div class="friendlist></div><li>
						<li id="rec_2"><span class="cls2">好友分组2</span></li>
					-->
					</ul>
				</div>
			</div>
		</div>
		<div class="left_content">

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
			<div id="box_ad">
				<div class="list">
					<ul>
						<li><img src="images/pic1.jpg" width="650" height="170" /></li>
						<li><img src="images/pic2.jpg" width="650" height="170" /></li>
						<li><img src="images/pic3.jpg" width="650" height="170" /></li>
						<li><img src="images/pic4.jpg" width="650" height="170" /></li>
					</ul>
				</div>
			</div>
			<div id="messages">
				<div class="new_msg">您有未接受消息...请点击此处或者刷新页面接收</div>
				<div class="messages_class">
					<ul>
						<li id="friend_messages" class="on" style="font-weight: bold;">广播</li>
						<li id="all_messages" style="font-weight: bold;">公告</li>
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
				</from>
			</div>
		</div>
	</div>
	<a id="gtotop" class="w-top" style="visibility: visible; opacity: 1;"
		hidefocus="true" href="#" title="回到顶部">回到顶部</a>

	<iframe id="upframe" name="upframe" src="" style="display: none;">
	</iframe>

	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/timeago.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="scripts/jquery-bigic.js" type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="scripts/showUserInfo.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/show_friends.js" type="text/javascript"></script>
	<script src="scripts/support.js" type="text/javascript"></script>
	<script src="scripts/search.js" type="text/javascript"></script>
	<script src="scripts/update.js" type="text/javascript"></script>
	<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
	<script src="scripts/ad.js" type="text/javascript"></script>
	<script src="scripts/checkSubmit.js" type="text/javascript"></script>
	<script type="text/javascript">
		var flag = 1; // 1: 微博跳转 2: 用户自己发得微博的跳转 3、公告
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

		//$(document).ready(function() {

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
		$(".right_content").css('height', $(window).height() - 40);
		showUserInfo(1, true);
		show_messages(1, 1);
		showGroups(0);
		setInterval("update()", 30000);
		//setTimeout('adjustHeight()', 300);
		//setTimeout('adjustHeight()', 5000);
		//});
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
		$(document).scroll(function() {
			var content = $(".right_content");
			//if(293 <= $(window).scrollTop()) {
			content.css("margin-top", $(window).scrollTop());
			//}
			//else {
			//	content.css("margin-top", 0);
			//}
		});

		$(".top_content li").mouseover(function() {
			this.style.background = "snow";
		});

		$(".top_content li").mouseout(function() {
			this.style.background = "";
		});

		var height;
		function adjustHeight() {
			if (height == undefined) {
				height = $(".right_content").height();
			}
			if (height <= $(".left_content").height())
				$(".right_content").css("height", $(".left_content").height());
			else
				$(".right_content").css("height", $(window).height());
		}

		$("#all_messages").click(function() {
			show_announcements(0);
			flag = 3;
		});// 显示公告

		$("#messages_count").live('click', function() {
			var nickname = $("#nickname").text();
			showOwnmessages(nickname, 1, 1, true);
			flag = 2;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);

		});

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

		$(".repost_button").live('click', function() {
			var message_id = $(this).parents("li").attr("id");
			message_id = message_id.substr(6);
			var textarea = ".comarea_" + message_id;
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
		
		$(".next_one").mouseover(function() {
			$(this).css("color", "#eb7350");
		});

		$(".next_one").mouseout(function() {
			$(this).css("color", "black");
		});
	</script>
	<!--<jsp:include page="copyright.jsp"></jsp:include>-->
</body>
</html>