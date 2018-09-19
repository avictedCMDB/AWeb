// JavaScript Document
$(document).ready(function(){
	$(".main_visual").hover(function(){
		$("#btn_prev,#btn_next").fadeIn()
	},function(){
		$("#btn_prev,#btn_next").fadeOut()
	});
	$dragBln = false;
	
	$(".main_image").touchSlider({
		flexible : true,
		speed : 300,
		btn_prev : $("#btn_prev"),
		btn_next : $("#btn_next"),
		paging : $(".flicking_con a"),
		counter : function (e){
			$(".flicking_con a").removeClass("on").eq(e.current-1).addClass("on");
		}
	});
	
	$(".main_image").bind("mousedown", function() {
		$dragBln = false;
	});
	
	$(".main_image").bind("dragstart", function() {
		$dragBln = true;
	});
	
	$(".main_image a").click(function(){
		if($dragBln) {
			return false;
		}
	});
	
	timer = setInterval(function(){
		$("#btn_next").click();
	}, 5000);
	
	$(".main_visual").hover(function(){
		clearInterval(timer);
	},function(){
		timer = setInterval(function(){
			$("#btn_next").click();
		},5000);
	});
	
	$(".main_image").bind("touchstart",function(){
		clearInterval(timer);
	}).bind("touchend", function(){
		timer = setInterval(function(){
			$("#btn_next").click();
		}, 5000);
	});
	
});
$(function(){
		$(".search_nav a").mouseenter(function(){
			var $btn_li = $(this).parent();
			$btn_li.addClass("cur").siblings().removeClass("cur");
			var num = $btn_li.index();
			$(".search_main_box").eq(num).show().siblings().hide();
		})
		$("#standard .search_type li a").on("click",function(){
			var $search_type_list =$(this).parent();
			$search_type_list.addClass("cur").siblings().removeClass("cur");
			var num02= $search_type_list.index();
			$("#standard .search_input_box").eq(num02).show().siblings().hide();
        })
		$("#other .search_type li a").on("click",function(){
			var $search_type_list =$(this).parent();
			$search_type_list.addClass("cur").siblings().removeClass("cur");
			var num02= $search_type_list.index();
			$("#other .search_input_box").eq(num02).show().siblings().hide();
        })
	})