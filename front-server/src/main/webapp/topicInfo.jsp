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
	display: inline-block;
	float: right;
	width: 24%;
	/*height: 1000px;*/
	overflow: auto;
	border-radius: 0px 5px 5px 0px;
	background: #f9f9f9;
}

.topic_left_content {
	display: inline-block;
	float: left;
	width: 75%;
	/*height: 1000px;*/
	overflow: auto;
	border-radius: 5px 0px 0px 5px;
	background: white;
}

.header {
	width: 1000px auto;
	margin-bottom: 10px;
}

.top_wrap {
	background-color: snow;
	height: 140px;
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

.otherCom {
	margin-left: 25px;
	width: 700px;
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
				<div class="line2_topic_name">#情人节这样过#</div>
				<div class="line2_opt">
					<button>分享</button>
				</div>
				<div class="line2_count">
					<table class="tb_counter" cellspacing="0" cellpadding="0">
						<tbody>
							<tr>
								<td
									style="width: 70px; text-align: center; padding: 5px;"><div style="border-right: 1px solid gray; padding-right: 5px;"><strong
									style="display: block;">111</strong> <span style="font-size: 12px; color: gray;">阅读</span></div></td>
								<td
									style="width: 70px; text-align: center; padding: 5px;"><div style="border-right: 1px solid gray; padding-right: 5px;"><strong
									style="display: block;">111</strong> <span style="font-size: 12px; color: gray;">微博</span></div></td>
								<td style="width: 70px; text-align: center;"><div style=""><strong
									style="display: block;">111</strong> <span style="font-size: 12px; color: gray;">评论</span></div></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="topic_right_content">
			<div id="heated_topic">
				<div class="sub_title"
					style="padding-left: 0px; margin-left: 10px; width: 85%; font-size: 20px;">热门话题</div>
				<div
					style="display: inline-block; float: right; font-size: 12px; color: red;"
					class="heat">阅读</div>
				<div class="heated_subtitle">
					<a class="heated_topic" href=""><div id="topic_1">
							新一轮雾霾来袭 你还能自强不吸吗</div></a> <a class="heated_topic" href=""><div
							id="topic_2">那些年，让你跌破眼镜的童鞋</div></a> <a class="heated_topic" href=""><div
							id="topic_3">为400助学金遭性侵的百色贫困女童</div></a> <a class="heated_topic"
						href=""><div id="topic_4">30岁后你会过上什么样的生活</div></a> <a
						class="heated_topic" href=""><div id="topic_5">晒晒你家乡的美食
							都到碗里来！</div></a>
				</div>
				<div class="next_one">换一组 ></div>
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
					<font style="color: blue;">#情人节这样过#</font>情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～情人节，我们要这样过！大胆晒出和情人节有关的图，和大家一起分享你们的浪漫故事哦～
				</div>
			</div>
			<div class="comment_opt"
				style="border-bottom: 3px solid gray; margin-bottom: 30px; width: 95%; font-size: 20px; margin-left: 20px; margin-top: 20px; font-weight: bold; cursor: pointer;">评论
				></div>
			<div class="comments" style="display: none;">
				<textarea class="comarea" name="content" style="height: 60px;"></textarea>
				<span id="cmt_emotion" class="cmt_emotion"></span>
				<div style="margin-left: 90%;" class="comment_btn">
					<button class="comment_button">评论</button>
				</div>
				<div class="comment_btn">
					<ul style="" id="comment_254" class="otherCom">
						<li>
							<div class="msgBox" id="cmt_2">
								<div class="txt">
									<a class="comer_name" href="javascript:void(0);">zerrychu</a>:
									<span class="content">aaa</span>
									<div class="info">
										<time datetime="2016-01-22 15:37:51.0" class="timeago">21
										days ago</time>
									</div>
								</div>
							</div>
						</li>
						<li>
							<div class="msgBox" id="cmt_3">
								<div class="txt">
									<a class="comer_name" href="javascript:void(0);">zdfchu</a>: <span
										class="content">dfsffsf</span>
									<div class="info">
										<time datetime="2016-01-22 15:37:51.0" class="timeago">23
										days ago</time>
									</div>
								</div>
							</div>
						</li>
						<div class="cmt_getPageNum" align="center">
							<span class="cmt_prePage" onclick="cmt_prePage(254)">上一页</span> <span
								class="cmt_nextPage" onclick="cmt_nextPage(254)">下一页</span> <span
								class="pageNum">1</span>
						</div>
					</ul>
				</div>
			</div>
			<div class="weibo_relation"
				style="border-bottom: 3px solid gray; margin-bottom: 30px; width: 95%; font-size: 20px; margin-left: 20px; margin-top: 20px; font-weight: bold;">相关微博
				></div>
			<div class="post_message">
				<form id="MsgForm" action="message/send?type=1" method="post"
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
			<div class="weibolist">
				<ul id="weibo">
					<li id="weibo_254" class="weibo_message"><div
							class="weiboinfo">
							<div class="userPic">
								<a
									href="userinfo.jsp?username=zerry&amp;targetNickname=周周&amp;userToken=6812943e-1efb-4dde-bc62-b748967443df"><img
									onerror="javascript:this.src='images/no_found.png'"
									src="pic/zhouzhou.jpg" title="查看用户信息"></a>
							</div>
							<div class="msgBox">
								<div class="weibo_username">
									<a
										href="userinfo.jsp?targetNickname=周周&amp;username=zerry&amp;userToken=6812943e-1efb-4dde-bc62-b748967443df">周周</a>
								</div>
								jfsljfsjl
								<div class="info">
									<time datetime="2015-11-04 00:21:30.0" class="timeago">3
									months ago</time>
									<span class="num_info"><span class="comment">评论(<span
											class="num">2</span>)&amp;转发(<span class="rpt_num">0</span>)
									</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="support"><img
											onclick="support(254, 1);" src="images/1.png"
											style="width: 8%; height: 50%; display: inline;" class="zan">(<span
											class="num">1</span>)<i
											style="color: gray; margin-top: -35px; margin-left: 65%; display: none;"
											class="like_plus">+1</i></span></span>
								</div>
								<div style="display: none" class="comtxt">
									<textarea name="content" class="comarea_254"
										style="height: 40px; width: 498px;"></textarea>
									<span id="cmt_emotion254" class="cmt_emotion"></span>
									<div class="comment_btn">
										<button class="comment_button">评论</button>
										<button class="repost_button">转发</button>
									</div>
									<ul style="" id="comment_254" class="otherCom"></ul>
								</div>
							</div>
						</div></li>
					<li id="weibo_246" class="weibo_message"><div
							class="weiboinfo">
							<div class="userPic">
								<a
									href="userinfo.jsp?username=zerry&amp;targetNickname=周周&amp;userToken=6812943e-1efb-4dde-bc62-b748967443df"><img
									onerror="javascript:this.src='images/no_found.png'"
									src="pic/zhouzhou.jpg" title="查看用户信息"></a>
							</div>
							<div class="msgBox">
								<div class="weibo_username">
									<a
										href="userinfo.jsp?targetNickname=周周&amp;username=zerry&amp;userToken=6812943e-1efb-4dde-bc62-b748967443df">周周</a>
								</div>
								考试100分！
								<div class="info">
									<time datetime="2015-11-03 09:55:49.0" class="timeago">3
									months ago</time>
									<span class="num_info"><span class="comment">评论(<span
											class="num">0</span>)&amp;转发(<span class="rpt_num">0</span>)
									</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="support"><img
											onclick="support(246, 0);" src="images/2.png"
											style="width: 8%; height: 50%; display: inline;" class="zan">(<span
											class="num">0</span>)<i
											style="color: gray; margin-top: -35px; margin-left: 65%; display: none;"
											class="like_plus">+1</i></span></span>
								</div>
								<div style="display: none" class="comtxt">
									<textarea name="content" class="comarea_246"
										style="height: 40px; width: 498px;"></textarea>
									<span id="cmt_emotion246" class="cmt_emotion"></span>
									<div class="comment_btn">
										<button class="comment_button">评论</button>
										<button class="repost_button">转发</button>
									</div>
									<ul style="" id="comment_246" class="otherCom"></ul>
								</div>
							</div>
						</div></li>
				</ul>
			</div>
		</div>
	</div>
</body>
<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="plugins/timeago.js" type="text/javascript"></script>
<script src="plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
<script src="scripts/checkSubmit.js" type="text/javascript"></script>
<script type="text/javascript">
	$(".comment_opt").click(function() {
		$(".comments").slideToggle();
	});
</script>
</html>