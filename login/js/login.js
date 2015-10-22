$(document).ready(function(){
	// body...
	//回车确认
	// $(document).keydown(function(e){
	// });
	$("input").each(function(index){
		var _this = $(this);
		if(index != 2){
			_this.keydown(function(){
				$(this).next().hide(); //输入隐藏
			}).focus(function(){
				$(this).addClass("onfoc");
				if($(this).val() == ""){
					$(this).next().addClass("cc"); //holder变淡
				}
			}).blur(function(){
				if($(this).val() == ""){
					$(this).next().removeClass("cc").show();
				}
				$(this).removeClass("onfoc");
			});
		}else{
			_this.hover(function(){
				$(this).addClass("btnhov");
			},function(){
				$(this).removeClass("btnhov");
			});
		}
	});

	$(".auto").click(function(){
		var $check = $("#checkbtn");
		if($check.hasClass("click")){
			$check.removeClass("click");
		}else{
			$check.addClass("click");
		}
	})

	// $("#form").validate({
	// 	rules:{
	// 		username:{
	// 			required:true,
	// 			minlength:2,
	// 			maxlength:15
	// 		},
	// 		password:{
	// 			required:true,
	// 			minlength:2,
	// 			maxlength:15
	// 		}
	// 	},
	// 	messages:{
	// 		username:{
	// 			required:"请填写用户名",
	// 			minlength:"最小两位",
	// 			maxlength:""
	// 		},
	// 		password:{
	// 			required:"请填写密码",
	// 			minlength:"",
	// 			maxlength:""
	// 		}
	// 	},
	// 	errorPlacement:function(error, element){
	// 		error.appentTo(element + "~.tip");
	// 	}
	// });
	$("#login").click(function(){
		$.ajax({
			type:"POST",
			url:"login.jsp",
			dataType:"json",
			data:{
				username:$(".username").val(),
				pwd:$(".password").val()
			},
			success:function(data){
				if(data.success){
					location.href = "mainpage.jsp";
				}
			}
		});
	});
});

