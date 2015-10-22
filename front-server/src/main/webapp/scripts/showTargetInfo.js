/**
 * Created by zhuzirui on 10/11/15.
 */
function showTargetInfo() {
	$.ajax({
        type: "post",
        url: "user/getTargetinfo",
        data: { nickname : $.query.get("targetNickname") },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.returndata != null) {
                	$(".targetNickname div").text(data.returndata.nickname);
                	$(".targetUsername div").text(data.returndata.username);
                	$(".friend_num div").text(data.returndata.friend_num);
                	$(".message_num div").text(data.returndata.message_num);
                	$(".age div").text(data.returndata.age);
                	$(".habit div").text(data.returndata.habit);
            		$("img").attr("src", "pic/" + data.returndata.username + ".jpg");
                } else {
                	$(".targetUsername div").text("null");
                	$(".targetNickname div").text("null");
                	$(".friend_num div").text("0");
                	$(".message_num div").text("0");
                	$(".age div").text("0");
                	$(".habit div").text("null");
                	//
                }
            });
        }
    });
}
//{"returnmsg":"{"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}"}