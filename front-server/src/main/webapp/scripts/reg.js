/**
 * 
 */
function reg(un, pwd, ni) {
	$.ajax({
		type : "post",
		url : "user/reg", // 普通登录， 需要验证码
		data : {
			username : un,
			password : pwd,
			nickname : ni
		},
		dataType : "json",
		success : function(data) {
			if (data.msg == "1") {
				$(".reg_success").slideDown();
				$(".reg_un input").val("");
				$(".reg_pwd input").val("");
				$(".reg_c_pwd input").val("");
				$(".reg_ni input").val("");
			} else {
				//
				alert("fail");
			}
		}
	});
}