<%-- 
    Document   : home
    Created on : 3 Aug, 2015, 5:02:08 PM
    Author     : p
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
	<title>Duty Allocation System</title>
	<link rel="stylesheet" type="text/css" href="style.css">
	<script type="text/javascript" src="js/modernizr.custom.28468.js"></script>
	
</head>
<body>
    <div id="header"><img name="akgec" src="images\akgec3.png" width="120" height="121" alt="" align="left"><h3>Ajay Kumar Garg Engineering College</h3>
	<h2>Examination Duty Allocation</h2></div>
	<div id="menu">....
			<!--		<a href="#login" class="item" id="s1">LOGIN</a>
	<a href="#history" class="item">HISTORY</a>
			<a href="#" class="item">NOTICE</a>
			<a href="#" class="item">USERS</a>		
	--></div>
	<div id="login">
	<h3>LOGIN</h3>
        <form action="validate">
				<table align="center">
                                    <tr><td><b>Name: </td><td><input type="text" name="userid"></td></tr>
					<tr><td><b>Password: </td><td><input type="password" name="pass"></td></tr>
					<tr><td></td><td><input type="submit" value="Login"></td></tr>
				</table>			
			</form>
    </div>
   	<!--<div id="history">
   	<h3>HISTORY</h3>
   		<ul align="center">
   			<li id="view_all">VIEW ALL</li>
   			<li class="hist"><a href="#">ST</a></li>
   			<li class="hist"><a href="#">PUT</a></li>
   			<li class="hist"><a href="#">UT</a></li>
   		</ul>
   		<div class="clear">   			
   		</div>
   		<table align="center" id="view_hist">
   			<tr><td><a href="images/port.jpg" ><img src="images/port.jpg" class="view"></a></td><td><a href="images/port.jpg" ><img src="images/port.jpg" class="view"></a</td>
   			<td><a href="images/port.jpg" ><img src="images/port.jpg" class="view"></a</td></tr>
   		</table>
   	</div>-->
</body>
</html>