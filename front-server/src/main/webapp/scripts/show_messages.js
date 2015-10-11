/**
 * Created by zhuzirui on 10/12/15.
 */
function show_messages() {
    $.ajax({
        type: "post",
        url: "message/show",
        data: { nickname :  (标签id).nickname.value, type : 1, page : .value },
        dataType: "json",
        success : function(data){
            $.each(data,function(){
                if (data.returnmsg.author[0] != null) {



                }else {
                }
            });
        }
    });
}
//{"returnmsg":"[{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05 22:15:13.0"},{"author":"lucy","content":"今天去爬了二龙山，好累啊","create_time":"2015-10-05 22:15:12.0"},null,null,null,null,null,null,null,null]"}