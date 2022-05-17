var course_id=localStorage.getItem("courseId");
$.ajax({
    type:"post",
    url:"/courses/findweek",
    data:{id:course_id},
    success:function(data) {
        var txt="<ul style=\"margin-left:-31px;width:140px\">"
        var se=data.split('-');
        for(var a=se[0];a<=se[1];a++){
            var add="<li><a class='weeknumber' id='"+a+"'>Week__"+a+"</a></li>";
            txt+=add;
        }
        txt+="</ul>";
        $('#weeknum').html(txt);
    }
})

$.ajax({
    type:"post",
    url:"/courses/getheader",
    data:{cid:course_id},
    success:function (data) {
        var name=data.courseName;
        var address=data.courseAddress;
        var na="课程名："+name+"&nbsp;&nbsp;&nbsp;&nbsp;"+"教学地点："+address;
        $("#class_header").html(na);
    },
    error:function(data){
        alert(data.status);
    }
})

$.ajax({
    type:"post",
    url:"/courses/teacherinfo",
    data:{cid:course_id},
    success:function (data) {
        var len =data.length;
        var txt="";

        for(var index=0;index<len;index++){
            var add="<div class=\"main_con_tea_div\">"+
                "<div class=\"main_con_tea_div_img\"></div>"+
                "<p>教师姓名:<br>"+data[index].teacherName+"</p>"+
                "<p>学院:<br>"+data[index].teacherAcademy+"</p>"+
                "<p>职称:<br>"+data[index].teacherTitle+"</p>"+
                "<p>联系电话:<br>"+data[index].teacherPhonenum+"</p>"+
                "</div>"
            txt+=add;
        }
        txt+="</ul>";
        $('.main_con_tea').html(txt);
        $('.main_con_tea_div').eq(0).css({
            "display":"block"
        });

    },
    error:function(data){
        alert(data.status);
    }
})

window.onload = function () {
    window.setTimeout(function () {
        var s=$(".weeknumber");
        for(var a=0;a<s.length;a++){
            s.eq(a).click(function () {
                var week=this.text.split("__");
                $.ajax({
                    type:"post",
                    url:"/courses/coursedata",
                    data:{cid:course_id,week:week[1]},
                    success:function(data) {
                        $('#sk').html(data.courseOutline);
                        $('#zl').html(data.courseData);
                        $('#zy').html(data.courseHomework);
                    }
                })
            })
        }
    },"500");
}