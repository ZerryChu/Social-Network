/**
 * Created by zhuzirui on 10/11/15.
 */
function login() {
    $.ajax({
        type: "post",
        url: "user/login",
        data: { username : logininfo_form.username.value, password : logininfo_form.password.value },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.msg != "0") {
                    //...add content
                	alert("succeed");
                	var forward = "window.location=\"main?username=" + logininfo_form.username.value + "&userToken=" + data.msg + "\"";
                    setTimeout(forward, 2000);
                } else {
                    //...tell fail
                	alert("fail");
                }
            });
        }
    });
}