$(function () {
    $('#sub').click(function () {
        var phone=$('#phone').val();
        var url="forget_2.html";
        localStorage.setItem("phone",phone);
        window.location.href=url;
    })
    $('#send').click(function(){
        $('#send').html("<b>60</b>");
        var count=60;
        setInterval(function () {
            count--;
            $("#send").html(	"<b>" + count + "</b>");
        },1000)
    })
})