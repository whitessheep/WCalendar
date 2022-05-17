//全局变量
	var $txt = $("<p>提示框出错</p>");//txt为提示的具体内容
//预加载
$(document).ready(function(){
	//固定导航栏
//	var navoffset = $("#nav").offset().top;//nav至顶部的偏移量
	$(window).scroll(function(){
		var scrollPos=$(window).scrollTop();
		if(scrollPos>45){
			$("#nav").addClass("navfixed");
		}else{
			$("#nav").removeClass("navfixed");
		}
	})
	
	//ajax请求学院数据
	ajaxAcademy();
	//监听列表框
	observe();
})
//监听列表框
function observe() {
    $("select").eq(4).change(function(){
    	ajaxMajor($("select").eq(4).val());
	});
    $("select").eq(5).change(function(){
        ajaxClasses($("select").eq(5).val());
    });
}
//改变表格中列的颜色
function changeState(me){
	if(me.getAttribute("class")=="success"){
		me.setAttribute("class","");
	}else{
		me.setAttribute("class","success");
	}	
}
//全选
function selectAll(){
	var trs = document.getElementsByTagName("tr");
	for (var i=0;i<trs.length;i++) {
		if(trs[i].getAttribute("onclick")){
			trs[i].setAttribute("class","success");
		}
	}
}
//全不选
function selectNone(){
	var trs = document.getElementsByTagName("tr");
	for (var i=0;i<trs.length;i++) {
		if(trs[i].getAttribute("onclick")){
			trs[i].setAttribute("class","");
		}
	}
}
//添加学生
function addStu(){
	//被选中的行
	var $selected = $(".success");
	for (var i=0;i<$($selected).length;i++) {
			//被选中行的后辈元素数组
			var $childrens = $($selected[i]).children();
			var $txt = $("<a href='#' class='list-group-item'>"
					        +"<h4 class='list-group-item-heading'>"
					        	+$($childrens[3]).text()
					        	+"<button type='button' class='btn btn-default btn-danger' onclick='delStu(this)'>删除</button>"
					    		+"</h4>"
				    			+"</a>");
			$("#stuTpl").after($txt);		    
	}
	//取消选中的学生状态
	selectNone();
	//提示框
	showAlert("add",$($selected).length);
}
//删除学生
function delStu(me){
	var $parent = $(me).parent().parent();
	//删除
	$parent.remove();
	//提示
	showAlert("del",1);
}

//提示框
function showAlert(opt,num){
	
	if(opt == "add"){
		$txt = $("<div class='alert alert-dismissable alert-info'>"
		    +"<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>"
			+"<h4>提示</h4>你已成功添加"
			+num
			+"位学生"
			+"</div>");
	}else if(opt == "del"){
		$txt = $("<div class='alert alert-dismissable alert-danger'>"
		    +"<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>×</button>"
			+"<h4>提示</h4>你已成功删除"
			+num
			+"位学生"
			+"</div>");
	}
	//插入HTML
	$("#tips").after($txt);
	//2秒后自动消失
	setTimeout("delSelf($txt)",2000);
}
//删除自己及所有后代元素
function delSelf(me){
	$(me).remove();
}
//验证事务信息
function validate(){
	var str ="时间：";
	//添加时间信息
	for(var i=0;i<$("select").length;i++){
		switch(i){
			case 0:	
				str+="第"+$("select").eq(0).val()+"周；";
				break;
			case 1:	
				str+="周"+$("select").eq(1).val()+"；";
				break;
			case 2:	
				str+="第"+$("select").eq(2).val()+"节~";
				break;
			case 3:	
				str+="第"+$("select").eq(3).val()+"节；";
				break;				
			default:
				break;
		}
	}
	//添加学生信息
	str+="学生：";
	var $bro=$("#stuTpl").nextAll();
	for (var j=0;j<$($bro).length;j++) {
		str+=$($bro).eq(j).text()+"、";
	}
	str=str.replace(/删除/g,"");
	
	//添加事务说明
    str+="地点：";
    str+=$("textarea").eq(0).val();
	str+="；事务简介：";
	str+=$("textarea").eq(1).val();

	$("#validateText").text(str);
}
//即将发布事务
function publish(){
    var info = {
        "affairsName":$("textarea").eq(1).val(),
        "affairsTimestart":parseInt($("select").eq(2).val()),
        "affairsTimeend":parseInt($("select").eq(3).val()),
        "affairsCreaterid":"admin",
        "affairsAddress":$("textarea").eq(0).val(),
        "affairsIntroduction":$("textarea").eq(1).val(),
        "affairsWeek":parseInt($("select").eq(0).val()),
        "affairsWeekstart":parseInt($("select").eq(1).val()),
        "affairsWeekend":parseInt($("select").eq(1).val())
    };
    ajaxAffairs(info);
}
//事务与学生绑定，并且跳转至成功界面
function bing(affairsId) {
    var stu =[];
    var bro=$("#stuTpl").nextAll();
    for (var j=0;j<$(bro).length;j++) {
        var str=$(bro).eq(j).text();
        str=str.replace(/删除/g,"");
        stu.push(str);
    }
    ajaxBing(affairsId,stu);
}