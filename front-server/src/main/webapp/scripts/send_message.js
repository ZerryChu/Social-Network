/**
 * Created by zhuzirui on 10/12/15.
 */
function login() {
    $.ajax({
        type: "post",
        url: "user/login",
        data: { username :  , content : .content.value, type : 1 },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.msg == 1) {
                    //...add content
                    setTimeout("window.location='user/main'",2000);
                }else {
                    //...tell fail
                }
            });
        }
    });
}