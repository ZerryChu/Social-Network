<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

body {
	background-color: #73cff1;
}

.bg {
	width: 100%;
	height: 100%;
	background: url(images/bg1_m.jpg) center top no-repeat;
	position: absolute;
	top: 0px;
	z-index: -1;
}

.main {
	margin: 0px auto;
	margin-top: 27px;
	padding-top: 10px;
	width: 1000px;
}

.left_content {
	display: inline-block;
	float: left;
	border-top: 2px solid snow;
	border-left: 1px solid snow;
	border-bottom: 2px solid snow;
	border-right: 2px solid gray;
	width: 20%;
	height: 600px;
	border-radius: 5px 0px 0px 5px;
	background: #f9f9f9;
}

.right_content {
	display: inline-block;
	float: left;
	border-top: 2px solid snow;
	border-right: 1px solid snow;
	border-bottom: 2px solid snow;
	width: 78%;
	height: 600px;
	border-radius: 0px 5px 5px 0px;
	background: white;
}
</style>
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
			<li><a class="link"
				href="topic.jsp?username=${param.username}&userToken=${param.userToken}">话题</a></li>

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
		<div class="left_content"></div>
		<div class="right_content">
			<div class="search" style="float: right;">
				<form>
					<input type="text" class="search_text" /><input class="btn"
						type="button" value="话题搜索">
				</form>
			</div>
		</div>
	</div>

</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script src="scripts/checkSubmit.js" type="text/javascript"></script>
<script type="text/javascript">
	
</script>
</html>