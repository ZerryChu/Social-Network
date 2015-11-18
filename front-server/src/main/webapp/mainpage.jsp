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
		<div class="right_content">
			<div id="userinfo">
				<div id="nickname"></div>
				<img id="user_icon" src="pic/${param.username}.jpg"
					onerror="this.src='images/no_found.png'" onclick="" /> <br> <img
					class="logout" src="images/sign-out.png" alt="sign-out"
					style="width: 20px; height: 20px;">
				<ul class="user_account">
					<li class="user_friend_text"><span id="friends_count"
						style="font-weight: bold;">粉丝：</span> <span id="friend_num">0</span></li>
					<li class="user_message_text"><span id="messages_count"
						style="font-weight: bold;">广播：</span> <span id="message_num">0</span></li>
				</ul>
			</div>
			<div id="heated_topic">
				<div class="sub_title" style="padding-left: 20px; font-size: 20px;">热门话题</div>
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
			</div>
			<div id="friend_recommand">
				<div class="sub_title" style="padding-left: 20px; font-size: 20px;">推荐收听</div>
				<ul class="rec_content">
					<li id="rec1"><span class="rec_nickname">nickname</span> <span
						style="color: gray;">原因</span></li>
					<li id="rec2"><span class="rec_nickname">nickname</span> <span
						style="color: gray;">原因</span></li>
				</ul>
			</div>
			<div id="chat">
				<div class="sub_title" style="padding-left: 20px; font-size: 20px;">聊天室</div>
				<ul class="group">
					<!--
					<li id="rec_1"><div class="cls1" onclick="">好友分组1</div><div class="friendlist></div><li>
					<li id="rec_2"><span class="cls2">好友分组2</span></li>
				-->
				</ul>
			</div>
		</div>
		<div class="left_content">

			<div class="post_message">
				<form id="MsgForm" action="message/send?type=1" method="post"
					target="upframe" enctype="multipart/form-data">
					<h2
						style="font-size: 20px; font-weight: bold; color: #999; padding-top: 10px;">说点什么吧~</h2>
					<textarea class="message_content" id="content" name="content"></textarea>
					<br> <span id="msg_emotion" class="msg_emotion"></span> <input
						type="file" class="fileOnLoad" name="pic">
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
			<div class="ad">
				<div id="boxID">
					<!--焦点图盒子-->
					<div class="loading">
						<img src="images/loading.gif" alt="请稍候..." />
					</div>
					<!--载入画面(可删除)-->
					<div class="pic">
						<!--内容列表(li数目可随意增减)-->
						<ul>
							<li><a href=""><img src="images/pic1.jpg" thumb=""
									alt="" text="" /></a></li>
							<li><a href=""><img src="images/pic2.jpg" thumb=""
									alt="" text="" /></a></li>
							<li><a href=""><img src="images/pic3.jpg" thumb=""
									alt="" text="" /></a></li>
							<li><a href=""><img src="images/pic4.jpg" thumb=""
									alt="" text="" /></a></li>
						</ul>
					</div>
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
	<iframe id="upframe" name="upframe" src="" style="display: none;">
	</iframe>

	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/timeago.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="scripts/logout.js" type="text/javascript"></script>
	<script src="scripts/showUserInfo.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/show_comments.js" type="text/javascript"></script>
	<script src="scripts/send_comment.js" type="text/javascript"></script>
	<script src="scripts/send_message.js" type="text/javascript"></script>
	<script src="scripts/repost_message.js" type="text/javascript"></script>
	<script src="scripts/show_friends.js" type="text/javascript"></script>
	<script src="scripts/showOwnmessages.js" type="text/javascript"></script>
	<script src="scripts/show_announcements.js" type="text/javascript"></script>
	<script src="scripts/judgeIfSupport.js" type="text/javascript"></script>
	<script src="scripts/search.js" type="text/javascript"></script>
	<script src="scripts/update.js" type="text/javascript"></script>
	<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
	<script src="scripts/QQFace.js" type="text/javascript"></script>
	<script type="text/javascript" src="plugins/setHomeSetFav.js"></script>
	<script type="text/javascript" src="plugins/myfocus-2.0.1.min.js"
		charset="utf-8"></script>
	<!--引入myFocus库-->
	<script type="text/javascript">
		myFocus.set({
			id : 'boxID',//焦点图盒子ID
			pattern : 'mF_fancy',//风格应用的名称
			time : 3,//切换时间间隔(秒)
			trigger : 'click',//触发切换模式:'click'(点击)/'mouseover'(悬停)
			width : 700,//设置图片区域宽度(像素)
			height : 160,//设置图片区域高度(像素)
			txtHeight : 'default'//文字层高度设置(像素),'default'为默认高度，0为隐藏
		});
	</script>
	<script type="text/javascript">
		//$('.timeago').timeago({selector: 'span.timeago', attr: 'title', dir: 'down', suffix: 'from now'})

		var flag = 1; // 1: 微博跳转 2: 用户自己发得微博的跳转
		var pageNum = 1;

		$(".top_content li").mouseover(function() {
			this.style.background = "snow";
		});

		$(".top_content li").mouseout(function() {
			this.style.background = "";
		});

		$(document).ready(function() {

			/////////////      表情包        /////////////////////////////////////////////////////////////
			$(function() {
				$('#msg_emotion').qqFace({
					assign : '#content', //给输入框赋值 
					path : 'face/' //表情图片存放的路径 
				});

			});
			//////////////////////////////////////////////////////////////////////////////////////////

			$("#MsgForm").submit(function() {
				//$(".message_content").val("")
				//showUserInfo(1, true);
				//var nickname = $("#nickname").text();
				//showOwnmessages(nickname, 1, 1, false);
				var num = $("#message_num").text();
				$("#message_num").text(Number.parseInt(num) + 1); // 广播数+1

			})

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
			show_messages(1, 1);
			showGroups(0);
			setInterval("update()", 30000);
			setTimeout('adjustHeight()', 300);
			setTimeout('adjustHeight()', 5000);
			//$('body').timeago();
		});

		function adjustHeight() {
			$(".right_content").css("height", $(".left_content").height());
		}

		$(".icon").live('click', function() {
			var classUsername = $(this).parents("li").find("name");
			var tag_a = classUsername.children("a");
			var targetNickname = tag_a.text();
			window.location = "userinfo.jsp?targetNickname=" + targetNickname; //+ "&userToken=" + $.query.get("userToken");
		})// 更换头像

		//$("li[id^='weibo_']").live('click', function() {
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

		$("#all_messages").click(function() {
			show_announcements(0);
			flag = 2;
		});// 显示公告

		$("#friends_count").click(
				function() {
					window.open("friendlist.jsp?username="
							+ $.query.get("username") + "&userToken="
							+ $.query.get("userToken"));

				});

		$("#friend_messages").click(function() {
			show_messages(1, 1);
			flag = 1;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			setTimeout('adjustHeight()', 300);
		});// 好友广播

		$(".logout").click(function() {
			logout();
		});// 登出

		$("#messages_count").live('click', function() {
			var nickname = $("#nickname").text();
			showOwnmessages(nickname, 1, 1, true);
			flag = 2;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			setTimeout('adjustHeight()', 300);

		});

		$(".prePage").click(function() {
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
			$(window).scrollTop(0);
			setTimeout('adjustHeight()', 300);
			$(".pageNum").val(pageNum);
		});// 跳转上一页

		$(".nextPage").click(function() {
			pageNum++;
			if (flag == 1)
				show_messages(pageNum, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, pageNum, 0, true);
			}
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
			if (flag == 1)
				show_messages(num, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, num, 0, true);
			}
			$(window).scrollTop(0);
			setTimeout('adjustHeight()', 300);
		} // 跳转指定页面
	</script>
	<!--<jsp:include page="copyright.jsp"></jsp:include>-->
</body>
</html>