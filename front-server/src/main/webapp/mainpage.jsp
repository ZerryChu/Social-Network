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

/*ad*/
#box_ad {
	position: relative;
	width: 650px;
	height: 172px;
	background: #fff;
	border-radius: 5px;
	border: 8px solid #fff;
	margin: 10px auto;
	cursor: pointer;
}

#box_ad .list {
	position: relative;
	width: 650px;
	height: 170px;
	overflow: hidden;
}

#box_ad .list ul {
	position: absolute;
	top: 0;
	left: 0;
}

#box_ad .list li {
	width: 650px;
	height: 170px;
	overflow: hidden;
}

#box_ad .count {
	position: absolute;
	right: 0;
	bottom: 5px;
}

#box_ad .count li {
	color: #fff;
	float: left;
	width: 20px;
	height: 20px;
	cursor: pointer;
	margin-right: 5px;
	overflow: hidden;
	background: #F90;
	opacity: 0.7;
	filter: alpha(opacity = 70);
	border-radius: 20px;
}

#box_ad .count li.current {
	color: #fff;
	opacity: 1;
	filter: alpha(opacity = 100);
	font-weight: 700;
	background: #f60;
}

#tmp {
	width: 100px;
	height: 100px;
	background: red;
	position: absolute;
}

.right_content {
	width: 100%;
}

.right_wrap {
	display: inline-block;
	width: 24%;
	margin-left: 6px;
}

