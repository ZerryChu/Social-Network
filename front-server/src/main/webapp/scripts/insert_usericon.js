/**
 * Created by zhuzirui on 10/13/15.
 */

function ajaxFileUpload() {
	$.ajaxFileUpload({
		url : 'user/insert_icon', //用于文件上传的服务器端请求地址
		type : 'post',
		secureuri : false, //是否需要安全协议，一般设置为false
		data : {
			username : $.query.get("username"),
			userTpken : $.query.get("userToken"),
		},
		fileElementId : 'file', //文件上传域的ID
		dataType : 'json', //返回值类型 一般设置为json
		success : function(data, status) //服务器成功响应处理函数
		{
			$("#upload_success").show();
			if (typeof (data.error) != 'undefined') {
				if (data.error != '') {
					alert(data.error);
				} else {
					alert(data.msg);
				}
			}
		},
		error : function(data, status, e)//服务器响应失败处理函数
		{
			alert(e);
		}
	})
}