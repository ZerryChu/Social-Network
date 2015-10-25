/**
 * Created by zhuzirui on 10/12/15.
 */
function send_message() {
	$.ajax({
		type : "post",
		url : "message/send",
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
	$(".message_content").val("");
	var num = $("#message_num").text(); 
	$("#message_num").text(Number.parseInt(num) + 1); // 广播数+1
}