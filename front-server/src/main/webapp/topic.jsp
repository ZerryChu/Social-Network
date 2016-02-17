<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>topic</title>
</head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
.sort {
	margin-top: 50px;
    margin-left: 70px;
	height: 380px;
	width: 1000px;
}

.info {
	margin-left: 77px;
	height: 400px;
	width: 917px;
	border-radius: 5px 5px 5px 5px;
	background-color: white;
}

.s_info {
	border-radius: 10px 10px 0px 0px;
	width: 170px;
	height: 170px;
	margin: 8px;
	background-color: white;
	float: left;
}

.headline {
	height: 30px;
	border-bottom: 1px solid gray;
}

.s_content {
	
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
	<div class="sort" align="center">
		<div class="s_info" id="s1">
			<div class="headline">活动</div>
			<div class="s_content"
				style="height: 140px; background: url('topic/act.jpg');"></div>
		</div>
		<div class="s_info" id="s2">
			<div class="headline">时尚</div>
			<div class="s_content"
				style="height: 140px; background: url('topic/fashion.jpg');"></div>
		</div>
		<div class="s_info" id="s3">
			<div class="headline">体育</div>
			<div class="s_content"
				style="height: 140px; background: url('topic/pe.jpg');"></div>
		</div>
		<div class="s_info" id="s4">
			<div class="headline">国际</div>
			<div class="s_content"
				style="height: 140px; background: url('topic/glob.jpg');"></div>
		</div>
		<div class="s_info" id="s5">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s6">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s7">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s8">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s9">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s10">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
	</div>
	<div class="info">
		<div class="headline">
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
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script type="text/javascript">
	$(".s_info").mouseover(function() {
		
	});
	
	$(".s_info").mouseout(function() {
		
	});

</script>
</html>