function validate() {
    var pwd1 = $('#newpwd').val();
    var pwd2 = $('#sure_newpwd').val();
    if (pwd1 == pwd2) {
        $('#tip').html("两次密码相同");
        document.getElementById("tip").style.color = "green";
        document.getElementById("sub").style.backgroundColor = "rgb(40,40,40)";
    }
    else {
        $('#tip').html("两次密码不同");
        document.getElementById("sub").style.backgroundColor = "grey";
        document.getElementById("tip").style.color = "red";
    }
}
$(function () {
    $('#sub').click(function () {
        var phone=localStorage.getItem("phone");
        $.ajax({
            type:"post",
            url:"/students/forget",
            data:{phone:phone,pwd:$("#newpwd").val()},
            success:function(data) {
                if(data==1)alert("修改成功！");

            }
        })
    })
})