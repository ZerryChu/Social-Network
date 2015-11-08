/**
 * Created by zhuzirui on 10/12/15.
 */
function send_messages() {
	$.ajax({
		type : "post",
		url : "message/send",
		async : false, //发帖同步执行
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			content : $(".message_content").val(),
			type : $(".type").val()
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					//...add content
					alert("succeed");
					
					// 更新数据
					$(".message_content").val("")
					showUserInfo(1, true);
					var nickname = $("#nickname").text();
					showOwnmessages(nickname, 1, 1, true);
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}