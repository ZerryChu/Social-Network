/**
 * Created by zhuzirui on 10/11/15.
 */
function showUserInfo() {
    $("#logincommit").hide();
    $.ajax({
        type: "post",
        url: "user/getinfo",
        data: { username :  (标签id).username.value },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if () {



                }else {
                }
            });
        }
    });
}
//{"returnmsg":"{"age":20,"habit":"旅游、打各种球、编程","nickname":"zerrychu","type":2}"}