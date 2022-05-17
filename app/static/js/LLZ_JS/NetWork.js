//ajax事务与学生绑定
function ajaxBing(affairsId,stu){
    var url='/affairs/'+affairsId;
    $.ajax({
        url:url,
        type:"POST", //GET
        async:true,    //或false,是否异步
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(stu),
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            if(data.code==200){
                location="addSuccess.html";
            }
        },
        error:function(data){
        },
    })
}
//ajax添加一个事务
function ajaxAffairs(info){
    $.ajax({
        url:"/affairs",
        type:"POST", //GET
        async:true,    //或false,是否异步
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(info),
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            if(data.code==200){
                bing(data.data);
            }
        },
        error:function(data){
        },
    })
}
//ajax刷新table里的信息
function ajaxUserInfo(){
    if ($("select").eq(6).val()==""){
        alert("筛选条件不正确！");
        return;
    }
    var url='/students/'+$("select").eq(6).val();
    $.ajax({
        url:url,
        type:"GET", //GET
        async:true,    //或false,是否异步
        data:{
            // stuClass:$("select").eq(6).val()
        },
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            updateStudent(data);
        },
        error:function(data){
            // alert("getStudentsError:"+data.status)
        },
    })
}
//ajax请求学院数据
function ajaxAcademy(){
    $.ajax({
        url:"/academys",
        type:"GET", //GET
        async:true,    //或false,是否异步
        data:{
            //      name:'yang',age:25
        },
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            updateAcademy(data);
        },
        error:function(data){
            // alert("getAcademysError:"+data.status)
        },
    })
}
//ajax根据学院id查询专业
function ajaxMajor(academyId){
    var url='/majors/'+academyId;
    $.ajax({
        url:url,
        type:"GET", //GET
        async:true,    //或false,是否异步
        data:{
            // academyId:academyId
        },
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            updateMajor(data);
        },
        error:function(data){
            // alert("getMajorsError:"+data.status)
        },
    })
}
//ajax根据专业id查询班级
function ajaxClasses(majorId){
    var url ='/classes/'+majorId;
    $.ajax({
        url:url,
        type:"GET", //GET
        async:true,    //或false,是否异步
        data:{
            // majorId:majorId
        },
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            updateClasses(data);
        },
        error:function(data){
            // alert("getClassesError:"+data.status)
        },
    })
}

//ajax根据学生id判断空闲状态
function ajaxStatus(stuUserid) {
    var url='/students/'+stuUserid+'/status';
    $.ajax({
        url:url,
        type:"GET", //GET
        async:true,    //或false,是否异步
        data:{
            weekday:$("select").eq(1).val(),
            start:$("select").eq(2).val(),
            end:$("select").eq(3).val(),
            week:$("select").eq(0).val()
        },
        timeout:5000,    //超时时间
        dataType:"json",    //返回的数据格式：json/xml/html/script/jsonp/text
        success:function(data){
            updateStatus(stuUserid,data);
            // alert(data.data);
        },
        error:function(data){
            // alert("getStudentsError:"+data.status)
        },
    })
}

//动态生成学院列表
function updateAcademy(result){
    var academy=$("select").eq(4);
    for (var i=0;i<result.data.length;i++){
        var $txt = $('<option value='
            +result.data[i].academyId
            +'>'
            +result.data[i].academyName
            +'</option>');
        $(academy).append($txt);
    }

}
//动态生成专业列表
function updateMajor(result){
    var major=$("select").eq(5);
    //删除option所有的兄弟
    $(major).children().remove();
    $(major).append($('<option value="">请选择</option>'));
    //生成与学院相对应的专业
    for (var i=0;i<result.data.length;i++){
        var $txt = $('<option value='
            +result.data[i].majorId
            +'>'
            +result.data[i].majorName
            +'</option>');
        $(major).append($txt);
    }
    //动态生成班级列表
    ajaxClasses($("select").eq(5).val());

}
//动态生成班级列表
function updateClasses(result){
    var classes=$("select").eq(6);
    //删除option所有的兄弟
    $(classes).children().remove();
    $(classes).append($('<option value="">请选择</option>'));
    //生成与专业相对应的班级
    for (var i=0;i<result.data.length;i++){
        var $txt = $('<option value='
            +result.data[i].classesId
            +'>'
            +result.data[i].classesName
            +'</option>');
        $(classes).append($txt);
    }

}
//动态生成学生信息列表
function updateStudent(result){
    var body=$("tbody");
    //删除tbody里所有的兄弟
    $(body).children().remove();
    //无数据拦截
    if(result.data.length<1){
        $(body).append($('<tr class="warning"><td colspan="100%">无数据，请重新选择筛选条件！</td></tr>)'));
        return;
    }
    for (var i=0;i<result.data.length;i++){
        var $txt = $('<tr onclick="changeState(this)">'
            +'<td>'+result.data[i].stuAcademy+'</td>'
            +'<td>'+result.data[i].stuClass+'</td>'
            +'<td>'+result.data[i].stuName+'</td>'
            +'<td>'+result.data[i].stuUserid+'</td>'
            +'<td>'+result.data[i].stuPhonenum+'</td>'
            +'<td><img src="img/LLZ_IMG/LLZdefault32.png"></td>'
            +'</tr>');
        $(body).append($txt);
    }
    //刷新状态
    for (var i=0;i<result.data.length;i++){
        ajaxStatus(result.data[i].stuUserid);
    }
}
//刷新状态
function updateStatus(stuUserid, result) {
    var body=$("tbody");
    var trs=$(body).children();
    for (var i=0;i<trs.length;i++){
        var tds=$(trs).eq(i);
        //如果id相同
        if(stuUserid==$(tds).children().eq(3).text()){
            //如果没空
            if(result.data==0){
                $(tds).addClass("danger");//添加危险属性
                $(tds).removeAttr("onclick");//移除点击事件
                $(tds).children().find("img").attr("src","img/LLZ_IMG/LLZyellow32.png");//更换图片
            }else {
                $(tds).children().find("img").attr("src","img/LLZ_IMG/LLZgreen32.png");
            }
        }
    }

}