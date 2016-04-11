<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>topic_info</title>
</head>
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
.topic_cmt_emotion, .msg_emotion, .cmt_emotion {
	width: 42px;
	height: 20px;
	background: url(face/icon.gif) no-repeat 2px 2px;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 3px;
	cursor: pointer
}

.msg_emotion:hover, .cmt_emotion:hover, .rpt_emotion:hover {
	background-position: 2px -28px
}

.qqFace {
	margin-top: 4px;
}

.qqFace table td {
	padding: 0px;
}

.qqFace table td img {
	cursor: pointer;
	border: 1px #fff solid;
}

.qqFace table td img:hover {
	border: 1px #0066cc solid;
}

////////////////////////
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

.topic_right_content {
	overflow: auto;
	border-radius: 0px 5px 5px 0px;
	background: #f9f9f9;
	padding: 5px;
}

.topic_left_content {
	display: inline-block;
	float: left;
	width: 75%;
	overflow: auto;
	border-radius: 5px 0px 0px 5px;
	background: white;
}

.header {
	width: 1000px auto;
	margin-bottom: 10px;
}

.top_wrap {
	background-color: white;
	height: 140px;
	border-radius: 5px 5px 0px 0px;
}

.top_wrap_line2 {
	background-color: lightgray;
	height: 97px;
}

.line2_pic img {
	width: 130px;
	height: 130px;
	margin-left: 30px;
	margin-top: -75px;
	position: absolute;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
}

.line2_topic_name {
	padding-left: 200px;
}

.line2_opt {
	padding-left: 200px;
}

.search {
	
}

.article {
	margin: 30px;
}

#topic_Com {
	margin-left: 25px;
	width: 660px
}

.msgBox {
	margin-left: 30px;
}

.comarea {
	margin-left: 25px;
	width: 700px;
}

.weiboinfo {
	width: 700px;
}

.weibo_relation {
	margin-top: 30px;
}

.line2_count {
	margin-left: 76%;
	background-color: white;
	width: 23%;
}

.topic_subtitle {
	color: #006a92;
	padding-top: 30px;
	padding-left: 10px;
	padding-right: 10px;
	padding-bottom: 20px;
	font-size: 14px;
}

.topic_classify {
	text-decoration: none;
	color: #006a92;
	padding-top: 50px;
	width: 92%;
	font-size: 12px;
}

.heated_subtitle, .topic_subtitle {
	padding: 15px 10px 20px;
}

.opt {
	margin-left: 87%;
}

.opt button {
	float: right;
	margin-right: 23px;
	margin-bottom: -40px;
}

.topic_comarea {
	resize: none;
	width: 98%;
	height: 50px;
	overflow-y: hidden;
	margin-left: 26px;
	width: 93%;
}

.topicCmt_prePage, .topicCmt_nextPage {
	cursor: pointer;
	color: gray;
	padding-left: 10px;
	padding-right: 10px;
	font-size: 13px;
}

.msgBox {
	margin-left: 0px;
}

