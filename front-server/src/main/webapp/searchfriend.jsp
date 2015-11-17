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
	padding: 0px 20px;
	font-size: 20px;
}

.options li {
	cursor: pointer;
	margin-top: 20px;
	margin-left: 20px;
	margin-right: 20px;
	margin-bottom: 30px;
}

.left_content {
	display: inline-block;
	float: left;
	border-top: 2px solid #786F66;
	border-left: 4px solid #786F66;
	border-bottom: 2px solid #786F66;
	border-right: 2px solid gray;
	width: 20%;
	height: 600px;
	border-radius: 5px 0px 0px 5px;
	background: snow;
}

.right_content {
	display: inline-block;
	float: left;
	border-top: 2px solid #786F66;
	border-right: 4px solid #786F66;
	border-bottom: 2px solid #786F66;
	width: 79%;
	height: 600px;
	border-radius: 0px 5px 5px 0px;
	background: snow;
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

#weibo {
	margin-left: 50px;
}

.title {
	border-bottom: 2px solid grey;
	margin-top: 50px;
	margin-left: 40px;
	margin-right: 40px;
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

#weibo li {
	margin: 20px 65px;
	background: white;
}

.weiboinfo {
	margin: 5px 10px;
	cursor: pointer;
}
</style>

</head>
<body>
	<div class="bg"></div>
	<div class="top">
		<ul class="top_content" style="font-weight: bold;">
			<li><a href="main?username=${param.username}&userToken=${param.userToken}">首页</a></li>
			<li>敬请期待</li>
			<!--  at    好友    私信 -->
			<form action="" method="post">
				<input type="text" class="search_text" /> <select
					class="search_type" name="type">
					<option value="2">搜微博</option>
					<option value="1" selected="selected">搜昵称</option>
				</select> <input type="button" value="搜索" onclick="search()">
			</form>
		</ul>
	</div>
	<div class="main">
		<div class="left_content">
			<div class="history">
				<div class="title">查询历史</div>
			</div>
		</div>
		<div class="right_content">
			<div class="title">搜索结果</div>
			<div style="display: inline-block; float: right;" class="">
				<span style="font-weight: bold;" class="prePage">上一页</span><span
					style="font-weight: bold;" class="nextPage">下一页</span>
			</div>
			<div class="search_result"></div>
		</div>
	</div>
</body>
<!--  一页15好友  -->
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script type="text/javascript">
	var pageNum = 1;
	var flag; // 1 搜人 2 搜微博
	var content;
	$(document).ready(function() {
		content = $.query.get("content");
		if ($.query.get("type") == 1) {
			searchUsers(content, 1);
		} else {
			if ($.query.get("type") == 2) {
				searchMessages(content, 1);
			}
		}

	});

	function search() {
		content = $(".search_text").val();
		var type = $(".search_type").val();
		if (type == 1) {
			searchUsers(content, 1);
		} else {
			searchMessages(content, 1);
		}
	}

	function searchMessages(_content, _page) {
		flag = 2;
		$
				.ajax({
					type : "post",
					// async : false,
					url : "search/messages",
					data : {
						content : _content,
						page : _page
					},
					dataType : "json",
					success : function(data) {
						if (data.returndata != undefined) {
							$(".search_result").empty();
							var message = "<ul id=\"weibo\">";
							var i = 0;
							while (data.returndata[i] != undefined) {
								// ///////////////////////////////////////
								var username;
								var targetNickname = data.returndata[i].author;
								$
										.ajax({
											type : "post",
											url : "user/getTargetinfo",
											data : {
												nickname : targetNickname
											},
											async : false,
											dataType : "json",
											success : function(data) {
												$
														.each(
																data,
																function() {
																	username = data.returndata.username;
																});
											}
										});
								// ////////////////////////////////////////
								var weiboId = "weibo_" + data.returndata[i].id;
								message += "<li id=\"" + weiboId + "\"><div class=\"weiboinfo\" id=\"" 
										+ data.returndata[i].id 
										+ "\">";
								message += "<div class=\"weibo_username\"><span style=\"color: #006a92;\">"
										+ data.returndata[i].author
										+ "</span><img style=\"width:50px; height: 50px;\" src=\""
									+ "pic/"
									+ username
									+ ".jpg"
									+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></div><div class=\"txt\">"
										+ data.returndata[i].content
										+ "</div>"
										+ "<div class=\"info\"><time class=\"timeago\" datetime=\""
											+ data.returndata[i].create_time
											+ "\"></time><span class=\"num_info\"><span>评论(<span class=\"comment_num\">"
										+ data.returndata[i].comment_times
										+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>转发(<span class=\"repost_num\">"
										+ data.returndata[i].repost_times
										+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span>点赞(<span class=\"support_num\">"
										+ data.returndata[i].support_times
										+ "</span>)</span></span></div>";
								message += "</div></li>";
								i++;
							}
							message += "</ul>";
							$(".search_result").append(message);
							$(".timeago").timeago();

						}
					}
				});
	}

	function searchUsers(_nickname, _page) {
		flag = 1;
		$
				.ajax({
					type : "post",
					// async : false,
					url : "search/users",
					data : {
						nickname : _nickname,
						page : _page
					},
					dataType : "json",
					success : function(data) {
						var i = 0;
						if (data.returndata != undefined) {
							$(".search_result").empty();
							$(".search_result").append(
									"<table class=\"friend_list\">");
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
							$(".friend_list").append(message);
							$(".search_result").append("</table>");
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
			searchUsers(content, pageNum);
		else {
			searchMessages(content, pageNum);
		}

	});// 跳转上一页

	$(".nextPage").click(function() {
		pageNum++;

		if (flag == 1)
			searchUsers(content, pageNum);
		else {
			searchMessages(content, pageNum);
		}
	}); // 跳转下一页

	function goTo(targetNickname) {
		window.location = "userinfo.jsp?username=" + $.query.get("username")
				+ "&userToken=" + $.query.get("userToken") + "&targetNickname="
				+ targetNickname;

	}

	$(".weiboinfo").live(
			'click',
			function() {
				var param = "username=" + $.query.get("username")
						+ "&userToken=" + $.query.get("userToken") + "&id="
						+ $(this).attr("id");
				window.open("message.jsp?" + param);
			});
</script>
</html>
