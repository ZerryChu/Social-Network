<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="userinfo">
		<img src="" onerror="this.src='images/no_found.png'">
		<div class="targetUsername">
			用户名：
			<div></div>
		</div>
		<div class="targetNickname">
			昵称：
			<div></div>
		</div>

		<div class="age">
			年龄：
			<div></div>
		</div>
		<div class="habit">
			爱好：
			<div></div>
		</div>
		<div class="message_num">
			广播数：
			<div></div>
		</div>
		<div class="friend_num">
			好友数：
			<div></div>
		</div>

	</div>
	<ul class="target_message">
	</ul>
	<div class="">
		<form>
			<input type="button" value="添加好友">
		</form>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="scripts/login.js" type="text/javascript"></script>
<script src="scripts/showOwnmessages.js" type="text/javascript"></script>
<script src="scripts/showTargetInfo.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showTargetInfo();
		var target = $.query.get("targetNickname");
		showOwnmessages(target);
	});
</script>
</html>