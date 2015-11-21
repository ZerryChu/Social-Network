/*
 * Created by zhuzirui on 10/12/15.
 */


/**
 * @content 发送微博
 * @notice  暂时弃用ajax版本
 */
function _send_messages() {
	//var str = $("#content").val();
	//$("#content").val(replace_em(str)); 将QQ表情解析成img标签写进content
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
					//...是否需要在页面显示反馈信息？
					
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