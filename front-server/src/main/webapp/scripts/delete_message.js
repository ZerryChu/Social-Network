/**
 * Created by zhuzirui on 10/12/15.
 */
function delete_message() {
    $.ajax({
        type: "post",
        url: "message/delete",
        data: { 
        	username : $.query.get("username"),
        	userTpken : $.query.get("userToken"),
        	id : 1//change id
        },
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