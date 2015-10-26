/**
 * @author zerrychu
 * @time 2015.10.23
 */
function judgeIfSupport(message_id) {
	$.ajax({
		type : "post",
		url : "message/judge_ifsupport",
		data : {
			username : $.query.get("username"),
			message_id : message_id,
			userToken : $.query.get("userToken")
		},
		dataType : "json",
		success : function(data) {
			$.each(data, function() {
				if (data.msg == 1) {
					//可点赞
					//var message = "#weibo_" + message_id;
					//$(message).find(".zan").attr("src", "images/1.png");
					//addSupport($.query.get("username"), message_id);
					var message = "#weibo_" + message_id;
					var val = "support(" + message_id + ", 0);"; // 点赞
					$(message).find(".zan").attr("onclick", val);
				} else {
					//不可点赞
					//alert("不可以点赞");
					var message = "#weibo_" + message_id;
					$(message).find(".zan").attr("src", "images/1.png"); // 红色的赞
					var val = "support(" + message_id + ", 1);"; // 取消点赞
					$(message).find(".zan").attr("onclick", val);
				}
			});
		}
	});
}

function support(message_id, flag) {
	if (flag == 1) {
		$.ajax({
			type : "post",
			url : "message/_support",
			data : {
				username : $.query.get("username"),
				id : message_id,
				userToken : $.query.get("userToken")
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == 1) {
					var message = "#weibo_" + message_id;
					$(message).find(".zan").attr("src", "images/2.png");
					var val = "support(" + message_id + ", 0);";
					$(message).find(".zan").attr("onclick", val);
					var weibo = "#weibo_" + message_id;
					var num = $(weibo).find(".support").find(".num").text();
					$(weibo).find(".support").find(".num").text(Number.parseInt(num) - 1); // 点赞数-1
					// -1
				} else if (data.msg == 2) {
					//没点过赞
					alert("never supported before.");
					$(message).find(".zan").attr("onclick", "");
				} else {
					//异常
					alert("error");
					$(message).find(".zan").attr("onclick", "");
				}
			}
		});
	} // 取消点赞

	else if (flag == 0) {
		$.ajax({
			type : "post",
			url : "message/support",
			data : {
				username : $.query.get("username"),
				id : message_id,
				userToken : $.query.get("userToken")
			},
			dataType : "json",
			success : function(data) {
				if (data.msg == 1) {
					var message = "#weibo_" + message_id;
					$(message).find(".zan").attr("src", "images/1.png");
					var val = "support(" + message_id + ", 1);";
					$(message).find(".zan").attr("onclick", val);
					var weibo = "#weibo_" + message_id;
					var num = $(weibo).find(".support").find(".num").text();
					$(weibo).find(".support").find(".num").text(Number.parseInt(num) + 1); // 点赞数+1
				} else if (data.msg == 2) {
					//已点过赞
					alert("has supported.");
					$(message).find(".zan").attr("onclick", "");
				} else {
					//异常
					alert("error");
					$(message).find(".zan").attr("onclick", "");
				}
			}
		});
	} // 点赞
}