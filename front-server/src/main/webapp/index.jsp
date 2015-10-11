
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<style type="text/css">
html {
	overflow: auto
}

html, body {
	width: 100%;
	height: 100%
}

* {
	margin: 0; //
	border: 0;
}

/* WebKit browsers */
::-webkit-input-placeholder {
	color: #777;
}
/* Mozilla Firefox 4 to 18 */
:-moz-placeholder {
	color: #777;
	opacity: 1;
}

/* Mozilla Firefox 19+ */
::-moz-placeholder {
	color: #777;
	opacity: 1;
}
/* Internet Explorer 10+ */
:-ms-input-placeholder {
	color: #777;
}

.login_reg_div {
	background-color: lightblue;
	width: auto;
	height: auto;
	margin-left: 700px;
	padding-top: 200px;
}

.logininfo_form {
	padding-left: 50px;
	padding-top: 50px;
	padding-bottom: 50px;
}

input {
	margin-bottom: 20px;
}

.login_reg_div a {
	margin-left: 200px;
}
</style>
</head>
<body background="">

	<div>
		<div class="login_reg_div">
			<font style="padding-left: 10px; font-size: 40px; color: gray">登陆系统</font>
			<form class="logininfo_form" id="logininfo_form">
				<input type="text" style="height: 40px; width: 200px;"
					placeholder="账号" name="username"> <br> <input
					type="password" style="height: 40px; width: 200px;"
					placeholder="密码" name="password"> <br> <input
					align="center" style="height: 40px; width: 40px;" type="button"
					onclick="login()" value="登录">
			</form>
			<a href="user/reg">注册新用户</a>
		</div>
	</div>
	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
	<script src="scripts/login.js" type="text/javascript"></script>
</body>
</html>