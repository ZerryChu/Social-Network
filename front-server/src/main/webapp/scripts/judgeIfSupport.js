/**
 * @author zerrychu
 * @time 2015.10.23
 */
function judgeIfSupport(message_id) {
	$.ajax({
        type: "post",
        url: "message/judge_ifsupport",
        data: { 
        	username : $.query.get("username"),
        	message_id : message_id,
        	userToken : $.query.get("userToken")
        },
        dataType: "json",
        success : function(data) {
            $.each(data,function(){
                if (data.msg == 1) {
                	//可点赞                
                }
                else {
                    //不可点赞
                }
            });
        }
    });
}