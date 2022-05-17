
$.ajax({
         type:"GET",
         url:"/courses/stuUserid/weektime",
         dataType:"json",
         data:{stuUserid:"1512190201",weektime:"1"},
         success:function(data) {
             $.each(data, function(idx, obj) {
                 var body=$("#tbody-result");
                 var s=body.children().eq(Number(obj.courseTimestart));
                 var ss=s.children().children().eq(Number(obj.courseWeek));
                 var txt="<a href='#' rel='rs-dialog' data-target='myModal'>"+obj.courseName+"</a>"+"<br>"+obj.courseAddress+"";
                 ss.html(txt);
             });
         }
     })
// $.ajax({
//     type:"get",
//     url:"/courses/stuUserid/weektime",
//     data:{stuUserid:"1512190201",weektime:"1"},
//     success:function(data) {
//         $('#header_name').html(data.stuName);
//         $('.account-name').html(data.stuName);
//
//     }
// })
    $.ajax({
        url: "/courses/getallcourse",
        type: "POST", //GET
        async: true,    //或false,是否异步
        data: {stuUserid: "1512190201"},
        timeout: 5000,    //超时时间
        dataType: "json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success: function (data) {
            var txt="";
            $.each(data, function(idx, obj) {
                txt = txt+"<li class=\"nav2_li\" id="+obj.courseId+">"+obj.courseName+"</li>";
            });
            $('.nav2').html(txt);
        },
        error: function (data) {
            //alert("error:"+data.status);
        },
    });
function CourseMessage(){
	$.ajax({
		url:"/courses/coursedata",
		type:"POST", //GET
		async:true,    //或false,是否异步
		data:{cid:"000001",week:"1"},
		timeout:5000,    //超时时间
		dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
		success:function(data){
			$("#modal-body1").children().html(data.courseOutline);
			$("#modal-body2").children().html(data.courseData);
			$("#modal-body3").children().html(data.courseHomework);
			$("#myModalLabel").html(data.courseName);
		},
		error:function(data){
         //alert("error:"+data.status);
		},
	});
}
function show() {
    console("test");
}
$('#active_a').click(function(){
    if($('.nav2').css("display")=="none"){
        $('.nav2').css("display","block");
    }
    else $('.nav2').css("display","none");
})


window.onload = function () {
    window.setTimeout(function () {
        var lis=$('.nav2_li');
        for(var index =0 ;index<lis.length;index++){
            lis.eq(index).click(function () {
                var url="classinfo_stu.html";
                localStorage.setItem("courseId",this.id);
                window.location.href=url;
            })
        }
    },"500");
}