.right_wrap {
	display: inline-block;
	float: right;
	width: 24%;
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
	<div class="main">
		<div class="header">
			<div class="top_wrap"></div>
			<div class="top_wrap_line2">
				<div class="line2_pic">
					<img src="topic/1.jpg">
				</div>
				<div class="line2_topic_name"></div>
				<div class="line2_opt">
					<button>分享</button>
				</div>
				<div class="line2_count">
					<table class="tb_counter" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td style="width: 70px; text-align: center; padding: 5px;"><div
										style="border-right: 1px solid gray; padding-right: 5px;">
										<strong id="read_num" style="display: block;"></strong> <span
											style="font-size: 12px; color: gray;">阅读</span>
									</div></td>
								<td style="width: 70px; text-align: center; padding: 5px;"><div
										style="border-right: 1px solid gray; padding-right: 5px;">
										<strong id="weibo_num" style="display: block;"></strong> <span
											style="font-size: 12px; color: gray;">微博</span>
									</div></td>
								<td style="width: 70px; text-align: center;"><div style="">
										<strong id="comment_num" style="display: block;"></strong> <span
											style="font-size: 12px; color: gray;">讨论</span>
									</div></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="topic_left_content">
			<div class="search" style="float: right;">
				<form>
					<input type="text" class="search_text" /><input class="btn"
						type="button" value="话题搜索">
				</form>
			</div>
			<div class="article">
				<div class="content">
					<font class="topic_title" style="color: blue;"></font>
				</div>
			</div>
			<div class="comment_opt"
				style="border-bottom: 3px solid gray; margin-bottom: 30px; width: 95%; font-size: 20px; margin-left: 20px; margin-top: 20px; font-weight: bold; cursor: pointer;">讨论
				></div>
			<div class="comments" style="display: none;">
				<textarea class="topic_comarea" name="content" style="height: 60px;"></textarea>
				<div class="opt">
					<span id="topic_cmt_emotion" class="topic_cmt_emotion"></span>
					<div style="margin-left: 90%;" class="comment_btn">
						<button class="topicComment_button">评论</button>
					</div>
				</div>
				<div class="comment_btn">
					<ul id="topic_Com" class="otherCom">
					</ul>
				</div>
			</div>
			<div class="weibo_relation"
				style="border-bottom: 3px solid gray; margin-bottom: 30px; width: 95%; font-size: 20px; margin-left: 20px; margin-top: 20px; font-weight: bold;">相关微博
				></div>
			<div class="post_message">
				<form id="MsgForm"
					action="message/send_topicWeibo?topic_id=${param.id}" method="post"
					target="upframe" enctype="multipart/form-data">
					<textarea class="message_content" id="content" name="content"></textarea>
					<br> <span id="msg_emotion" class="msg_emotion"></span><input
						type="file" style="width: 150px;" class="fileOnLoad" name="pic">
					<!-- <select
						class="type" name="type">
						<option value="2">暂无</option>
						<option value="1" selected="selected">好友可见</option>
					</select> -->
					<input type="hidden" name="username" value="${param.username}">
					<input type="hidden" name="userToken" value="${param.userToken}"><input
						style="float: right;" type="reset"><input
						style="float: right;" class="send_button" type="submit"
						value="分享内容">
				</form>
			</div>
			<div style="display: none; padding-left: 100px;" class="send_success">发送成功...</div>

			<div class="weibolist">
				<ul id="weibo">
				</ul>
			</div>
			<div class="scroll_helper"
				style="padding: 3px; padding-left: 42%; font-weight: bold; color: gray; background-color: lightgray;">下滑加载更多...</div>
		</div>
		<div class="right_wrap">
			<div class="topic_right_content">
				<div id="userinfo">
					<div id="nickname"></div>
					<img id="user_icon" src="pic/${param.username}.jpg"
						onerror="this.src='images/no_found.png'" /> <br>
					<div class="option">
						<img class="logout" src="images/sign-out.png" title="登出"
							alt="sign-out" style="width: 20px; height: 20px;"> <a
							href="privateMsgList.jsp?username=${param.username}&userToken=${param.userToken}"><img
							class="private_msg" src="images/private_message.png" title="私信"
							alt="private_msg" style="width: 20px; height: 20px;"></a>
					</div>
				</div>
			</div>
			<div style="margin-top: 10px;" class="topic_right_content">
				<div id="heated_topic">
					<div class="sub_title"
						style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;"><span id="tpk" class="icon"></span>热门话题</div>
					<div class="heated_subtitle">
						<a class="heated_topic"><div id="topic_1">#情人节要这样过#</div></a> <a
							class="heated_topic"><div id="topic_2">#那些年，让你跌破眼镜的童鞋#</div></a>
						<a class="heated_topic"><div id="topic_3">#为400助学金遭性侵的百色贫困女童#</div></a>
						<a class="heated_topic"><div id="topic_4">#30岁后你会过上什么样的生活#</div></a>
						<a class="heated_topic"><div id="topic_5">#晒晒你家乡的美食
								都到碗里来！#</div></a>
					</div>
					<div class="next_one">换一组 ></div>
				</div>
			</div>
			<div style="margin-top: 10px;" class="topic_right_content">
				<div id="topic_info">
					<div class="sub_title"
						style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;"><span id="l_icon" class="icon"></span>话题分类</div>
					<div class="topic_subtitle">
						<a class="topic_classify"
							href="topic.jsp?id=1&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_1">活动</div></a> <a class="topic_classify"
							href="topic.jsp?id=2&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_2">时尚</div></a> <a class="topic_classify"
							href="topic.jsp?id=3&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_3">体育</div></a> <a class="topic_classify"
							href="topic.jsp?id=4&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_4">国际</div></a> <a class="topic_classify"
							href="topic.jsp?id=5&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_5">空</div></a> <a class="topic_classify"
							href="topic.jsp?id=6&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_6">空</div></a> <a class="topic_classify"
							href="topic.jsp?id=7&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_7">空</div></a> <a class="topic_classify"
							href="topic.jsp?id=8&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_8">空</div></a> <a class="topic_classify"
							href="topic.jsp?id=9&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_9">空</div></a> <a class="topic_classify"
							href="topic.jsp?id=10&username=${param.username}&userToken=${param.userToken}&nickname=${param.nickname}"><div
								id="topic_10">空</div></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<a id="gtotop" class="w-top" style="visibility: visible; opacity: 1;"
		hidefocus="true" href="#" title="回到顶部">回到顶部</a>

	<iframe id="upframe" name="upframe" src="" style="display: none;">
	</iframe>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script src="scripts/checkSubmit.js" type="text/javascript"></script>
<script src="scripts/show_messages.js" type="text/javascript"></script>
<script src="scripts/support.js" type="text/javascript"></script>
<script src="scripts/showUserInfo.js" type="text/javascript"></script>
<script src="scripts/jquery-bigic.js" type="text/javascript"></script>
<script type="text/javascript">
	var pageNumber = 1;
	var off = false;
	$(document).scroll(
			function() {
				if (!off
						&& ($(window).height() + $(window).scrollTop()) >= $(
								"html").height()) {
					pageNumber++;
					setTimeout("show_messagesByTopicId(pageNumber, false);",
							1000);
				}
			});
	//暂无flag ：0 缓存show 1 非缓存show
	function show_messagesByTopicId(pageNumber, if_clear_oldMsg) {
		if (true == if_clear_oldMsg)
			$("#weibo").empty();
		$
				.ajax({
					type : "post",
					url : "message/show_topicWeibo",
					data : {
						username : $.query.get("username"), 
						topic_id : $.query.get("id"),
						page : pageNumber
					},
					dataType : "json",
					success : function(data) {
						$
								.each(
										data,
										function() {
											var i = 0;
											if (data.returndata[i] == undefined
													|| data.returndata[i] == "") {
												$(".scroll_helper").hide();
												off = true;
											}
											while (data.returndata[i] != undefined) {

												var return_content = replace_em(data.returndata[i].content); // 解析QQ表情
												var message = "<li  class=\"weibo_message\" id=\"weibo_"
													+ data.returndata[i].id
													+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\""
														+ "userinfo.jsp?username="
														+ $.query
																.get("username")
														+ "&targetNickname="
														+ data.returndata[i].author.nickname
														+ "&userToken="
														+ $.query
																.get("userToken")
														+ "\"><img title=\"查看用户信息\" src=\""
													+ "pic/"
													+ data.returndata[i].username
													+ ".jpg"
													+ "\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"weibo_username\"><a href=\""
														+ "userinfo.jsp?targetNickname="
														+ data.returndata[i].author.nickname
														+ "&username="
														+ $.query
																.get("username")
														+ "&userToken="
														+ $.query
																.get("userToken")
														+ "\">"
														+ data.returndata[i].author.nickname
														+ "</a></div>";

												message += return_content;
												if (data.returndata[i].pic != undefined
														&& data.returndata[i].pic != "")
													message += "<br><img class=\"msg_pic\" title=\"点击显示原图\" src=\"message/"
															+ data.returndata[i].pic
															+ ".jpg\">";
												message += "<div class=\"info\"><time class=\"timeago\" datetime=\""
														+ data.returndata[i].create_time
														+ "\"></time><span class=\"num_info\"><span class=\"comment\">评论(<span class=\"num\">"
														+ data.returndata[i].comment_times
														+ "</span>)&转发(<span class=\"rpt_num\">"
														+ data.returndata[i].repost_times
														+ "</span>)</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class=\"support\"><img class=\"zan\" style=\"width:8%; height:50%;\" src=\"images/2.png\" onclick=\"\">(<span class=\"num\">"
														+ data.returndata[i].support_times
														+ "</span>)<i class=\"like_plus\" style=\"color: gray; margin-top: -35px; margin-left: 65%; display: none;\">+1</i></span></span></div><div class=\"comtxt\" style=\"display: none\"><textarea style=\"height: 40px; width: 498px;\" class=\"comarea_"
														+ data.returndata[i].id
														+ "\" name=\"content\" style=\"width: 451px, height: 36px;\"></textarea><span class=\"cmt_emotion\" id=\"cmt_emotion"
														+ data.returndata[i].id
														+ "\"></span><div class=\"comment_btn\"><button class=\"comment_button\">评论</button><button class=\"repost_button\">转发</button></div>"
														+ "<ul class=\"otherCom\" id=\"comment_"
														+ data.returndata[i].id
														+ "\" style=\"\"></ul>"
														+ "</div></div></div></li>";
												$("#weibo").append(message);
												judgeIfSupport(
														data.returndata[i].id, data.returndata[i].supported);

												var textarea = ".comarea_"
														+ data.returndata[i].id;
												var emotion = '#cmt_emotion'
														+ data.returndata[i].id;
												$(emotion).qqFace({
													assign : textarea, // 给输入框赋值
													path : 'face/' // 表情图片存放的路径
												});

												i++;
											}
										});
						$(".timeago").timeago();
						$(".msg_pic").bigic();
					}
				});
	}

	function showTopics() {
		$.ajax({
			type : "post",
			url : "topic/show_topic",
			data : {
				username : $.query.get("username"),
				id : $.query.get("id"),
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.returndata != undefined) {
						$(".topic_title").append(
								"#" + data.returndata.name + "#");
						$(".line2_topic_name").append(
								"#" + data.returndata.name + "#");
						$(".topic_title").after(data.returndata.content);
						$("#weibo_num").append(data.returndata.weibo_num);
						$("#comment_num").append(data.returndata.comment_num);
						$("#read_num").append(data.returndata.read_num);
					}
				});
			}
		});
	}

	var topic_pageNum = 1;
	function showTopicComments(page) {
		$
				.ajax({
					type : "post",
					url : "topic/show_comment",
					data : {
						id : $.query.get("id"),
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
												var return_content = replace_em(data.returndata[i].comment); // 解析QQ表情
												str += "<li><div class=\"msgBox\"><div class=\"txt\"><a class=\"comer_name\" href=\"javascript:void(0);\">"
														+ data.returndata[i].nickname
														+ "</a>: <span class=\"content\">"
														+ return_content
														+ "</span><div class=\"info\"><time datetime=\""
														+ data.returndata[i].create_time 
														+ "\" class=\"timeago\"></time></div></div></div></li>";
												i++;
											}
											str += "<div id=\"topic_cmt_pageNum\" class=\"cmt_getPageNum\" align=\"center\"><span class=\"topicCmt_prePage\" onclick=\"topicCmt_prePage()\">上一页</span> <span class=\"topicCmt_nextPage\" onclick=\"topicCmt_nextPage()\">下一页</span></div>";
											$(".otherCom").empty();
											$(".otherCom").append(str);
											$(".timeago").timeago();
										});
					}
				});
	}

	function send_topicComment(id, comment_content) {
		if (checkSubmit(2000)) {
			$.ajax({
				type : "post",
				url : "comment/add_topicComment",
				async : false, // 发帖同步执行
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					comment : comment_content,
					topic_id : id
				},
				dataType : "json",
				success : function(data) {
					$.each(data, function() {
						if (data.msg == 1) {
							$(".comment_num span").text(
									parseInt($(".comment_num").find().text(),
											10) + 1); // 讨论数+1   //bug
							showTopicComments(1);
						} else {
							//...tell fail
							alert("fail");
						}
					});
				}
			});
		}
	}

	function getTopicInfo(name) {
		$.ajax({
			type : "post",
			url : "topic/show_topicByName",
			data : {
				name : name
			},
			dataType : "json",
			success : function(data) {
				$.each(data, function() {
					if (data.returndata.id != undefined) {
						window.location = "topicInfo.jsp?username="
								+ $.query.get("username") + "&userToken="
								+ $.query.get("userToken") + "&nickname="
								+ $.query.get("nickname") + "&id="
								+ data.returndata.id;
					} else {
						//...tell fail
						alert("fail");
					}
				});
			}
		});
	}

	$(".topicComment_button").click(function() {
		var comarea = ".topic_comarea";
		var content = $(comarea).val();
		send_topicComment($.query.get("id"), content);
		$(comarea).val(""); // 清空输入框
	});

	function topicCmt_prePage() {
		if (topic_pageNum == 1)
			return;
		topic_pageNum--;
		if (topic_pageNum < 1) {
			topic_pageNum = 1;
		}
		showTopicComments(topic_pageNum);
	} // 跳转上一页

	function topicCmt_nextPage() {
		topic_pageNum++;
		showTopicComments(topic_pageNum);
	} // 跳转下一页

	$(function() {
		$('#msg_emotion').qqFace({
			assign : '#content', //给输入框赋值 
			path : 'face/' //表情图片存放的路径 
		});

	});
	var textarea = ".topic_comarea";
	var emotion = "#topic_cmt_emotion";
	$(emotion).qqFace({
		assign : textarea, // 给输入框赋值
		path : 'face/' // 表情图片存放的路径
	});

	$("#nickname").text($.query.get("nickname"));
	showTopics();
	showTopicComments(1);
	show_messagesByTopicId(1, true);

	$("#MsgForm")
			.submit(
					function() {
						var num = $("#weibo_num").text();
						$("#weibo_num").text(parseInt(num, 10) + 1); // 广播数+1
						$(".send_success").slideDown();
						setTimeout(
								'$("#MsgForm")[0].reset();$(".send_success").slideUp();show_messagesByTopicId(1, true);',
								2000);
					});

	$(".heated_topic").live("click", function() {
		getTopicInfo($(this).text());
	});

	$(".comment_opt").click(function() {
		$(".comments").slideToggle();
	});

	$(".topic_classify").mouseover(function() {
		$(this).css("color", "gray");
		$(this).css("font-weight", "bold");
	});

	$(".topic_classify").mouseout(function() {
		$(this).css("color", "#006a92");
		$(this).css("font-weight", "normal");
	});

	$(".heated_topic").live("mouseover", function() {
		$(this).css("color", "gray");
		$(this).css("font-weight", "bold");
	});

	$(".heated_topic").live("mouseout", function() {
		$(this).css("color", "#006a92");
		$(this).css("font-weight", "normal");
	});

	$(".next_one").mouseover(function() {
		$(this).css("color", "#eb7350");
	});

	$(".next_one").mouseout(function() {
		$(this).css("color", "black");
	});
	
	$(".comment").live('mouseover', function() {
		$(this).css("color", "#759aad");
	});

	$(".comment").live('mouseout', function() {
		$(this).css("color", "gray");
	});

	$(".comment").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		var comtxt = $(this).parents("li").find(".comtxt");
		if (comtxt.css("display") == "none") {
			var target = "#comment_" + message_id;
			if ($(target).html() == "") {
				show_comments(message_id, 1, 1);
			}
			comtxt.slideDown();
			$(this).parents("li").find(".pageNum").text("1");
		} else {
			comtxt.slideUp();
		}
	}); // 查看评论

	$(".repost_button").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		var textarea = ".comarea_" + message_id;
		var content = $(textarea).val();
		repost_message(content, message_id, 1);
		$(textarea).val("");
	}); // 转发微博

	$(".comment_button").live('click', function() {
		var message_id = $(this).parents("li").attr("id");
		message_id = message_id.substr(6);
		comarea = ".comarea_" + message_id;
		content = $(comarea).val();
		send_comment(message_id, content);
		$(comarea).val(""); // 清空输入框
	}); // 发送评论
</script>
</html>