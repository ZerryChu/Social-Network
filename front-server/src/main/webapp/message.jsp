<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css">
<style type="text/css">
.cmt_emotion, .rpt_emotion {
	width: 42px;
	height: 20px;
	background: url(face/icon.gif) no-repeat 2px 2px;
	padding-left: 20px;
	padding-right: 20px;
	padding-top: 3px;
	cursor: pointer
}

.weiboinfo {
	box-shadow: 0 0px 0px #8ab6fc;
}

.cmt_emotion:hover, .rpt_emotion:hover {
	background-position: 2px -28px
}

.Comment {
	cursor: pointer;
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

.textInfo {
	background: #e9e8ea none repeat scroll 0 0;
	border: 1px solid #dee3e3;
	padding-left: 30px;
	padding-right: 30px;
	padding-top: 10px;
	padding-bottom: 10px;
	cursor: pointer;
	width: 440px;
}
</style>
<title>微博</title>
</head>
<body style="background: white;">
	<div class="weibolist">
		<div class="weibo">
			<div class="weibo_message" id="weibo_${param.id}">
				<div class="weiboinfo">
					<div class="userPic">
						<a href=""><img src=""
							onerror="javascript:this.src='images/no_found.png'" /></a>
					</div>
					<div class="msgBox">
						<div class="weibo_username">
							<a href=""></a>
						</div>
						<div class="txt">
							<div class="textInfo"></div>
						</div>
						<div class="label"></div>
						<div class="info">
							<time class="timeago" datetime=""></time>
							<span class="num_info"><span class="Comment">评论(<span
									class="num"></span>) &转发(<span class="rpt_num"></span>)
							</span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="support"><img
									class="zan" style="width: 8%; height: 50%;" src="images/2.png"
									onclick="">(<span class="num"></span>)<i
									class="like_plus"
									style="color: gray; margin-top: -35px; margin-left: 65%; display: none;">+1</i></span></span>
						</div>
						<div class="comtxt" style="display: none">
							<textarea style="height: 40px; width: 498px;" class="comarea"
								name="content"></textarea>
							<span class="cmt_emotion" id="cmt_emotion"></span>
							<div class="comment_btn">
								<button class="Comment_button">评论</button>
								<button class="Repost_button">转发</button>

							</div>
							<ul class="otherCom" id="comment_${param.id}" style=""></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="plugins/jquery-1.10.2.min.js" type="text/javascript"></script>
	<script src="plugins/timeago.js" type="text/javascript"></script>
	<script src="plugins/jquery-migrate-1.2.1.min.js"
		type="text/javascript"></script>
	<script src="plugins/jquery.query-2.1.7.js" type="text/javascript"></script>
	<script src="plugins/jquery.qqFace.js" type="text/javascript"></script>
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/checkSubmit.js" type="text/javascript"></script>
	<script src="scripts/jquery-bigic.js" type="text/javascript"></script>
	<script src="scripts/support.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
							$(function() {
								$('#cmt_emotion').qqFace({
									assign : '.comarea', //给输入框赋值 
									path : 'face/' //表情图片存放的路径 
								});

							});

							$
									.ajax({
										type : "post",
										// async : false,
										url : "message/show_message",
										data : {
											username : $.query.get("username"),
											userToken : $.query
													.get("userToken"),
											message_id : $.query.get("id"),
											flag : 1
										},
										dataType : "json",
										success : function(data) {
											if (data.returndata != undefined) {

												$(".timeago")
														.attr(
																"datetime",
																data.returndata.create_time);
												$(".Comment")
														.find(".rpt_num")
														.text(
																data.returndata.repost_times);
												$(".Comment")
														.find(".num")
														.text(
																data.returndata.comment_times);
												if (data.returndata.label_id != 0) {
													$(".label")
															.append(
																	"<div id=\""
														+ data.returndata.label_id
														+ "\" class=\"msg_label\"><span id=\"l_icon\" class=\"icon\"></span>"
																			+ data.returndata.label_name
																			+ "</div>");
												}
												$(".support")
														.find(".num")
														.text(
																data.returndata.support_times);
												$(".textInfo")
														.text(
																data.returndata.content);
												if (data.returndata.pic != undefined
														&& data.returndata.pic != "")
													$(".textInfo")
															.append(
																	"<br><img class=\"msg_pic\" src=\"message/"
															+ data.returndata.pic + ".jpg\">");
												$(".userPic a")
														.attr(
																"href",
																"userinfo.jsp?userToken="
																		+ $.query
																				.get("userToken")
																		+ "&username="
																		+ $.query
																				.get("username")
																		+ "&targetNickname="
																		+ data.returndata.author.nickname);

												$(".userPic a img")
														.attr(
																"src",
																"pic/"
																		+ data.returndata.author.username
																		+ ".jpg");

												$(".weibo_username a")
														.attr(
																"href",
																"userinfo.jsp?userToken="
																		+ $.query
																				.get("userToken")
																		+ "&username="
																		+ $.query
																				.get("username")
																		+ "&targetNickname="
																		+ data.returndata.author.nickname);
												$(".weibo_username a")
														.text(
																data.returndata.author.nickname);
												judgeIfSupport(
														$.query.get("id"),
														data.returndata.supported);

												$(".timeago").timeago();
												$(".msg_pic").bigic();
											}
										}
									});
						});

		$(".Comment").live('click', function() {
			var message_id = $.query.get("id");
			var comtxt = $(".comtxt");
			if (comtxt.css("display") == "none") {
				show_comments(message_id, 1, 1);
				comtxt.slideDown();
				$(".pageNum").text("1");
			} else {
				comtxt.slideUp();
			}

		}); // 查看评论

		$(".Repost_button").live('click', function() {
			var message_id = $.query.get("id");
			var textarea = ".rptarea";
			var content = $(textarea).val();
			repost_message(content, message_id, 0);
			$(textarea).val("");
		}); // 转发微博

		$(".Comment_button").live('click', function() {
			var message_id = $.query.get("id");
			comarea = ".comarea";
			content = $(comarea).val();
			send_comment(message_id, content);
			$(comarea).val(""); // 清空输入框
		}); //发送评论

		// 显示好友分组
		function showGroupList() {

		}
	</script>
</body>
</html>