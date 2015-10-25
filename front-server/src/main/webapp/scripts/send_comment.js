/**
 * Created by zhuzirui on 10/12/15.
 */
function send_comment(message_id, comment_content) {
	$.ajax({
		type : "post",
		url : "message/comment",
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			id : message_id,
			content : comment_content,
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					//...add content
					show_comments(message_id);
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}