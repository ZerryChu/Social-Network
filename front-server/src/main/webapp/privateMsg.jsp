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

.topInfo {
	border: 1px gray solid;
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
	background : snow;
	height: 130px;
	width: 590px;
}

.user_list li {
	list-style-type: none;
	margin: 5px; 
	float: left;
	width: 600px;
	width : 590px;
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
	<div class="mainPanel">
		<div class="topInfo">
			<span class="name">ZerryChu的私信</span> <span id="not_read">未读(<span
				class="num">0</span>)
			</span><span id="all">全部</span>
		</div>
		<ul class="user_list">
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
		</ul>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script type="text/javascript">
	$("#all, #not_read").mouseover(function() {
		$(this).css("color", "#eb7350");
	});

	$("#all, #not_read").mouseout(function() {
		$(this).css("color", "black");
	});
</script>
</html>