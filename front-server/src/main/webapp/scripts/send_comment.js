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
					var weibo = "#weibo_" + message_id;
					var num = $(weibo).find(".comment").find(".num").text();
					$(weibo).find(".comment").find(".num").text(Number.parseInt(num) + 1); // 评论数+1
					show_comments(message_id, 1);
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}