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
		<img src="pic/${param.username}.jpg" onerror="this.src='images/no_found.png'">
		<div class="username"></div>
		<div class="nickname"></div>
		<div class="messgae_num"></div>
		<div class="friend_num"></div>
	</div>
	<div class="user_message">
	</div>
	<div class="">
		<form>
			<input type="button" value="添加好友">
		</form>
	</div>
</body>
	<script type="text/javascript">
			$(document).ready(function() {
				var username = $.query.get("username");
				showOwnmessages(username);
				
			}
	</srcipt>
</html>