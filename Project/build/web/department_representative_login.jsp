<%-- 
    Document   : duty_incharge_login
    Created on : 26 Aug, 2015, 11:59:05 PM
    Author     : p
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 align="center"> <img name="akgec" src="images\akgec.jpg" width="250" height="97" alt="" align="left">AJAY KUMAR GARG ENGINEERING COLLEGE</h1>
    <h2 align="center" >EXAMINATION DUTY ALLOCATION PORTAL</h2>
    <hr>
   
        <%
        String uname=null;
        HttpSession splogin=request.getSession(false);
        try
        {
            uname=splogin.getAttribute("type_of_user").toString();
            
        }
        catch(Exception e)
        {
            response.sendRedirect("index.jsp");
        }
       
    %>
        
    <h1>department representative home</h1>
    <h1>welcome <%= ""+uname %>   </h1>
    </body>
</html>
