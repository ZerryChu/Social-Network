/**
 * Created by zhangfurui on 10/11/15.
 */
function userlogin(flag) {
	
	var un = $(".un input").val();
	var pwd = $(".pwd input").val();
	var _checknum = $(".checknum input").val();
	$("#form").valid();
	if(flag == 0) {
		$.ajax({
			type : "post",
			url : "user/login", //cookies 登录， 略过验证码
			data : {
				username : un,
				password : pwd,
				//checknum : _checknum
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					/*
					if(data.msg == -1) {
						$(".checknum_returnmsg").text("验证码错误");
					}
					else */
					if (data.msg != "0") {
						$(".login_success").slideDown();
						//...add content
						var forward = "window.location=\"main?username="
								+ $(".un input").val() + "&userToken=" + data.msg
								+ "\"";
						setTimeout(forward, 2000);
					} else {
						$(".pwd_returnmsg").text("密码错误");
					}
				});
			}
		});
	}
	else {
		$.ajax({
			type : "post",
			url : "user/login1",  // 普通登录， 需要验证码
			data : {
				username : un,
				password : pwd,
				checknum : _checknum
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					
					if(data.msg == "-1") {
						$(".checknum .tip").text("验证码错误");
					}
					else 
					if (data.msg != "0") {
						//...add content
						$(".login_success").slideDown();
						var forward = "window.location=\"main?username="
								+ $(".un input").val() + "&userToken=" + data.msg
								+ "\"";
						setTimeout(forward, 2000);
					} else {
						$(".pwd .tip").text("密码错误");
					}
				});
			}
		});
	}
}


