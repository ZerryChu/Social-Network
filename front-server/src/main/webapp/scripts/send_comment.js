/*
 * Created by zhuzirui on 10/12/15.
 */


/**
 * @content 评论微博
 */
function send_comment(message_id, comment_content) {
	$.ajax({
		type : "post",
		url : "message/comment",
		async : false, //发帖同步执行
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
					$(weibo).find(".comment").find(".num").text(parseInt(num, 10) + 1); // 评论数+1
					show_comments(message_id, 1, 1);
				} else {
					//...tell fail
					alert("fail");
				}
			});
		}
	});
}