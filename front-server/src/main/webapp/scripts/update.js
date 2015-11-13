/**
 * Created by zhuzirui on 11/1/15.
 * 
 */

/**
 * @content 30s周期轮询，判断是否新的未接收的微博等，具体见api服务器 
 */
function update() {
	$.ajax({
		type : "post",
		url : "update",
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == -1 || data.msg == 0) {
					return;
				} else {
					$(".new_msg").slideDown();
				}
			});
		}
	});
}

