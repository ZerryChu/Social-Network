<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>私信</title>
<style type="text/css">
.mainPanel {
	margin: 0px auto;
	margin-top: 50px;
	width: 600px;
	height: 600px;
	border: 1px gray solid;
	background-color: white;
}

.send_form {
	margin: 10px;
	margin-top: 2px;
}

.send_form textarea {
	height: 55px;
	width: 580px;
}

.user_icon {
	margin: 10px;
	width: 60px;
	height: 60px;
}

.name, .user_icon { 
	float: left;
}

.name {
	margin-top: 5px;
	color: #006a92;
	font-weight: bold;
}

.msg {
	min-height: 60px;
	margin-top: 5px;
}

.msg_list {
	overflow-y: auto;
	border: 1px solid gray;
	background-color: #e4e4e4;
	height: 85%;
}

.send_msg {
	border: 1px solid gray;
	height: 15%;
	background-color: #e4e4e4;
}

.content {
	margin-top: 5%;
	margin-bottom: 5%;
}

.target_msg, .user_msg {
	padding: 5px;
	min-height: 80px;	
	background-color: white;
	width: 450px;	
	box-shadow: 0px 5px 10px gray; 
}

.target_msg {
	margin-left: 82px;
}

.user_msg {
	margin-left: 40px;
}

.topInfo {
	border: 1px gray solid;
	height: 100px;
}

time {
	margin-left: 65%;
}

.msg_emotion {
	float: right;
	/*width: 42px;*/
	height: 20px;
	background: url(face/icon.gif) no-repeat 2px 2px;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 3px;
	cursor: pointer
}

.msg_emotion:hover {
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
	<div class="bg">
		<img style="heigth: 100%; width: 100%;" src="images/index_bg.jpg" />	
	</div>
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
	<div class="mainPanel">
		<div class="msg_list">
		    <%--
			<div class="target_msg">
				<img class="user_icon">
				<div class="name">张星星</div>
				<br>
				<div class="msg">一二三四五六七八九十</div>
			</div>
			<div class="user_msg">
				<img class="user_icon">
				<div class="name">我</div>
				<br>
				<div class="msg">一二三四五六七八九十</div>
			</div>
			<div class="user_msg">
				<img class="user_icon">
				<div class="name">我</div>
				<br>
				<div class="msg">一二三四五六七八九十</div>
			</div>
			<div class="target_msg">
				<img class="user_icon">
				<div class="name">张星星</div>
				<br>
				<div class="msg">一二三四五六七八九十</div>
			</div>
			<div class="user_msg">
				<img class="user_icon">
				<div class="name">我</div>
				<br>
				<div class="msg">一二三四五六七八九十</div>
			</div>
			--%>
		</div>
		<div class="send_msg">
			<form class="send_form" method="post">
				<textarea id="content" name="content"></textarea>
				<br> <input type="hidden" name="username"
					value="${param.username}"> <input type="hidden"
					name="userToken" value="${param.userToken}"><input
					style="float: right;" class="send_button" type="button" value="发送" onclick="sendMsg()">
				<span id="msg_emotion" class="msg_emotion"></span>
			</form>
		</div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script>
	$(document).ready(function() {
		//未读消息变已读
		readMsg();
		showMsg(1);
		setInterval('showMsg(0)', 5000);
	});
	
	function sendMsg() {
		$
		.ajax({
			type : "post",
			// async : false,
			url : "privateMsg/addMsg",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				targetUsername : $.query.get("targetUsername"),
				content : $("#content").val()
			},
			dataType : "json",
			success : function(data) {
				if(data.returnmsg == 1) {
					$("#content").val("");
					showMsg(1);
				} else {
					$("#content").val("");
					// add content...
				}
			}
		});
	}
	
	function readMsg() {
		$
		.ajax({
			type : "post",
			// async : false,
			url : "privateMsg/readMsg",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				targetUsername : $.query.get("targetUsername")
			},
			dataType : "json",
			success : function(data) {

			},
			error : function() {
				alert("read msg fail.");
			}
		});
	}
	
	function showMsg(flag) {
		$
		.ajax({
			type : "post",
			// async : false,
			url : "privateMsg/getMsg",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				targetUsername : $.query.get("targetUsername")
			},
			dataType : "json",
			success : function(data) {
				$(".msg_list").empty();
				var i = 0;
				while (data.returndata[i] != undefined) {
					var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
					var str = "";
					if (data.returndata[i].is_target == false) {
						str += "<div class=\"content\"><img style=\"float: left; width: 7%; height: 7%;\" src=\"images/left.png\"><div class=\"user_msg\"><img class=\"user_icon\" src=\"pic/" + $.query.get("username") + ".jpg\">";
						str += "<div class=\"name\">我</div><br><div class=\"msg\">";
						str += return_content;
						str += "</div><time class=\"timeago\" datetime=\"";
						str += data.returndata[i].time;
						str += "\"></time></div></div>";
					} else {
						str += "<div class=\"content\"><img style=\"float: right; width: 7%; height: 7%;\" src=\"images/right.png\"><div class=\"target_msg\"><img class=\"user_icon\" src=\"pic/" + $.query.get("targetUsername") + ".jpg\">";
						str += "<div class=\"name\">";
						str += $.query.get("targetNickname");
						str += "</div><br><div class=\"msg\">";
						str += return_content;
						str += "</div><time class=\"timeago\" datetime=\"";
						str += data.returndata[i].time;
						str += "\"></time></div></div>";
					}
					$(".msg_list").append(str);
					i++;
				}
				$(".timeago").timeago();
				if (flag)
					$(".msg_list").scrollTop(1000000);
			}
		});
	}
	//div.scrollTop = div.scrollHeight;

	/////////////      表情包        /////////////////////////////////////////////////////////////
	$(function() {
		$('#msg_emotion').qqFace({
			assign : '#content', //给输入框赋值 
			path : 'face/' //表情图片存放的路径 
		});

	});
	//////////////////////////////////////////////////////////////////////////////////////////
</script>
</html>