<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="css/login.css">
</head>
<body>
	<div class="main">
		<div class="bg">
			<img style="heigth: 100%; width: 100%;" src="images/index_bg.jpg" />
		</div>
		<div class="h">
			<img src="" />
		</div>
		<div class="b">
			<div class="b_left"></div>
			<!-- bodyleft -->
			<div class="b_right">
				<div class="wrap_login">
					<div class="logintitle">
						<span>登&nbsp;&nbsp;录</span>
					</div>
					<form id="form">
						<div class="loginbox">
							<div style="display: none" style="" class="login_success">登陆成功，2s后跳转...</div>
							<div class="un">
								<input type="text" name="username" /> <span class="holder">用户名</span>
								<div class="tip"></div>
							</div>
							<!-- username -->
							<div class="pwd">
								<input type="password" name="password" /> <span class="holder">密码</span>
								<div class="tip"></div>
							</div>
							<!-- password -->
							<div class="checknum">
								<input align="left" type="text" class="checknumText"
									name="checknum" style="width: 30%"> <span
									class="holder">验证码</span> <img class="checknumPic"
									src="getChecknum" alt="checknum"
									onClick="this.src='getChecknum?' + Math.random()" />
								<div class="patch"></div>
								<div class="tip"></div>
							</div>
							<!-- 验证码 -->
							<div class="sub">
								<input type="button" value="登 录" id="login" />
								<div class="auto">
									<a href="javascript:void(0);" id="checkbtn"></a><label>下次自动登录</label>
								</div>
							</div>
						</div>
					</form>
					<div class="loginfooter">
						<ul>
							<li><a href="javascript:void(0);" class="register">立即注册</a></li>
							<li><a href="javascript:void(0);">忘记密码？</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- bodyright -->
		</div>
		<div class="f"></div>
	</div>
	<div class="reg_wraper" style="display: none;">
		<div class="reg_bg"></div>
		<div class="registerbox">
			<div class="logintitle">
				<span>注&nbsp;&nbsp;册</span>
				<div id="close"></div>
			</div>
			<div style="display: none" class="reg_success">注册成功！1s后回退</div>
			<form id="form_reg" autocomplete="off">
				<div class="reg_un">
					<input type="text" name="reg_name" id="reg_name" /> <span
						class="holder">用户名</span>
					<div class="tip"></div>
					<div class="_tip" style="display: none;">用户名已存在</div>									
				</div>
				<div class="reg_pwd">
					<input type="password" name="reg_pwd" id="reg_pwd"
						onblur="pwStrength(this.value)" onKeyUp="pwStrength(this.value)" />
					<span class="holder">密码</span>
					<div class="tip"></div>
				</div>
				<div align="center">
					<table width="250px" style="margin-top: -20px;">
						<tr bgcolor="#f5f5f5">
							<td bgcolor="#fff" width="25%"><font style="font-size: 10px;">密码强度</font></td>
							<td width="25%" id="strength_L">&nbsp;</td>
							<td width="25%" id="strength_M">&nbsp;</td>
							<td width="25%" id="strength_H">&nbsp;</td>
						</tr>
					</table>
				</div>
				<div class="reg_c_pwd">
					<input type="password" name="confir_reg_pwd" /> <span
						class="holder">确认密码</span>
					<div class="tip"></div>
				</div>
				<div class="reg_ni">
					<input type="text" name="reg_nickname" id="reg_nickname" /> <span
						class="holder">昵称</span>
					<div class="tip"></div>
				</div>
				<div class="reg_c_email">
					<input type="email" name="confir_reg_email"/> <span
						class="holder" style="display: block;">邮箱</span>
					<div class="tip"></div>
				</div>
				<div class="reg_btn">
					<input type="button" value="注&nbsp;&nbsp;&nbsp;册" id="reg_btn" />
				</div>
			</form>
		</div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.cookie.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.validate-1.13.1.js" type="text/javascript"></script>
