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
						$(".checknum .tip").text("验证码错误");
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
						$(".pwd .tip").text("密码错误");
					}
				});
			}
		});
	}
}



$(document).ready(function(){
	// body...
	//回车确认
	// $(document).keydown(function(e){
	// });
	//针对保存账号密码的bug处理
	//bug！
	$("#a").click(function(){
		$("#form").valid();
	});
	if($("#username").val() != ""){
		$("#username").next().hide();
	}
	if($("#pwd").val() != ""){
		$("#pwd").next().hide();
	}

	$(".holder").click(function(){
		 //if (!flag) {
			$(this).prev().focus();
		 //}
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
	//注册
	$(".register").click(function(){
		$(".reg_wraper").show();
	});
	$("#close").click(function(){
		$(this).parents(".reg_wraper").hide();
	});
	$("#reg_btn").hover(function(){
		$(this).css("background-color","#8adf23");
	},function(){
		$(this).css("background-color","#7ec92c");
	});

	$(".checknum input").focus(function(){
		$(".checknum div:last").addClass("patchonfoc");
	}).blur(function(){
		$(".checknum div:last").removeClass("patchonfoc");	
	});
	//复选框效果实现
//	$("#login").click(function(){
//		if($("#form").valid()){
//			userlogin(1);
//		}
//	});
	$(".auto").click(function(){
		var $check = $("#checkbtn");
		if($check.hasClass("click")){
			$check.removeClass("click");
		}else{
			$check.addClass("click");
		}
	})
	
	$("#form").validate({
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
			// error.appendTo(".tip");
//			error.appendTo("#sss")
		}
	});
	$("#form_reg").validate({
		rules:{
			reg_name:{
				required:true,
				rangelength:[4,10]
			},
			reg_pwd:{
				required:true,
				rangelength:[4,10]
			},
			confir_reg_pwd:{
				required:true,
				equalTo:"#reg_pwd"
			},
			reg_nickname:{
				required:true,
				reangelength:[4,10]
			}
			//不允许符号
		},
		messages:{
			reg_name:{
				required:"请填写用户名",
				rangelength:"用户名长度在4-10之间"
			},
			reg_pwd:{
				required:"请填写密码",
				rangelength:"密码长度在4-10之间"
			},
			confir_reg_pwd:{
				required:"请确认密码",
				equalTo:"两次输入密码不一致"
			},
			reg_nickname:{
				required:"请输入昵称",
				ranglength:"昵称长度在4-10之间"
			}
			
		},
		errorPlacement:function(error, element){
			error.appendTo($(element).nextAll(".tip"));
			// error.appendTo(".tip");
		}
	});

});

