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
							name="content"></textarea>
						<div class="comment_btn">
							<div class="andforward">
								<input type="checkbox" value="1" name="forward" id="forward" /><label
									for="forward">同时转发</label>
							</div>
							<button class="comment_button">评论</button>
						</div>
						<ul class="otherCom" id="comment_${param.id}" style=""></ul>
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
	<script src="scripts/show_messages.js" type="text/javascript"></script>
	<script src="scripts/show_comments.js" type="text/javascript"></script>
	<script src="scripts/send_comment.js" type="text/javascript"></script>
	<script src="scripts/send_message.js" type="text/javascript"></script>
	<script src="scripts/repost_message.js" type="text/javascript"></script>
	<script src="scripts/judgeIfSupport.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(document)
				.ready(
						function() {
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
												// ///////////////////////////////////////
												var username;
												var targetNickname = data.returndata.author;
												$
														.ajax({
															type : "post",
															url : "user/getTargetinfo",
															data : {
																nickname : targetNickname
															},
															async : false,  
															dataType : "json",
															success : function(
																	data) {
																$
																		.each(
																				data,
																				function() {
																					username = data.returndata.username;
																				});
															}
														});
												// ////////////////////////////////////////

												$(".timeago")
														.attr(
																"datetime",
																data.returndata.create_time);
												$(".repost")
														.find(".num")
														.text(
																data.returndata.repost_times);
												$(".comment")
														.find(".num")
														.text(
																data.returndata.comment_times);
												$(".support")
														.find(".num")
														.text(
																data.returndata.support_times);
												$(".repostInfo")
														.text(
																data.returndata.content);
												
												$(".userPic a").attr(
														"href",
														"userinfo.jsp?targetNickname="
																+ data.returndata.author);
												
												$(".userPic a img").attr(
														"src",
														"pic/" + username
																+ ".jpg");
												
												$(".weibo_username a")
														.attr(
																"href",
																"userinfo.jsp?targetNickname="
																		+ data.returndata.author);
												$(".weibo_username a").text(
														data.returndata.author);
												judgeIfSupport($.query
														.get("id"), 0);
												$(".timeago").timeago();
											}
										}
									});
						});

		$(".comment").live('click', function() {
			var message_id = $.query.get("id");
			var comtxt = $(".comtxt");
			if (comtxt.css("display") == "none") {
				show_comments(message_id, 1, 1);
				comtxt.slideToggle();
				$(".pageNum").text("1");
			} else {
				comtxt.slideToggle();
			}

		}); // 查看评论

		$(".repost").live('click', function() {
			$(".rpt").slideToggle();
		});

		$(".repost_button").live('click', function() {
			var message_id = $.query.get("id");
			var textarea = ".rptarea";
			var content = $(textarea).val();
			repost_message(content, message_id);
			$(textarea).val("");
		}); // 转发微博

		$(".comment_button").live('click', function() {
			var message_id = $.query.get("id");
			comarea = ".comarea";
			content = $(comarea).val();
			send_comment(message_id, content);
			$(comarea).val(""); // 清空输入框
		}); //发送评论
	</script>
</body>
</html>