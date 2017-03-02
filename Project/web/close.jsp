<%-- 
    Document   : blank
    Created on : 11 Feb, 2016, 2:21:31 PM
    Author     : p
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function clos()
            {
                window.close();
            }
        </script>
        
    </head>
    <body>
        <%
            String st=null;
            try
            {
                 st= request.getParameter("message");
            
            
            if(!st.equals(null))
             {   
        %>
        <h2 style="text-align: center"> <%=st%><br><input type="button" value="CLOSE WINDOW" onclick="clos()" autofocus></h2>
        <%
        }
            }
            catch(Exception e)
            {
                
            }
        %>
    </body>
</html>
