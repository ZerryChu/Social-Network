/**
 * 
 */
function logout() {
    $.ajax({
        type: "post",
        url: "user/logout",
        data: { username : $.query.get("username"), userToken : $.query.get("userToken") },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.msg == 1) {
                	var forward = "window.location=\"index.jsp\"";
                	setTimeout(forward, 500);
                } else {
                    //...tell fail
                	alert("fail");
                }
            });
        }
    });
}