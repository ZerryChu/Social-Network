<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>搜索</title>

<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

body {
	background-color: #73cff1;
}

.clean {
	cursor: pointer;
}

.list_info {
	cursor: pointer;
	color: #006a92;
	width: 120px;
	padding-left: 20px;
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

.left_wrap {
	display: inline-block;
	float: left;
	width: 20%;
	height: 616px;
}

.left_content {
	border-right: 2px solid gray;
	height: 304px;
	width: 96%;
	border-radius: 5px 0px 0px 5px;
	background: white;
}

.right_content {
	display: inline-block;
	float: left;
	width: 78%;
	height: 600px;
	border-radius: 0px 5px 5px 0px;
	background: white;
}

#weibo {
	margin-left: 50px;
}

.title {
	border-bottom: 2px solid grey;
	margin-top: 50px;
	margin-left: 40px;
	margin-right: 40px;
	background: silver;
}

.search_text {
	margin-left: 400px;
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

.history {
	height: 40%;
}

.heated_search {
	
}

.left_sub_title {
	/*border: 1px solid silver;*/
	height: 40px;
	padding: 10px;
	border-bottom: 1px solid silver;
	background-color: #dee3e3;
}

.heated_search_list {
	margin-left: 50px;
	margin-top: 10px;
}

.history_info {
	display: inline-block;
	font-weight: bold;
}

.search_history_list {
	float: left;
	margin-left: 50px;
}

.target_info {
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

.friend_name {
	margin: 2px;
	float: left;
	font-size: 18px;
	font-weight: bold;
	width: 112px;
}

.count_info {
	margin: 2px;
	float: left;
}

.friend_icon {
	float: left;
	margin-left: 10px;
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 10px;
	margin-right: 10px;
}

.friend_info, .focus_info {
	font-size: 12px;
}

.friend_info span, .focus_info span {
	font-weight: bold;
	color: #759aad;
}

.friend_list {
	padding-left: 24px;
}

.txt {
	float: left;
	width: 470px;
	margin-left: 10px;
}
</style>

</head>
<body>
	<div class="bg">
		<img style="heigth: 100%; width: 100%;" src="images/index_bg.jpg" />
	</div>
	<div class="top">
		<ul class="top_content" style="font-weight: bold;">
			<li><a class="link"
				href="main?username=${param.username}&userToken=${param.userToken}">首页</a></li>
			<li><a class="link"
				href="label.jsp?username=${param.username}&userToken=${param.userToken}">标签</a></li>
			<li><a class="link"
				href="topic.jsp?username=${param.username}&userToken=${param.userToken}">话题</a></li>

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
		<div class="left_wrap">
			<div class="left_content">
				<div style="border-radius: 5px 0px 0px 0px;" class="left_sub_title">
					<div class="history_info">搜索历史</div>
					<span style="margin-left: 20px; color: #006a92; font-size: 10px;"
						class="clean">-清除</span>
				</div>

				<div class="history">
					<br>
					<ul class="search_history_list">
					</ul>
				</div>

			</div>
			<div style="margin-top: 8px;" class="left_content">
				<div class="left_sub_title">
					<div style="display: inline-block; font-weight: bold;">热搜榜</div>
					<span style="margin-left: 20px; color: #006a92; font-size: 10px;"
						class="change">-换一组</span>
				</div>
				<div class="heated_search">
					<ul class="heated_search_list">
						<li>111</li>
						<li>222</li>
						<li>aa</li>
					</ul>
				</div>
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
<script src="scripts/checkSubmit.js" type="text/javascript"></script>
<script src="plugins/jquery.cookie.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var pageNum = 1;
	var flag; // 1 搜人 2 搜微博
	var content;

	/*$(".top").keypress(function(e) {
		// 回车键事件 
		if (e.which == 13) {
			search();
		}
	});*/

	/**
	 * flag 1:微博搜索记录 2:用户搜索记录
	 */
	function getSearchHistory(flag) {
		var history;
		if (flag == 1)
			history = decodeURI($.cookie('history_msg')).split(";");
		else
			history = decodeURI($.cookie('history_user')).split(";");
		var ul = $(".search_history_list");
		ul.empty();
		var str = "";
		for (var i = history.length - 2; i >= 0; i--) {
			str += "<li class=\"list_info\">" + history[i] + "</li>";
		}
		ul.append(str);
	}

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
		if (content == undefined || content == "") {
			alert("no content.");
			return;
		}
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
						username : $.query.get("username"),
						content : _content,
						page : _page
					},
					dataType : "json",
					success : function(data) {
						if (data.returndata != undefined) {
							var message;
							var i = 0;
							while (data.returndata[i] != undefined) {
								if (i == 0) {
									$(".search_result").empty();
									message = "<ul id=\"weibo\">";
								}

								var weiboId = "weibo_" + data.returndata[i].id;
								message += "<li id=\"" + weiboId + "\"><div class=\"weiboinfo\" id=\"" 
										+ data.returndata[i].id 
										+ "\" style=\"background: white; padding-left: 10px; padding-right: 10px; padding-top: 2px;\">";
								message += "<img style=\"float: left; width:50px; height: 50px;\" src=\""
									+ "pic/"
									+ data.returndata[i].author.username
									+ ".jpg"
									+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/><div class=\"txt\">"
										+ "<div class=\"weibo_username\"><span style=\"margin-left: 10px; color: #006a92;\">"
										+ data.returndata[i].author.nickname
										+ "</span></div>"
										+ data.returndata[i].content;
								if (data.returndata[i].pic != undefined
										&& data.returndata[i].pic != "")
									message += "<br><img class=\"msg_pic\" title=\"点击显示原图\" src=\"message/"
												+ data.returndata[i].pic
												+ ".jpg\">";
								if (data.returndata[i].label_id != 0)
									message += "<div id=\"lbl"
												+ data.returndata[i].label_id
												+ "\" class=\"msg_label\"><span id=\"l_icon\" class=\"icon\"></span>"
											+ data.returndata[i].label_name
											+ "</div>";
								message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
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
							if (i == 0)
								pageNum--;
							else {
								message += "</ul>";
								$(".search_result").append(message);
								$(".timeago").timeago();
							}
							getSearchHistory(1);
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
							var index = 0;
							var message = "";
							while (data.returndata[i] != undefined) {
								if (i == 0) {
									$(".search_result").empty();
									$(".search_result").append(
											"<table class=\"friend_list\">");
								}
								if (index == 3) {
									index = 0;
									message += "</tr>";
								}
								index++;
								if (index == 1) {
									message += "<tr>";
								}
								message += "<td><div class=\"target_info\" onclick=\"goTo('"
										+ data.returndata[i].nickname
										+ "')\"><img src=\"pic/" 
														+ data.returndata[i].username 
														+ ".jpg\" style=\"width:70px; height:70px;\" class=\"friend_icon\"><div class=\"friend_name\">"
										+ data.returndata[i].nickname
										+ "</div><div class=\"friend_info\">听众：<span class=\"num\">"
										+ data.returndata[i].friend_num
										+ "</span></div><div class=\"focus_info\">关注：<span class=\"num\">"
										+ data.returndata[i].focus_num
										+ "</span></div></div></td>";
								i++;
							}
							if (i == 0)
								pageNum--;
							else {
								message += "</tr>";
								$(".friend_list").append(message);
								$(".search_result").append("</table>");
							}
							getSearchHistory(2);
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

	$(".clean").click(function() {
		if (confirm("确认清除历史记录？")) {
			DelCookie("history_msg");
			DelCookie("history_user");
			var ul = $(".search_history_list");
			ul.empty();
		}
	});

	//获取指定名称的cookie的值 
	function getCookie(objName) {
		var arrStr = document.cookie.split("; ");
		for (var i = 0; i < arrStr.length; i++) {
			var temp = arrStr[i].split("=");
			if (temp[0] == objName)
				return unescape(temp[1]);
		}
	}

	/**
	 * 	清楚指定cookies
	 */
	function DelCookie(name) {
		var exp = new Date();
		exp.setTime(exp.getTime() - 1000);
		var cval = getCookie(name);
		if (cval != null)
			document.cookie = name + "=" + cval + ";expires="
					+ exp.toGMTString() + ";path=/";
	}

	$(".list_info").live('mouseover', function() {
		$(this).css("background-color", "snow");
		$(this).css("color", "#eb7350");
	});

	$(".list_info").live('mouseout', function() {
		$(this).css("background-color", "");
		$(this).css("color", "#006a92");
	});

	$(".list_info").live('click', function() {
		if (flag == 1) {
			searchUsers($(this).text(), 1);
		} else {
			searchMessages($(this).text(), 1);
		}
	});

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

	$(".top_content li").mouseover(function() {
		this.style.background = "snow";
	});

	$(".top_content li").mouseout(function() {
		this.style.background = "";
	});

	$(".target_info").live("mouseover", function() {
		$(this).css("width", "208");
		$(this).css("height", "78");
		$(this).css("border", "2px solid lightblue");
	});

	$(".target_info").live("mouseout", function() {
		$(this).css("width", "210");
		$(this).css("height", "80");
		$(this).css("border", "1px solid grey");
	});
</script>
</html>
