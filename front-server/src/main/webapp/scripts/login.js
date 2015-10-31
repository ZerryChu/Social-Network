/**
 * Created by zhangfurui on 10/11/15.
 */
function userlogin(flag) {
	
	var un = $(".un input").val();
	var pwd = $(".pwd input").val();
	var _checknum = $(".checknum input").val();
	/*
	var flag = 0;
	if (un == undefined || un =="") {
		$(".un_returnmsg").text("请输入账号");
		flag = 1;
	}
	//账号过短
	else if (un.length < 4) {
		$(".un_returnmsg").text("账号过短");
		flag = 1;
	}
	else {
		$(".un_returnmsg").text("");
	}
	if (pwd == undefined || pwd == "") {
		$(".pwd_returnmsg").text("请输入密码");
		flag = 1;
	}
	//密码过短
	else if (pwd.length < 4) {
		$(".pwd_returnmsg").text("密码过短");
		flag = 1;
	}
	else {
		$(".pwd_returnmsg").text("");
	}
	if (_checknum == undefined || _checknum == "") {
		$(".checknum_returnmsg").text("请输入验证码");
		flag = 1;
	}
	//验证码过短
	else if (_checknum.length < 4) {
		$(".checknum_returnmsg").text("验证码过短");
		flag = 1;
	}
	else {
		$(".checknum_returnmsg").text("");
	}
	if(flag == 1) {
		return;
	}
	*/
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
					//...add content
					alert("succeed");
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
						$(".checknum_returnmsg").text("验证码错误");
					}
					else 
					if (data.msg != "0") {
						//...add content
						alert("succeed");
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
}


$(document).ready(function() {
	// body...
	//回车确认
	// $(document).keydown(function(e){
	// });
	
	if($("#username").val() != ""){
	        $("#username").next().hide();
	}
	if($("#pwd").val() != ""){
	        $("#pwd").next().hide();
	}
	
	$(".holder").click(function(){
		$(this).prev().focus();
	});

	$("input").each(function(index){
		var _this = $(this);
		if(index != 3){
			//holder效果兼容实现
			_this.keydown(function(){
				$(this).next().hide(); //输入隐藏
			}).focus(function(){
				$(this).addClass("onfoc");
				if($(this).val() == ""){
					$(this).next().addClass("cc"); //holder变淡
				}
				//flag = true;
			}).blur(function(){
				if($(this).val() == ""){
					$(this).next().removeClass("cc").show();
				}
				$(this).removeClass("onfoc");
			    //flag = false;
			});
		}else{
			//botton经过效果
			_this.hover(function(){
				$(this).addClass("btnhov");
			},function(){
				$(this).removeClass("btnhov");
			});
		}
	});
	$(".checknum input").focus(function(){
		$(".checknum div:last").addClass("patchonfoc");
	}).blur(function(){
		$(".checknum div:last").removeClass("patchonfoc");	
	});
	//复选框效果实现
	$(".auto").click(function(){
		var $check = $("#checkbtn");
		if($check.hasClass("click")){
			$check.removeClass("click");
		}else{
			$check.addClass("click");
		}
	})

	$("#form").validate({
		debug:true,
		rules:{
			username:{
				required:true,
				rangelength:[4,10]
			},
			password:{
				required:true,
				rangelength:[4,10]
			},
			checknum:{
				required:true
			}
		},
		messages:{
			username:{
				required:"请填写用户名",
				rangelength:"用户名长度在4-10之间"
			},
			password:{
				required:"请填写密码",
				rangelength:"密码长度在4-10之间"
			},
			checknum:{
				required:"请填写验证码"
			}
		},
		errorPlacement:function(error, element){
			error.appendTo($(element).nextAll(".tip"));
		}
	});
});

