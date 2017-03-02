<%-- 
    Document   : rooms
    Created on : 20 Feb, 2016, 6:32:41 PM
    Author     : Prashant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Rooms.jsp</h1>
        <%
            String room[]=request.getParameterValues("r");
            int count=Integer.parseInt(request.getParameter("count"));
            for(int i=0;i<count;i++)
            {
                
            
            %>
            <%=room[i]%>
            <%}
            %>
             <br>
             <br>
             <%=count%>
    </body>
</html>
