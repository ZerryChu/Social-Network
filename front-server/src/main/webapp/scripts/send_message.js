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
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
	// 更新数据
	showUserInfo(1);
	var nickname = $("#nickname").text();
	showOwnmessages(nickname, 1, 1);
}