<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>targetinfo</title>
</head>
<body>
	<div class="userinfo">
		<img style="width:100px; height:100px;"src="" onerror="this.src='images/no_found.png'">
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
	<ul id="weibo">
	</ul>
	<div>
		<form class="options">
			<input type="button" id="focus" value="关注" onclick="">
			<input type="button" id="unfocus" value="取消关注" onclick="deleteFriend()">
		</form>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="scripts/showOwnmessages.js" type="text/javascript"></script>
<script src="scripts/showTargetInfo.js" type="text/javascript"></script>
<script src="scripts/show_friends.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
		showTargetInfo(1); //不缓存
	});
	
	function addFriend(_friendUsername, _group) {
		$.ajax({
			type : "post",
			url : "user/addfriend",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				friendUsername : _friendUsername,
				group : _group
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.msg == 1) {
						//...add content
						alert("succeed");
						judgeIfFriend(_friendUsername, 1);
						// 更新数据
						showUserInfo(1, false);
					} else {
						//...tell fail
						alert("fail");
					}
				});
			}
		});
	} //关注
	
	function deleteFriend(_friendUsername) {
		_friendUsername = $(".targetUsername div").text();
		//...
	} //取消关注
</script>
</html>