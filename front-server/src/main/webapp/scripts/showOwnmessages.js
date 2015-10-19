/**
 *  Created by zhuzirui on 10/13/15.
 */
$(function(username) {
	function showOwnmessages(target) {
		$.ajaxFileUpload({
			url : 'message/show_ownmessages', //用于文件上传的服务器端请求地址
			type : 'post',
			secureuri : false, //是否需要安全协议，一般设置为false
			data : {
				username : target,
			},
			dataType : 'json', //返回值类型 一般设置为json
			success : function(data, status) //服务器成功响应处理函数
			{
				$
				.each(
						data,
						function() {
							var i = 0;
							while (data.returndata[i] != undefined) {
								$(".target_message")
									.append(
											"<li id=\"weibo_"
											+ data.returndata[i].id
											+ "\"><div class=\"weiboinfo\"><div class=\"userPic\"><a href=\"javascript:void(0);\"><img src=\"\" onerror=\"javascript:this.src='images/no_found.png'\"/></a></div><div class=\"msgBox\"><div class=\"username\"><a href=\"javascript:void(0);\">"
											+ data.returndata[i].author
											+ "</a></div><div class=\"txt\">"
											+ data.returndata[i].content
											+ "</div><div class=\"info\"><span class=\"create_time\">"
											+ data.returndata[i].create_time
											+ "</span> <span class=\"repost_times\"></span> <span class=\"support_times\"></span><a href=\"javascript:void(0);\"><span class=\"comment\">评论("
											+ data.returndata[i].comment_times
											+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"repost\">转发("
											+ data.returndata[i].repost_times
											+ ")</span></a><a href=\"javascript:void(0);\"><span class=\"support\">赞("
											+ data.returndata[i].support_times
											+ ")</span></a></div>"
									
									)
							}
						}
					 )
			}
		})
	}
});