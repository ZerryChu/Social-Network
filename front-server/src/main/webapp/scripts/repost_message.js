/**
 * 
 */
function repost_message(_content, message_id) {
	$.ajax({
		type : "post",
		url : "message/repost",
		async : false, //发帖同步执行
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			content : _content,
			id : message_id
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					//...add content
					alert("succeed");
					
					// 数据更新
					showUserInfo(1);
					var nickname = $("#nickname").text();
					showOwnmessages(nickname, 1, 1, false);
					var textarea = ".rptarea_" + message_id;
					$(textarea).val("");
					var weibo = "#weibo_" + message_id;
					var num = $(weibo).find(".repost").find(".num").text();
					$(weibo).find(".repost").find(".num").text(Number.parseInt(num) + 1); // 评论数+1
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}