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
		<div class="targetUsername"></div>
		<div class="targetNickname"></div>
		<div class="messgae_num"></div>
		<div class="friend_num"></div>
	</div>
	<ul class="target_message">
	</ul>
	<div class="">
		<form>
			<input type="button" value="添加好友">
		</form>
	</div>
</body>
	<script src="scripts/showOwnmessages.js" type="text/javascript"></script>
	<script src="scripts/showTargetInfo.js" type="text/javascript"></script>
	<script type="text/javascript">
			$(document).ready(function() {
				showTargetInfo();
				var target = $.query.get("nickname");
				showOwnmessages(nickname);
				var targetUsername = $(".targetUsername").value; 
				$("img").attr("src", "pic/" + targetUsername + ".jpg");
			});
	</script>
</html>