<%@page import="org.springframework.web.servlet.tags.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Icon</title>
</head>
<body>
	<div class="user_info">
		<img style="width: 100px; height: 100px;" src=""
			onerror="this.src='images/no_found.png'"> <span
			class="username">${param.username}</span>
	</div>
	<form
		action="user/insert_icon?username=${param.username}&userToken=${param.userToken}"
		enctype="multipart/form-data" method="post">
		上传文件：<input type="file" name="file"><br /> <input
			type="submit" value="提交">
	</form>

</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="scripts/inser_usericon.js" type="text/javascript"></script>
<script type="text/javascript">
	<!--
	$(":button").click(function() {
		if ($("#file_info").val().length > 0) {
			ajaxFileUpload();
		} else {
			alert("请选择图片");
		}
	})
	-->

	$(document).ready(function() {
		var username = $(".username").text();
		$("img").attr("src", "pic/" + username + ".jpg");
	});
</script>
</html>