/**
 * @content 显示用户分组
 */
function showGroups(_flag) {
	$
			.ajax({
				type : "post",
				url : "friend/show/groups",
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					flag : _flag
				},
				dataType : "json",
				success : function(data) {
					$
							.each(
									data,
									function() {
										var i = 0;
										var group = ".group";
										while (data.returndata[i] != undefined) {
											$(group)
													.append(
															"<li id=\"rec_"
																	+ i
																	+ "\"><div class=\"cls\" onclick=\"openFriendList("
																	+ i
																	+ ")\">"
																	+ data.returndata[i]
																	+ "</div><div class=\"friend_list\" style=\"display: none\"></div></li>");
											showFriends(i, data.returndata[i],
													1); // 补充friend_list信息
											i++;
										}
									});
				}
			});
}

/**
 * @content 显示当前分组下的在线好友
 * @param rec_id
 * @param _group
 * @param _flag
 * @param _isShow
 */
function showFriends(rec_id, _group, _flag) {
	$.ajax({
		type : "post",
		url : "friend/show/friends",
		data : {
			username : $.query.get("username"),
			userToken : $.query.get("userToken"),
			groupname : _group,
			flag : _flag
		},
		dataType : "json",
		success : function(data) {
			var i = 0;
			while (data.returndata[i] != undefined) {
				var li = "#rec_" + rec_id + " .friend_list";
				$(li).append(
						"<a target=\"_blank\" style=\"text-decoration: none;\" href=\"privateMsg.jsp?username=" 
						+ $.query.get("username")
						+ "&userToken="
						+ $.query.get("userToken")
						+ "&targetUsername="
						+ data.returndata[i].username
						+ "&targetNickname="
						+ data.returndata[i].nickname
						+ "\"><span class=\"friend\">" + data.returndata[i].nickname
								+ "</span><br></a>");
				i++;
			}
		}
	});
}

function openFriendList(i) {
	var li = "#rec_" + i;
	$(li).find(".friend_list").slideToggle();
}

/**
 * @content show共同好友
 * 
 */
function showCommonFriends(page) {
	$
			.ajax({
				type : "post",
				url : "friend/show/common_friends",
				data : {
					username : $.query.get("username"),
					userToken : $.query.get("userToken"),
					targetUsername : $(".targetUsername div").text()
				},
				dataType : "json",
				success : function(data) {
					page--;
					var i = 0;
					while (data.returndata[i] != undefined) {
						if (i == page * 3) {
							$("#fri1").empty();
							$("#fri1")
									.append(
											"<a href=\"userinfo.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&targetNickname=" + data.returndata[i].nickname + "\"><img src=\"pic/"
													+ data.returndata[i].username
													+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\" style=\"width: 60px; height: 60px;\" style=\"width: 60px; height: 60px;\" title=\""
													+ data.returndata[i].nickname
													+ "\"></a>");
						} else if (i == page * 3 + 1) {
							$("#fri2").empty();
							$("#fri2")
							.append(
									"<a href=\"userinfo.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&targetNickname=" + data.returndata[i].nickname + "\"><img src=\"pic/"
											+ data.returndata[i].username
											+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\" style=\"width: 60px; height: 60px;\" title=\""
											+ data.returndata[i].nickname
											+ "\"></a>");
						} else if (i == page * 3 + 2) {
							$("#fri3").empty();
							$("#fri3")
							.append(
									"<a href=\"userinfo.jsp?username=" + $.query.get("username") + "&userToken=" + $.query.get("userToken") + "&targetNickname=" + data.returndata[i].nickname + "\"><img src=\"pic/"
											+ data.returndata[i].username
											+ ".jpg\" onerror=\"javascript:this.src='images/no_found.png'\" style=\"width: 60px; height: 60px;\" style=\"width: 60px; height: 60px;\" title=\""
											+ data.returndata[i].nickname
											+ "\"></a>");
						}
						i++;
					}
					$(".subtitle span").text(i);
				}
			});
}