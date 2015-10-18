<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert User Icon</title>
</head>
<body>
	<div class="user_info">
		<span class="username"></span>
		<span class="nickname"></span>
		<img src="" onerror="javascript:this.src='images/no_user_icon.png'">
	</div>
     <form action="user/insert_icon" enctype="multipart/form-data" method="post">
         上传文件：<input type="file" name="file"><br/>
         <input type="submit" value="提交">
     </form>
    
</body>
    <script type="text/javascript">
    	$(function () {
    		$("#upload_succeed").hide();
            $(":button").click(function () {
                if ($("#file_info").val().length > 0) {
                    ajaxFileUpload();
                }
                else {
                    alert("请选择图片");
                }
            })
        })   
        
        $(document).ready(function() {
			showUserInfo();
			var username = $(".username").value;
			$("img").attr("src", "pic/" + username + ".jpg");
		});
    </script>
</html>