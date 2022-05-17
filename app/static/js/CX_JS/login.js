switcher_1.onclick=function(){
    login_1.style.display="block";
    login_2.style.display="none";
}
switcher_2.onclick=function(){
    login_2.style.display="block";
    login_1.style.display="none";
}
$(function () {
    $('#login').click(function () {
        $.ajax({
            type:"post",
            url:"/students/login",
            data:{id:$("#uid").val(),pwd:$("#pwd").val()},
            success:function(data) {
                if(data==1){
                    // if(alert($("#uid").val().length)==10){
                        localStorage.setItem("id",$("#uid").val());
                        window.location.href="main.html";
                    // }
                    // else if (alert($("#uid").val().length)==6){

                    // }
                    // else {
                    //     window.location.href="calendar.html";
                    // }
                }
                else $('#login_erro').html("登录失败,帐号或密码错误");
            }
        })
    })
})