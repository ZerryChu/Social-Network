<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

body {
	background-color: #73cff1;
}

.bg {
	width: 100%;
	height: 100%;
	background: url(images/bg1_m.jpg) center top no-repeat;
	position: absolute;
	top: 0px;
	z-index: -1;
}

.main {
	margin: 0px auto;
	margin-top: 27px;
	padding-top: 10px;
	width: 1000px;
}

.options {
	list-style: none;
	font-size: 20px;
}

.options li {
	font-weight: bold;
	color: gray;
	cursor: pointer;
	margin-top: 20px;
	margin-left: 20px;
	margin-right: 20px;
	margin-bottom: 30px;
}

.left_content {
	display: inline-block;
	float: left;
	border-top: 2px solid white;
	border-left: 2px solid white;
	border-bottom: 2px solid white;
	border-right: 1px solid gray;
	width: 20%;
	height: 600px;
	border-radius: 5px 0px 0px 5px;
	background: #f9f9f9;
}

.right_content {
	display: inline-block;
	float: left;
	border-top: 2px solid white;
	border-right: 1px solid white;
	border-bottom: 2px solid white;
	width: 79%;
	height: 600px;
	border-radius: 0px 5px 5px 0px;
	background: white;
}

.friend_info {
	display: inline-block;
	float: left;
	width: 210px;
	height: 80px;
	margin-left: 15px;
	margin-right: 15px;
	margin-top: 5px;
	margin-bottom: 5px;
	border: 1px solid grey;
	background: white;
	cursor: pointer;
}

.title {
	border-bottom: 2px solid grey;
	margin-top: 70px;
	margin-left: 30px;
	margin-right: 30px;
	background: silver;
}

.friend_info div {
	display: inline-block;
}

.friend_name {
	margin: 2px;
	float: left;
}

.count_info {
	margin: 2px;
	float: left;
}

.friend_icon {
	float: left; //
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 10px;
	margin-right: 10px;
}

.search_text {
	margin-left: 500px;
	width: 150px;
	margin-top: 20px;
	height: 19px;
	background: url(images/search.jpg) no-repeat right center;
	background-color: white;
	padding-right: 25px;
}

.prePage, .nextPage {
	cursor: pointer;
	padding-right: 50px;
}

.btn {
	cursor: pointer;
}
</style>

</head>
<body>
	<div class="bg"></div>
	<div class="main">
		<div class="left_content">
			<ul class="options">
				<li onclick="getfavorites(1)">我的收听</li>
				<li onclick="getfollowers(1)">我的听众</li>
			</ul>
		</div>
		<div class="right_content">
			<div class="search" style="float: right;">
				<form>
					<input type="text" class="search_text" /><input class="btn"
						type="button" value="搜索">
				</form>
			</div>
			<div class="title"></div>
			<div style="display: inline-block; float: right;" class="">
				<span style="font-weight: bold;" class="prePage">上一页</span><span
					style="font-weight: bold;" class="nextPage">下一页</span>
			</div>
			<table class="friend_list">

			</table>
		</div>
	</div>
</body>

<!--  一页15好友  -->
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script type="text/javascript">
	var pageNum = 1;
	var flag; // 1 我的听众 2 我的收听 

	function getfavorites(_page) {
		$(".title").text("我的收听");
		flag = 1;
		$
				.ajax({
					type : "post",
					// async : false,
					url : "friend/favorites",
					data : {
						username : $.query.get("username"),
						userToken : $.query.get("userToken"),
						page : _page
					},
					dataType : "json",
					success : function(data) {
						var i = 0;
						if (data.returndata != undefined) {
							var index = 0;
							var message = "";
							while (data.returndata[i] != undefined) {
								if (index == 3) {
									index = 0;
									message += "</tr>";
								}
								index++;
								if (index == 1) {
									message += "<tr>";
								}
								message += "<td><div class=\"friend_info\" onclick=\"goTo('"
									+ data.returndata[i].nickname
									+ "')\"><img src=\"pic/" 
														+ data.returndata[i].username 
														+ ".jpg\" style=\"width:70px; height:70px;\" class=\"friend_icon\"><div class=\"friend_name\">"
										+ data.returndata[i].nickname
										+ "</div><div class=\"count_info\">粉丝：<span class=\"num\">"
										+ data.returndata[i].friend_num
										+ "</span></div></div></td>";
								i++;
							}
							message += "</tr>";
							$(".friend_list").empty();
							$(".friend_list").append(message);
						}
					}
				});
	}

	function getfollowers(_page) {
		$(".title").text("我的听众");
		flag = 2;
		$
				.ajax({
					type : "post",
					// async : false,
					url : "friend/followers",
					data : {
						username : $.query.get("username"),
						userToken : $.query.get("userToken"),
						page : _page
					},
					dataType : "json",
					success : function(data) {
						var i = 0;
						if (data.returndata != undefined) {
							var index = 0;
							var message = "";
							while (data.returndata[i] != undefined) {
								if (index == 3) {
									index = 0;
									message += "</tr>";
								}
								index++;
								if (index == 1) {
									message += "<tr>";
								}
								message += "<td><div class=\"friend_info\" onclick=\"goTo('"
										+ data.returndata[i].nickname
										+ "')\"><img src=\"pic/" 
														+ data.returndata[i].username 
														+ ".jpg\" style=\"width:70px; height:70px;\" class=\"friend_icon\"><div class=\"friend_name\">"
										+ data.returndata[i].nickname
										+ "</div><div class=\"count_info\">粉丝：<span class=\"num\">"
										+ data.returndata[i].friend_num
										+ "</span></div</div></td>";
								i++;
							}
							message += "</tr>";
							$(".friend_list").empty();
							$(".friend_list").append(message);
						}
					}
				});
	}

	$(".prePage").click(function() {
		if (pageNum == 1)
			return;
		pageNum--;
		if (pageNum < 1) {
			pageNum = 1;
		}
		if (flag == 1)
			getfavorites(pageNum);
		else {
			getfollowers(pageNum);
		}

	});// 跳转上一页

	$(".nextPage").click(function() {
		pageNum++;

		if (flag == 1)
			getfavorites(pageNum);
		else {
			getfollowers(pageNum);
		}
	}); // 跳转下一页
	
	function goTo(targetNickname) {
		window.location = "userinfo.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&targetNickname=" + targetNickname; 

	}
</script>
</html>