<script src="scripts/login.js" type="text/javascript"></script>
<script src="scripts/reg.js" type="text/javascript"></script>
<script type="text/javascript">
	
	$(".reg_wraper").keypress(function(e) { 
	    // 回车键事件 
	       if(e.which == 13) { 
	  			 jQuery("#reg_btn").click(); 
	       } 
	}); 
	
	$(".loginbox").keypress(function(e) { 
	    // 回车键事件 
	       if(e.which == 13) { 
	  			 jQuery("#login").click(); 
	       } 
	});
	
	$(document).ready(function() {
		var username = $.cookie('username');
		var password = $.cookie('password');
		if (username != undefined && password != undefined) {
			$(".un input").val(username);
			$(".pwd input").val(password);
			userlogin(0);
		}

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
		
		$("#close").click(function(){
			$(this).parents(".reg_wraper").hide();
		});
		
		$("#reg_btn").hover(function(){
			$(this).css("background-color","#8adf23");
		},function(){
			$(this).css("background-color","#7ec92c");
		});
		
		$(".reg_btn").click(function() {
			if ($("#form_reg").valid()) {
				var username = $(".reg_un input").val();
				var password = $(".reg_pwd input").val();
				var nickname = $(".reg_ni input").val();
				reg(username, password, nickname);
			}
		});
		$(".register").click(function() {
			$(".reg_success").slideUp();
			$("._tip").hide();
			$(".reg_wraper").show();
		});
		
		$(".checknum input").focus(function(){
//			$(".checknum div:last").addClass("patchonfoc");
			$(".patch").addClass("patchonfoc");
		}).blur(function(){
//			$(".checknum div:last").removeClass("patchonfoc");	
			$(".patch").removeClass("patchonfoc");
		});
		
		//复选框效果实现
		$("#login").click(function(){
			if($("#form").valid()){
				userlogin(1);
			}
		});
		
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
//				error.appendTo("#sss")
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
					rangelength:[4,10]
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

	////////////////////////////////////////////////////
	//密码强度验证
	//判断输入密码的类型
	function CharMode(iN) {
		if (iN >= 48 && iN <= 57) //数字
			return 1;
		if (iN >= 65 && iN <= 90) //大写
			return 2;
		if (iN >= 97 && iN <= 122) //小写
			return 4;
		else
			return 8;
	}
	//bitTotal函数
	//计算密码模式
	function bitTotal(num) {
		modes = 0;
		for (i = 0; i < 4; i++) {
			if (num & 1)
				modes++;
			num >>>= 1;
		}
		return modes;
	}
	//返回强度级别
	function checkStrong(sPW) {
		if (sPW.length <= 4)
			return 0; //密码太短
		Modes = 0;
		for (i = 0; i < sPW.length; i++) {
			//密码模式  
			Modes |= CharMode(sPW.charCodeAt(i));
		}
		return bitTotal(Modes);
	}

	//显示颜色
	function pwStrength(pwd) {
		O_color = "#eeeeee";
		L_color = "#FF0000";
		M_color = "#FF9900";
		H_color = "#33CC00";
		if (pwd == null || pwd == '') {
			Lcolor = Mcolor = Hcolor = O_color;
		} else {
			S_level = checkStrong(pwd);
			if (pwd.length >= 6 && S_level < 3) // 强度3以下的串长度超过6则强度上升一级
				S_level++;
			switch (S_level) {
			case 0:
				Lcolor = Mcolor = Hcolor = O_color;
			case 1:
				Lcolor = L_color;
				Mcolor = Hcolor = O_color;
				break;
			case 2:
				Lcolor = Mcolor = M_color;
				Hcolor = O_color;
				break;
			default:
				Lcolor = Mcolor = Hcolor = H_color;
			}
		}
		document.getElementById("strength_L").style.background = Lcolor;
		document.getElementById("strength_M").style.background = Mcolor;
		document.getElementById("strength_H").style.background = Hcolor;
		return;
	}
	////////////////////////////////////////////////////
</script>
</html>
