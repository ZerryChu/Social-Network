/**
 * 
 */
function reg(un, pwd, ni) {
	$.ajax({
		type : "post",
		url : "user/reg",
		data : {
			username : un,
			password : pwd,
			nickname : ni
		},
		dataType : "json",
		success : function(data) {
			if (data.msg == 1) { // 登陆成功
				$(".reg_success").slideDown();
				$(".reg_un input").val("");
				$(".reg_pwd input").val("");
				$(".reg_c_pwd input").val("");
				$(".reg_ni input").val("");
				setTimeout('$(".reg_wraper").hide()', 1000);
			} else if(data.msg == 0){
				$("._tip").show(); // 用户已存在
			} else {
				alert("fail");
			}
		}
	});
}