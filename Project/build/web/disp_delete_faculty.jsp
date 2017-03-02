<%-- 
    Document   : disp
    Created on : 17 Feb, 2016, 2:54:18 PM
    Author     : p
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
 	<link rel="stylesheet" type="text/css" href="all.css">
        <style>
            body,table,h2,html
        {
            background-color: floralwhite;
        }
        input[type="button"]
        {
            width: 50px;
            margin-top: 0px;
            margin-left: 0px;
        }
        th{
            text-align: center;
        }
        form{
                            width: 100%;
                border-radius: 0px;
                border: 0px;
                margin-left: 0px;
    
            }
        </style>
    </head>
    <body>
       <%
            String id="";
            String dpt =request.getParameter("department");
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select * from Faculty_Info where Faculty_Department='"+dpt+"' order by Faculty_Id";
            ResultSet rs= stm.executeQuery(query);
         %>
           <form action="delete_faculty" method="GET">
         <table class="table table-bordered table-hover" >
             
             <thead>
             <th>SELECT</th>
             <th>FACULTY ID</th>
             <th>DEPARTMENT</th>
             <th>NAME</th>
             <th>DESIGNATION</th>
             <th>PHONE NUMBER</th>
             </thead>
             <%
            while (rs.next())
            {id=rs.getString(1);
             %>
             
             <tr>
                 <td style="text-align: center"><input type="checkbox" id="del" name="del" value="<%=id%>"></td>
                 <td style="text-align: center"><%=id%></td>
                 <td style="text-align: center"><%=rs.getString(2)%></td>
                 <td style="text-align: justify"><%=rs.getString(3)%></td>
                 <td style="text-align: center"><%=rs.getString(4)%></td>
                 <td style="text-align: center"><%=rs.getString(5)%></td>
             </tr>
             <%
            }
             %>
            <tr>
                <td colspan="6" style="text-align: left"><input type="submit" value="DELETE"></td>
             </tr>
             
             
         </table>
    </form>
    </body>
</html>



