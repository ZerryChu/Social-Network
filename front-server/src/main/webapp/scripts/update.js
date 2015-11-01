/**
 * Created by zhuzirui on 11/1/15.
 * 
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

