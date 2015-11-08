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
			<img src="images/bg2.jpg" />
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
							<div class="un">
								<input type="text" name="username"/> <span class="holder">用户名</span>
								<div class="tip"></div>
							</div>
							<!-- username -->
							<div class="pwd">	
								<input type="password" name="password" /> <span
									class="holder">密码</span>
									<div class="tip"></div>
							</div>
							<!-- password -->
							<div class="checknum">							
								<input align="left" type="text" class="checknumText" name="checknum"style="width: 30%">
								<span class="holder">验证码</span>
								<img class="checknumPic" src="getChecknum"
									alt="checknum" onClick="this.src='getChecknum?' + Math.random()" />
								<div class="patch"></div>
								<div class="tip"></div>
							</div>
							<!-- 验证码 -->
							<div class="sub">
								<input type="button" value="登 录" id="login" onclick="userlogin(1)" />
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
	<div class="reg_wraper" style="display:none;">
		<div class="reg_bg">
		</div>
		<div class="registerbox">
			<div class="logintitle">
				<span>注&nbsp;&nbsp;册</span>
				<div id="close"></div>
			</div>
		 	<form id="form_reg" autocomplete="off">
		 		<div class="reg_un">
		 			<input type="text" name="reg_name" id="reg_name"/>
		 			<span class="holder">用户名</span>
					<div class="tip"></div>
		 		</div>		 		
				<div class="reg_pwd">
					<input type="password" name="reg_pwd" id="reg_pwd" />
					<span class="holder">密码</span>
					<div class="tip"></div>
				</div>
				<div class="reg_c_pwd">
					<input type="password" name="confir_reg_pwd"/>
					<span class="holder">确认密码</span>
					<div class="tip"></div>
				</div>
				<div class="reg_btn">
					<button id="reg_btn">注&nbsp;&nbsp;&nbsp;册</button>
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
<script type="text/javascript">
	$(document).ready(
			function() {
				var username = $.cookie('username');
				var password = $.cookie('password');
				if (username != undefined
						&& password != undefined) {
					$(".un input").val(username);
					$(".pwd input").val(password);
					userlogin(0);
				}
			});
</script>
</html>
