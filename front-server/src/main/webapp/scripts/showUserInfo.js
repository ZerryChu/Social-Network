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
                	$("#nickname").text(data.returndata.nickname);
                	$("#friend_num").text(data.returndata.friend_num);
                	$("#message_num").text(data.returndata.message_num);
                } else {
                	//
                }
            });
        }
    });
}
//{"returnmsg":"{"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}"}