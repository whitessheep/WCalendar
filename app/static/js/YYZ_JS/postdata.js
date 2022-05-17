function ajaxpost(){  
var f = document.userinfo;  
var uname = f.username.value;  
var uschool = f.school.value;  
var uinfo = f.selfinfo.value;  
var xmlhttp  
  
if (window.XMLHttpRequest){  
    // code for IE7+, Firefox, Chrome, Opera, Safari  
    xmlhttp=new XMLHttpRequest();  
}else{  
    // code for IE6, IE5  
    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");  
}  
xmlhttp.onreadystatechange=function(){  
    if (xmlhttp.readyState==4 && xmlhttp.status==200){  
        var obj = eval('('+xmlhttp.responseText+')');  
        alert('姓名:'+obj.uname+'学校:'+obj.uschool+'个人简介:'+obj.uinfo);  
    }  
}  
xmlhttp.open("post","index1.php",true);  
/*  
发送post请求时此句万万不能少  
在Form元素的语法中，EncType表明提交数据的格式  
用 Enctype 属性指定将数据回发到服务器时浏览器使用的编码类型。  
application/x-www-form-urlencoded：窗体数据被编码为名称/值对。这是标准的编码格式。  
multipart/form-data：窗体数据被编码为一条消息，页上的每个控件对应消息中的一个部分。  
text/plain：窗体数据以纯文本形式进行编码，其中不含任何控件或格式字符  
*/  
xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");  
xmlhttp.send('uname='+uname+'&uschool='+uschool+'&uinfo='+uinfo);  
} 