#topic_link {
	cursor: pointer;
}
</style>
</head>
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
			<li><a class="link" id="topic_link">话题</a></li>
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
		<div class="left_content">
			<div class="post_message">
				<form id="MsgForm" action="message/send?type=1" method="post"
					target="upframe" enctype="multipart/form-data">
					<h2
						style="font-size: 20px; font-weight: bold; color: #999; padding-top: 10px;">说点什么吧~</h2>
					<textarea class="message_content" id="content" name="content"></textarea>
					<br> <span id="msg_emotion" class="msg_emotion"></span><input
						type="file" style="width: 150px;" class="fileOnLoad" name="pic">
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
			</div>
		</div>
	</div>
	<div class="right_wrap">
		<div class="right_content">
			<div id="userinfo">
				<div id="nickname"></div>
				<img id="user_icon" src="pic/${param.username}.jpg"
					onerror="this.src='images/no_found.png'" /> <br>
				<div class="option">
					<img class="logout" src="images/sign-out.png" title="登出"
						alt="sign-out" style="width: 20px; height: 20px;"> <a
						href="privateMsgList.jsp?username=${param.username}&userToken=${param.userToken}"><img
						class="private_msg" src="images/private_message.png" title="私信"
						alt="private_msg" style="width: 20px; height: 20px;"></a>
				</div>
				<table class="user_account" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="user_friend_text" style=""><strong
								id="friend_num" style="display: block; font-weight: bold;">0</strong>
								<span id="friends_count">听众</span></td>
							<td class="user_friend_text" style=""><strong id="focus_num"
								style="display: block; font-weight: bold;">0</strong> <span
								id="focus_count">关注</span></td>
							<td class="user_message_text" style=""><strong
								id="message_num" style="display: block; font-weight: bold;">0</strong>
								<span id="messages_count">广播</span></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div style="top: 331px;" class="right_content">
			<div class="right_info">
				<div id="heated_topic">
					<div class="sub_title"
						style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;"><span id="tpk" class="icon"></span>热门话题</div>
					<div
						style="display: inline-block; float: right; font-size: 12px; color: red;"
						class="heat">阅读</div>
					<div class="heated_subtitle">
						<a class="heated_topic"><div id="topic_1">
								<span class="topic_info">#新一轮雾霾来袭 你还能自强不吸吗#</span><span
									class="val">0</span>
							</div></a> <a class="heated_topic"><div id="topic_2">
								<span class="topic_info">#那些年，让你跌破眼镜的童鞋#</span><span class="val">0<!--  热度 --></span>
							</div></a> <a class="heated_topic"><div id="topic_3">
								<span class="topic_info">#情人节要这样过#</span><span class="val">0<!--  热度 --></span>
							</div></a> <a class="heated_topic"><div id="topic_4">
								<span class="topic_info">#30岁后你会过上什么样的生活#</span><span
									class="val">0<!--  热度 --></span>
							</div></a> <a class="heated_topic"><div id="topic_5">
								<span class="topic_info">#晒晒你家乡的美食 都到碗里来！#</span><span
									class="val">0<!--  热度 --></span>
							</div></a>
					</div>
					<div class="next_one">换一组 ></div>
				</div>
			</div>
		</div>
		<div style="top: 512px;" class="right_content">
			<div id="label_recommand">
				<div class="sub_title"
					style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;"><span id="l_icon" class="icon"></span>发现标签</div>
				<div
					style="display: inline-block; float: right; font-size: 12px; color: red;"
					class="heat">热度</div>
				<div style="left-margin: 100px;" class="rec_content">
					<div class="rec1">
						<span class="rec_nickname"></span> <span class="val"
							style="color: gray;"></span>
					</div>
					<div class="rec2">
						<span class="rec_nickname"></span> <span class="val"
							style="color: gray;"></span>
					</div>
					<div class="rec3">
						<span class="rec_nickname"></span> <span class="val"
							style="color: gray;"></span>
					</div>
					<div class="rec4">
						<span class="rec_nickname"></span> <span class="val"
							style="color: gray;"></span>
					</div>
				</div>
				<div id="label_next" class="next_one">换一组 ></div>
			</div>
		</div>
		<div style="top: 688px;" class="right_content">
			<div id="chat">
				<div class="sub_title"
					style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;"><span id="p_msg" class="icon"></span>发送私信</div>
				<ul class="group">
					<!--
						<li id="rec_1"><div class="cls1" onclick="">好友分组1</div><div class="friendlist></div><li>
						<li id="rec_2"><span class="cls2">好友分组2</span></li>
					-->
				</ul>
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
		showUserInfo(1, true);
		show_messages(1, 1);
		show_label();
		showGroups(0);
		// 检查是否有新微薄
		setInterval("update()", 30000);

		$(".top_content li").mouseover(function() {
			this.style.background = "snow";
		});

		$(".top_content li").mouseout(function() {
			this.style.background = "";
		});

		$("#all_messages").click(function() {
			show_announcements(0);
			flag = 3;
		});// 显示公告

		$("#label_next").click(function() {
			show_label();
		});

		$("#messages_count").live('click', function() {
			var nickname = $("#nickname").text();
			showOwnmessages(nickname, 1, 1, true);
			flag = 2;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);
		});

		$("#friend_messages").click(function() {
			show_messages(1, 1);
			flag = 1;
			pageNum = 1;
			$(".pageNum").val(pageNum);
			//setTimeout('adjustHeight()', 300);
		});// 好友广播

		$(".rec_nickname").live(
				'click',
				function() {
					window.location = "label.jsp?username="
							+ $.query.get("username") + "&userToken="
							+ $.query.get("userToken") + "&label="
							+ $(this).parent().attr("id") + "&content="
							+ $(this).text();
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
				showOwnmessages(nickname, pageNum, 1, true);
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
				show_messages(num, 1);
			else {
				var nickname = $("#nickname").text();
				showOwnmessages(nickname, num, 1, true);
			}
			$(window).scrollTop(300);
			//setTimeout('adjustHeight()', 300);
		} // 跳转指定页面

		$(".rec_nickname").mouseover(function() {
			$(this).css("color", "gray");
			$(this).css("font-weight", "bold");
		});

		$(".rec_nickname").mouseout(function() {
			$(this).css("color", "#006a92");
			$(this).css("font-weight", "normal");
		});

		$(".next_one").mouseover(function() {
			$(this).css("color", "#eb7350");
		});

		$(".next_one").mouseout(function() {
			$(this).css("color", "black");
		});

		$(".topic_info").live('mouseover', function() {
			$(this).css("color", "gray");
			$(this).css("font-weight", "bold");
		});

		$(".topic_info").live('mouseout', function() {
			$(this).css("color", "#006a92");
			$(this).css("font-weight", "normal");
		});

		$("#topic_link").click(
				function() {
					var str = "topic.jsp?username=" + $.query.get("username")
							+ "&userToken=" + $.query.get("userToken")
							+ "&nickname=";
					str += $("#nickname").text();
					window.location = str;
				});

		$(".heated_topic").live("click", function() {
			getTopicInfo($(this).find(".topic_info").text());
		});

		function getTopicInfo(name) {
			$.ajax({
				type : "post",
				url : "topic/show_topicByName",
				data : {
					name : name
				},
				dataType : "json",
				success : function(data) {
					$.each(data, function() {
						if (data.returndata.id != undefined) {
							window.location = "topicInfo.jsp?username="
									+ $.query.get("username") + "&userToken="
									+ $.query.get("userToken") + "&nickname="
									+ $.query.get("nickname") + "&id="
									+ data.returndata.id;
						} else {
							//...tell fail
							alert("fail");
						}
					});
				}
			});
		}
		
		$(".comment").live('mouseover', function() {
			$(this).css("color", "#759aad");
		});

		$(".comment").live('mouseout', function() {
			$(this).css("color", "gray");
		});

		$(".comment").live('click', function() {
			var message_id = $(this).parents("li").attr("id");
			message_id = message_id.substr(6);
			var comtxt = $(this).parents("li").find(".comtxt");
			if (comtxt.css("display") == "none") {
				var target = "#comment_" + message_id;
				if ($(target).html() == "") {
					show_comments(message_id, 1, 1);
				}
				comtxt.slideDown();
				$(this).parents("li").find(".pageNum").text("1");
			} else {
				comtxt.slideUp();
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
		}); // 发送评论
	</script>
</body>
</html>