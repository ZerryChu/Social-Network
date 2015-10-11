/**
 * Created by zhuzirui on 10/12/15.
 */
function showUserInfo() {
    $.ajax({
        type: "post",
        url: "user/getinfo",
        data: { username :  (标签id).username.value id : .value},
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.msg == 1) {



                }else {

                }
            });
        }
    });
}