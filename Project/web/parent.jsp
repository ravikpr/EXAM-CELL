<%-- 
    Document   : parent
    Created on : 19 Feb, 2016, 12:27:46 PM
    Author     : project
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
    var popup;
    function SelectName() {
        popup = window.open("child.jsp?count=", "Popup", "width=500,height=500");
        popup.focus();
    }
</script>
    </head>
    <body>
        <form action="rooms.jsp">
            <input type="text" id="count" name="count">
            <table border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td>
            Name:&nbsp;
        </td>
        <%
        for(int i=1;i<=25;i++)
        {
        %>
    <tr>
        <td>
            <input type="hidden" id="txtName<%=i%>" name="r" readonly="readonly" /><br>
            
        </td>
    </tr> <%
        
        }
        %>
        <td>
            <input type="button" value="Select Name" onclick="SelectName()" />
        </td>
    </tr>
</table>
        <input type="submit">
        </form>
        <h1>Hello World!</h1>
    </body>
</html>
