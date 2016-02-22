<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>私信列表</title>
<style type="text/css">
.mainPanel {
	overflow-y: auto;
	margin: 0px auto;
	margin-top: 50px;
	width: 600px;
	height: 800px;
	border: 1px gray solid;
	background-color: white;
}

.topInfo {
	border: 1px gray solid;
	border-bottom: 5px gray solid;
	height: 100px;
}

.name {
	float: left;
	margin-top: 40px;
	margin-left: 10px;
	font-size: 30px;
	font-weight: bold;
}

#all, #not_read {
	float: right;
	margin: 20px;
	margin-top: 60px;
}

.list {
	border: 1px gray solid;
}

.info {
	height: 130px;
	width: 590px;
}

.user_list li {
	list-style-type: none;
	margin: 5px;
	float: left;
	width: 590px;
	height: 140px;
}

.nickname, timeago, img {
	float: left;
	display: inline-block;
}

.nickname {
	font-size: 15px;
	font-weight: bold;
	margin-top: 50px;
}

timeago {
	margin-top: 80px;
	margin-left: -70px;
}

.msg_num {
	float: right;
	margin-top: 80px;
	margin-right: 30px;
	display: inline-block;
}

#all, #not_read {
	cursor: pointer;
}

.info {
	cursor: pointer;
}

.msg_num .num {
	font-weight: bold;
}

#not_read .num {
	font-weight: bold;
}

time {
	float: left;
    margin-left: -30px;
    margin-top: 80px;
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
			<li><a class="link" id="topic_link" href="">话题</a></li>
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
		<div class="topInfo">
			<span class="name">${param.username}的私信</span> <span id="not_read">未读(<span
				style="color: red;" class="num">0</span>)
			</span><span id="all">全部</span>
		</div>
		<ul class="user_list">
			<!--
			<li>
				<div class="info">
					<img style="margin: 15px; width: 100px; height: 100px;" src=""
						onerror="this.src='images/no_found.png'">
					<div class="nickname">zhangxinxin</div>
					<timeago>3 days ago</timeago>
					<div class="msg_num">
						<span class="num">0</span>个对话
					</div>
				</div>
			</li>
			-->
		</ul>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showMsgInfoList();
	});
	
	function showMsgInfoList() {
		$
		.ajax({
			type : "post",
			// async : false,
			url : "privateMsg/getInfo",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken")
			},
			dataType : "json",
			success : function(data) {
				$(".user_list").empty();
				var i = 0;
				var num = 0;
				var index = 0;
				while (data.returndata[i] != undefined) {
					var str = "";
					str += "<a href=\"privateMsg.jsp?username="
					+ $.query.get("username")
					+ "&userToken="
					+ $.query.get("userToken")
					+ "&targetUsername="
					+ data.returndata[i].targetUsername
					+ "&targetNickname="
					+ data.returndata[i].targetNickname
					+ "\">"
					+ "<li id=\""
				    + index
					+ "\" class=\"info\"><div><img style=\"margin: 15px; width: 100px; height: 100px;\" src=\"pic/"
					+ data.returndata[i].targetUsername
					+ ".jpg\" onerror=\"this.src='images/no_found.png'\">"
					+ "<div class=\"nickname\">"
					+ data.returndata[i].targetNickname
					+ "</div><time class=\"timeago\"></time><div class=\"msg_num\"><span class=\"num\">"
					+ data.returndata[i].count
					+ "</span>个对话</div></div></li></a>";
					$(".user_list").append(str);
					$(".timeago")
					.attr(
							"datetime",
							data.returndata[i].time);
					if (data.returndata[i].has_noRead == true) {
						$(".info").css("background-color", "#e9e8ea");
						num++;
					}
					i++;
					index++;
				}
				$(".timeago").timeago();
				$("#not_read .num").text(num);
			},
			error : function() {
				alert("error");
			}
		});
	}
	
	$("#all, #not_read").mouseover(function() {
		$(this).css("color", "#eb7350");
	});

	$("#all, #not_read").mouseout(function() {
		$(this).css("color", "black");
	});
	
	$(".info").live('mouseover', function() {
		if ($(this).css("background-color") == "rgb(233, 232, 234)")
			$(this).css("background-color", "silver");
		else {
			$(this).css("background-color", "#e9e8ea");
		}
	});

	$(".info").live('mouseout', function() {
		if ($(this).css("background-color") == "rgb(192, 192, 192)")
			$(this).css("background-color", "#e9e8ea");
		else
			$(this).css("background-color", "white");
	});
	
	//优化
	$("#not_read").click(function() {
		var num = parseInt($("#not_read .num").text(), 10);
		for (var i = num;i < $(".info").length; i++) {
			$("#" + i).slideUp();
		}
	});
	
	$("#all").click(function() {
		var num = parseInt($("#not_read .num").text(), 10);
		for (var i = num;i < $(".info").length; i++) {
			$("#" + i).slideDown();
		}	
	});
	
	$("#topic_link").click(function() {
		var str = "topic.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&nickname=";
		str += $("#nickname").text();
		window.location = str;
	});
</script>
</html>