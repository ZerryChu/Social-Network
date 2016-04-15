<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>topic</title>
</head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
.sort {
	margin-top: 50px;
	margin-left: 10%;
	height: 380px;
	width: 1000px;
}

.info {
	margin-left: 10.5%;
	height: auto;
	width: 917px;
	border-radius: 5px 5px 5px 5px;
	background-color: white;
}

.s_info {
	border-radius: 10px 10px 0px 0px;
	width: 170px;
	height: 170px;
	margin: 8px;
	background-color: white;
	float: left;
	cursor: pointer;
}

.headline {
	height: 30px;
	border-radius: 10px 10px 0px 0px;
	border-bottom: 1px solid #eee;
	background-color: #c9f1ff;
}

.s_content {
	
}

.topic_info {
	width: 100%;
}

.topic_info_title {
	background-color: #eee;
	color: gray;
	font-weight: bold;
}

.topic_info td {
	padding-left: 10px;
}

.getPageNum {
	padding: 0px;
	border-radius: 0px 0px 5px 5px;
}

.topic_to_choose {
	cursor: pointer;
}
</style>
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
	<div class="sort" align="center">
		<div class="s_info" id="s1">
			<div class="headline">活动</div>
			<div class="s_content"
				style="height: 139px; width: 170px; background: url('topic/act.jpg');"></div>
		</div>
		<div class="s_info" id="s2">
			<div class="headline">时尚</div>
			<div class="s_content"
				style="height: 139px; width: 170px; background: url('topic/fashion.jpg');"></div>
		</div>
		<div class="s_info" id="s3">
			<div class="headline">体育</div>
			<div class="s_content"
				style="height: 139px; width: 170px; background: url('topic/pe.jpg');"></div>
		</div>
		<div class="s_info" id="s4">
			<div class="headline">国际</div>
			<div class="s_content"
				style="height: 139px; width: 170px; background: url('topic/glob.jpg');"></div>
		</div>
		<div class="s_info" id="s5">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s6">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s7">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s8">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s9">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
		<div class="s_info" id="s10">
			<div class="headline">空</div>
			<div class="s_content"></div>
		</div>
	</div>
	<div class="info">
		<div style="border-radius: 0px 0px 0px 0px;" class="headline">
			<div class="search" style="float: right;">
				<form>
					<input type="text" class="search_text" /><input class="btn"
						type="button" value="话题搜索">
				</form>
			</div>
		</div>
		<table class="topic_info" cellspacing="0" cellpadding="0">
			<tr class="topic_info_title">
				<td style="width: 10%">id</td>
				<td style="width: 50%;">话题</td>
				<td>阅读量</td>
				<td>讨论</td>
				<td>微博</td>
			</tr>
			<!--  
			<tr>
				<td style="width: 70%;">#情人节要这样过#</td>
				<td>111</td>
				<td>111</td>
				<td>111</td>
			</tr>
			-->
		</table>
		<div class="getPageNum" align="center">
			<span style="font-weight: bold;" class="prePage">上一页</span><span
				style="font-weight: bold;" class="nextPage">下一页</span>
			<form style="display: inline-block;">
				第<input style="width: 30px;" class="pageNum" type="number">页<input
					type="button" class="btn" value="跳转" onclick="goToPage()">
			</form>
		</div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="scripts/search.js" type="text/javascript"></script>
<script type="text/javascript">
	var topic = 0;
	if ((topic = $.query.get("id")) != 0)
		showTopics(topic, 1);
	function showTopics(id, page) {
		$
				.ajax({
					type : "post",
					url : "topic/show",
					data : {
						id : id,
						page : page
					},
					dataType : "json",
					success : function(data) {
						$
								.each(
										data,
										function() {
											var i = 0;
											var str = "";
											while (data.returndata[i] != undefined) {
												str += "<tr class=\"topic_to_choose\"><td class=\"topic_id\" style=\"width: 10px\">"
														+ data.returndata[i].id
														+ "</td><td style=\"width: 50%;\">"
														+ data.returndata[i].name
														+ "</td><td>"
														+ data.returndata[i].read_num
														+ "</td><td>"
														+ data.returndata[i].comment_num
														+ "</td><td>"
														+ data.returndata[i].weibo_num
														+ "</td></tr>";
												i++;
											}
											$(".topic_info").empty();
											$(".topic_info")
													.append(
															"<tr class=\"topic_info_title\"><td style=\"width: 10%\">id</td><td style=\"width: 50%;\">话题</td><td>阅读量</td><td>讨论</td><td>微博</td></tr>");
											$(".topic_info").append(str);
											page_num = 1;
										});
					}
				});
	}

	var id = 0;
	var pageNum = 0;
	$(".s_info").click(function() {
		id = $(this).attr("id").substr(1);
		showTopics(id, 1);
	});

	$(".s_info").mouseover(function() {
		$(this).css("font-weight", "bold");
		$(this).find(".s_content").css("margin-top", "2px");
		$(this).find(".s_content").css("width", 165);
		$(this).find(".s_content").css("height", 135);
	});

	$(".s_info").mouseout(function() {
		$(this).find(".s_content").css("margin-top", "0px");
		$(this).css("font-weight", "normal");
		$(this).find(".s_content").css("width", 170);
		$(this).find(".s_content").css("height", 140);
	});

	$(".topic_to_choose").live('mouseover', function() {
		$(this).css("font-weight", "bold");
		$(this).css("background-color", "#eee");
	});

	$(".topic_to_choose").live('mouseout', function() {
		$(this).css("font-weight", "normal");
		$(this).css("background-color", "white");
	});

	$(".topic_to_choose").live(
			'click',
			function() {
				/*alert($.query.get("username")) == true? */
				window.location = "topicInfo.jsp?username="
						+ $.query.get("username") + "&userToken="
						+ $.query.get("userToken") + "&id="
						+ $(this).find(".topic_id").text() + "&nickname="
						+ $.query.get("nickname");

			});

	$(".prePage").click(function() {
		pageNum--;
		if (pageNum < 1) {
			pageNum = 1;
		}

		$(".pageNum").val(pageNum);
	});// 跳转上一页

	$(".nextPage").click(function() {
		pageNum++;

		$(".pageNum").val(pageNum);
	});// 跳转下一页

	function goToPage() {
		var num = $(".pageNum").val();
		if (num == "" || isNaN(num)) {
			return;
		}
		if (num <= 1) {
			pageNum = 1;
			$(".pageNum").val(pageNum);
		} else
			pageNum = num;

	} // 跳转指定页面
</script>
</html>