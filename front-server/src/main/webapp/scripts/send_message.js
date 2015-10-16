/**
 * Created by zhuzirui on 10/12/15.
 */
function send_message() {
    $.ajax({
        type: "post",
        url: "message/send",
        data: {
        	username : $.query.get("username"),
			userToken : $.query.get("userToken"), 
			content : message_toSend.content.value,
			type : message_toSend.type.value.value 
		},
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.msg == 1) {
                    //...add content
                    alert("succeed.");
                }else {
                    //...tell fail
                	alert("fail.");
                }
            });
        }
    });
}