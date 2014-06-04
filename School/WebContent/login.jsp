<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	import="edu.tongji.sse.j2ee.bean.*"
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<div id="login">
        <div id="input" style="display: none">
            <div>
                <span>ID:</span>
                <input type="text" name="uID" id="userID" />
            </div>
            <div>
                <span>密码:</span>
                <input type="password" name="uPass" id="userPass" />
            </div>
        </div>
        <div id="btnLogin">
            <span class="clickable">登陆</span>
            <div class="btn clickable">
                <img src="img/sign_login.png" width="20" height="20" title="登录" />
            </div>
        </div>
    <script>
        $("#btnLogin").mouseenter(function(e) {
            $("#input").slideDown();
        });
        $("body").mousemove(function(e) {
            if (!(e.pageY<110 && e.pageX>$(window).width()-240)) {
                $("#input").slideUp();
            }
        });
		$("#login").keypress(function(e) {
            if (e.keyCode == 13)
				$("#btnLogin").click();
        });
		$("#btnLogin").click(function(e) {
			$.post("LoginServlet",{
				uID: $("#userID").val(),
				uPass: $("#userPass").val()
			},function(data,textStatus,jqXHR) {
				if (data=="success") {
					$("#input").slideUp("fast",function() {
						$("#corner").load("userInfor.jsp");
					});
					
					
				}
				else
					alert("Error\nType:\t"+data+"\nID:\t"+$("#userID").val());
			});
        });
    </script>
    </div>
    <script>
	$(".clickable").mouseover(function(e) {
		$(this).css("background-color","#0066CC");
	});
	$(".clickable").mouseout(function(e) {
		$(this).css("background-color","#0066FF");
	});
	$(".clickable").mousedown(function(e) {
		$(this).css("background-color","#00337F");
	});
	$(".clickable").mouseup(function(e) {
		$(this).css("background-color","#0066CC");
	});
	</script>
</body>
</html>