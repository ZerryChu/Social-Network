/**
 * 
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
													0); // 补充friend_list信息
											i++;
										}
									});
				}
			});
}

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
				$(li).append("<span class=\"friend\">" + data.returndata[i] + "</span><br>");
				i++;
			}
		}
	});
}

function openFriendList(i) {
	var li = "#rec_" + i;
	$(li).find(".friend_list").slideToggle();
}
