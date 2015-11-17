/**
 * Created by zhuzirui on 10/11/15.
 */
function showTargetInfo(_flag) {
	$.ajax({
        type: "post",
        url: "user/getTargetinfo",
        data: { nickname : $.query.get("targetNickname"), flag : _flag },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.returndata != null) {
                	$(".targetNickname div").text($.query.get("targetNickname"));
                	$(".targetUsername div").text(data.returndata.username);
                	$(".friend_num div").text(data.returndata.friend_num);
                	$(".message_num div").text(data.returndata.message_num);
                	$(".age div").text(data.returndata.age);
                	$(".habit div").text(data.returndata.habit);
            		$("img").attr("src", "pic/" + data.returndata.username + ".jpg");
            		judgeIfFriend($(".targetUsername div").text(), 0); //判断是否可以点赞
                } else {
                	$(".targetUsername div").text($.query.get("targetNickname"));
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
