<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>
	<div class="weiboinfo">
		<div class="userPic">
			<a href=""><img
				src=""
				onerror="javascript:this.src='images/no_found.png'" /></a>
		</div>
		<div class="msgBox">
			<div class="weibo_username">
				<a href=""></a>
			</div>
			<div class="txt">
				<div class="repostInfo"></div>
			</div>
			<div class="info">
				<time class="timeago" datetime=""></time>
				<span class="num_info"><span class="comment">评论(<span
						class="num"></span>)
				</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="repost">转发(<span
						class="num"></span>)
				</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="support"><img
						class="zan" style="width: 8%; height: 50%;" src="images/2.png"
						onclick="">(<span class="num"></span>)</span></span>
			</div>
			<div class="rpt" style="display: none">
				<textarea class="rptarea" name=""
					style="height: 40px; width: 498px;"></textarea>
				<div class="repost_btn">
					<button class="repost_button">转发</button>
				</div>
			</div>
			<div class="comtxt" style="display: none">
				<textarea style="height: 40px; width: 498px;" class="comarea"
					name="content" style="width: 451px, height: 36px;"></textarea>
				<div class="comment_btn">
					<div class="andforward">
						<input type="checkbox" value="1" name="forward" id="forward" /><label
							for="forward">同时转发</label>
					</div>
					<button class="comment_button">评论</button>
				</div>
				<ul class="otherCom" id="comment" style=""></ul>
			</div>
		</div>
	</div>

	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/timeago.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/show_comments.js" type="text/javascript"></script>
	<script src="scripts/send_comment.js" type="text/javascript"></script>
	<script src="scripts/send_message.js" type="text/javascript"></script>
	<script src="scripts/repost_message.js" type="text/javascript"></script>
	<script src="scripts/judgeIfSupport.js" type="text/javascript"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		$
		.ajax({
			type : "post",
			// async : false,
			url : "message/show_message",
			data : {
				username : $.query.get("username"),
				userToken : $.query.get("userToken"),
				message_id : $.query.get("userToken"),
				flag : 1
			},
			dataType : "json",
			success : function(data) {
				if (data.returndata != undefined) {
					$(".timeago").attr("datetime", data.returndata.create_time);
					$(".repost").find(".num").text(data.returndata.repost_times);
					$(".comment").find(".num").text(data.returndata.comment_times);
					$(".support").find(".num").text(data.returndata.support_times);
					$(".repostInfo").text(data.returndata.content);
					$(".userPic a").attr("href", "userinfo.jsp?targetNickname=" + data.returndata.author);
					//$(".userPic a").attr("src", "images/" + data.returndata.name + ".jpg");
					$(".weibo_username a").attr("href", "userinfo.jsp?targetNickname=" + data.returndata.author);
					$(".weibo_username a").text(data.returndata.author);

				}
			}
		});
	});
	</script>
</body>
</html>