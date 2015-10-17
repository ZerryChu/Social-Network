/**
 * Created by zhuzirui on 10/11/15.
 */
function showUserInfo() {
	$.ajax({
        type: "post",
        url: "user/getinfo",
        data: { username : $.query.get("username") },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.returndata != null) {
                	$(".nickname").text(data.returndata.nickname);
                	$("#friend_num").text("好友：" + data.returndata.friend_num);
                	$("#message_num").text("广播：" + data.returndata.message_num);
                } else {
                	$(".nickname").text("null");
                	$("#friend_num").text("好友：0");
                	$("#message_num").text("广播：0");
                	//
                }
            });
        }
    });
}
//{"returnmsg":"{"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}"}