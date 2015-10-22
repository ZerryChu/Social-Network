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
					<!-- 					<form id="form"> -->
					<div class="loginbox">
						<div class="un">
							<input type="text" name="username" /> <span class="unholder">用户名</span>
							<span class="tip"></span>
						</div>
						<!-- username -->
						<div class="pwd">
							<input type="password" name="password" /> <span
								class="pwdholder">密码</span> <span class="tip"></span>
						</div>
						<!-- password -->
						<div class="sub">
							<input type="button" value="登 录" id="login" onclick="login()"/>
							<div class="auto">
								<a href="javascript:void(0);" id="checkbtn"></a><label>下次自动登录</label>
							</div>
						</div>
					</div>
					<!-- 					</form> -->
					<div class="loginfooter">
						<ul>
							<li><a href="javascript:void(0);">立即注册</a></li>
							<li><a href="javascript:void(0);">忘记密码？</a></li>
						</ul>
					</div>
				</div>
			</div>
			<!-- bodyright -->
		</div>
		<div class="f"></div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="scripts/login.js" type="text/javascript"></script>
</html>