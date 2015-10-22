$(document).ready(function(){
	//选项卡
	$(".messages_class li").each(function(index){
		var $this = $(this);
		$this.hover(function(){
			$(this).addClass("hover");
		},function(){
			$(this).removeClass("hover");
		});
		$this.click(function(){
			if(!($(this).hasClass("on"))){
				$(".on").removeClass("on");
				$(this).addClass("on");
			}
		});
	});

	createMes();

	$(".comment").click(function(){
		var box = $(".comtxt");
		var flag = box.find("input");
		if(flag.val() == 0){
			box.slideDown(300,function(){
				flag.val(1);
			});  //向下滑
		}else{
			box.slideUp(300,function(){
				flag.val(0);
			});
		}
	});
	$.ajax({
		url:"",
		dataType:"json",
		type:"GET",
		success:function(data){
			$("#user_icon").attr("src",data.imgurl+"");
			$("#friend_num").val(data.f_num);
			$("message_num").val(data.m_num);
		}
	});
});


function createMes(message,num){
	// for(var i = 0; i <= num; i++){
	// 	var li = $("<li></li>");
	// 	var divWrap = $("<div class=\"weiboinfo\"></div>").appendTo(li);
	// 	var divPic = $("<div class=\"userPic\"></div>").appendTo(divWrap);
	// 	var divmsgBox = $("<div class=\"msgBox\"></div>")appendTo(divWrap);
	// 	var divPic_a = $("<a href="javascript:void(0);"><img/></a>");
	// }
	}