<%-- 
    Document   : ticking_display
    Created on : 9 Sep, 2015, 2:26:57 AM
    Author     : p
--%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
 	<link rel="stylesheet" type="text/css" href="all.css">
        <style>
            body{
                background-color: floralwhite;
                
            }
            input[type="button"]
            {
                margin-top: 0px;
                padding: 0px;
                margin-left: 0px;
                width: 200px;
            }
            th{
                text-align: center;
            }
            td{
                margin-top: 0px;
                margin-left: 0px;
            
                }
            select{
                margin-top: 0px;
                margin-left: 0px;
                width: 200px;
            }
        </style>
      
        <script>
            
            function actual(id,duty,type,type2)
            {
                url="report_duty.jsp?id="+id+"&duty="+duty+"&type="+type+"&type2="+type2;
                popup = window.open(url, "Popup", "width=1100,height=600");
                popup.focus();
            }

        </script>
    </head>
    <body>  
        <%
        String id=request.getParameter("id");
        String duty=request.getParameter("duty");

        %>
        
        <table class="">
                    <tr>
                        <td colspan="3">
                            <h2 style="text-align: center">ACTUAL DUTY</h2>
                        </td>
                    </tr>
                    <tr>
                        <td><div id="duty_date"></div></td>
                        <td></td>
                        <td><div id="duty_shift"></div></td>
                        
                    </tr>
                    <div id="udii" style="visibility: hidden">       
                    <tr>
                
                <td>INVIGILATION DUTY</td>
                <td><input type="button" value="INVIGILATION DUTY" onclick="actual('<%=id%>','<%=duty%>','invigilation','actual')"></td>
                <td><input type="button" value="INVIGILATION DUTY RESERVE" onclick="actual('<%=id%>','<%=duty%>','invigilation','reserve')"></td>
                    </tr>
                    <tr>
                <td>FLYING DUTY</td>
                <td><input type="button" value="FLYING DUTY" onclick="actual('<%=id%>','<%=duty%>','flying','actual')"></td>
                <td><input type="button" value="FLYING DUTY RESERVE" onclick="actual('<%=id%>','<%=duty%>','flying','reserve')"></td>
                    </tr>
                    <tr>
                <td>FLOOR DUTY</td>
                <td><input type="button" value="FLOOR DUTY" onclick="actual('<%=id%>','<%=duty%>','floor','actual')"></td>
                <td><input type="button" value="FLOOR DUTY RESERVE" onclick="actual('<%=id%>','<%=duty%>','floor','reserve')"></td>
                    </tr>
                 </div>
                </table>
    </body>
</html>
