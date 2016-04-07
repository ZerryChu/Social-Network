/**
 * Created by zhuzirui on 10/11/15.
 */
function showUserInfo(_flag, ifshow) {
	$.ajax({
		type : "post",
		url : "user/getinfo",
		data : {
			username : $.query.get("username"),
			flag : _flag
		},
		dataType : "json",
		success : function(data) {
			if (!ifshow)
				return;
			$.each(data, function() {
				if (data.returndata != null) {
					$("#nickname").text(data.returndata.nickname);
					$(".username").text(data.returndata.username);
					$("#friend_num").text(data.returndata.friend_num);
					$("#focus_num").text(data.returndata.focus_num);
					$("#message_num").text(data.returndata.message_num);
					$("#user_icon").attr(
							"onclick",
							"window.location=\"addicon.jsp?username="
									+ $.query.get("username") + "&userToken="
									+ $.query.get("userToken") + "\"");

				} else {
					$("#nickname").text("null");
					$("#nickname").text("null");
					$("#friend_num").text("0");
					$("#focus_num").text("0");
					$("#message_num").text("0");
					//
				}
			});
		}
	});
}

/**
 * Created by zhuzirui on 10/11/15.
 */
function showTargetInfo(_flag) {
	$.ajax({
		type : "post",
		url : "user/getTargetinfo",
		data : {
			username : $.query.get("username"),
			nickname : $.query.get("targetNickname"),
			flag : _flag
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.returndata != null) {
					$(".targetNickname div")
							.text($.query.get("targetNickname"));
					$(".targetUsername div").text(data.returndata.username);
					$(".friend_num span").text(data.returndata.friend_num);
					$(".message_num span").text(data.returndata.message_num);
					$(".focus_num span").text(data.returndata.focus_num);
					$(".age div").text(data.returndata.age);
					$(".habit div").text(data.returndata.habit);
					$(".topInfo img").attr("src",
							"pic/" + data.returndata.username + ".jpg");
					judgeIfFriend(data.returndata.friend);
					showOwnmessages(1, 1);
				} else {
					$(".targetUsername div")
							.text($.query.get("targetNickname"));
					$(".targetNickname div").text("null");
					$(".friend_num span").text("0");
					$(".message_num span").text("0");
					$(".focus_num span").text("0");
					$(".age div").text("0");
					$(".habit div").text("null");
					//
				}
			});
		}
	});
}

/**
 * @content 判断目标用户是否已被关注
 */
function judgeIfFriend(isFriend) {
	if (isFriend == true) { // 两者是好友关系， 关注按钮失效
		$("#focus").attr("disabled", true);
		$("#unfocus").attr("disabled", false);
	} else { // 两者不是好友关系， 取消关注按钮失效
		$("#focus").attr("disabled", false);
		$("#unfocus").attr("disabled", true);
	}
}

function logout() {
	$.ajax({
		type : "post",
		url : "user/logout",
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken")
		},
		dataType : "json",
		async : false,
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					var forward = "window.location=\"index.jsp\"";
					setTimeout(forward, 500);
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}

$("#friends_count").click(
		function() {
			window.open("friendlist.jsp?username=" + $.query.get("username")
					+ "&userToken=" + $.query.get("userToken") + "&flag=1");
		});

$("#focus_count").click(
		function() {
			window.open("friendlist.jsp?username=" + $.query.get("username")
					+ "&userToken=" + $.query.get("userToken") + "&flag=2");
		});

$(".logout").click(function() {
	logout();
});// 登出

$("#friends_count, #focus_count, #messages_count").mouseover(function() {
	$(this).css("color", "gray");
});

$("#friends_count, #focus_count, #messages_count").mouseout(function() {
	$(this).css("color", "#006a92");
});