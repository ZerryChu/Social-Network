/**
 * @content 判断是否可以进行点赞（一个用户对单条微博只可以点赞一次）
 * @author zerrychu
 * @time 2015.10.23
 */
function judgeIfSupport(message_id, isSupported) {
	if (isSupported == false) {
		// 可点赞
		var message = "#weibo_" + message_id;
		var zan = $(message).find(".zan");
		zan.hide();
		zan.attr("src", "images/2.png");
		zan.fadeIn();
		var val = "support(" + message_id + ", 0);"; // 点赞
		$(message).find(".zan").attr("onclick", val);
	} else {
		// 不可点赞
		var message = "#weibo_" + message_id;
		var zan = $(message).find(".zan");
		zan.hide();
		zan.attr("src", "images/1.png");
		zan.fadeIn(); // 红色的赞
		var val = "support(" + message_id + ", 1);"; // 取消点赞
		$(message).find(".zan").attr("onclick", val);
	}

}

/**
 * 
 * @content 点赞相关操作
 * @param message_id
 * @param flag
 *            1： 取消点赞 0： 点赞
 */
function support(message_id, flag) {
	if (checkSubmit(500)) {
		if (flag == 1) {
			$
					.ajax({
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
								judgeIfSupport(message_id, false);
								var weibo = "#weibo_" + message_id;
								var num = $(weibo).find(".support")
										.find(".num").text();
								$(weibo).find(".support").find(".num").text(
										parseInt(num, 10) - 1); // 点赞数-1
								var like_plus = $(weibo).find(".like_plus");
								// 还原动画效果
								like_plus.css("margin-top", -35);
							} else if (data.msg == 2) {
								// 没点过赞
								alert("never supported before.");
								$(message).find(".zan").attr("onclick", "");
							} else {
								// 异常
								alert("error");
								$(message).find(".zan").attr("onclick", "");
							}
						}
					});
		} // 取消点赞

		else if (flag == 0) {
			$
					.ajax({
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
								judgeIfSupport(message_id, true);
								var weibo = "#weibo_" + message_id;
								var num = $(weibo).find(".support")
										.find(".num").text();

								// ////动画效果
								var like_plus = $(weibo).find(".like_plus");
								like_plus.css("display", "block");
								like_plus.animate({
									marginTop : "-50px"
								}, 500, function() {
									like_plus.css("display", "none");
								});

								$(weibo).find(".support").find(".num").text(
										parseInt(num, 10) + 1); // 点赞数+1
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
}