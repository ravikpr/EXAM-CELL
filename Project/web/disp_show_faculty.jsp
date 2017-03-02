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

    </head>
    <script>
        function popupwindow(url, title, w, h) {
    var left = Math.round((screen.width/2)-(w/2));
    var top = Math.round((screen.height/2)-(h/8));
    return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, '
            + 'menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w 
            + ', height=' + h + ', top=0, left=' + left);
}
  
    function edit(id)
        {
             popup = popupwindow("child_edit_faculty.jsp?id="+id, "Popup", "550","450");
        popup.focus();
        }
        function edit1(id)
        {
            var fid = id;
     $(".modal-body #id").val( fid );
        }
    </script>
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
        input[type="submit"]
        {
            margin-top: 0px;
        }
    </style>
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
         <!--<h2><=dpt%></h2>--> 
         <br>
         <br>
         <table class="table table-bordered table-hover" >
             
             <thead>
             <th>SELECT</th>
             <th>FACULTY ID</th>
             <th>DEPARTMENT</th>
             <th>NAME</th>
             <th>DESIGNATION</th>
             <th>PHONE NUMBER</th>
             <th>GENDER</th>
             <th>E-MAIL ID</th>
             
             </thead>
             <%
            while (rs.next())
            {id=rs.getString(1);
             %>
             
             <tr>
                 <td style="text-align: center"><input type="button" id="edit"  value="Edit" onclick="edit('<%=id%>')" data-toggle="modal" data-target="#myModal"></td>
                 <td style="text-align: center"><%=id%></td>
                 <td style="text-align: center"><%=rs.getString(2)%></td>
                 <td style="text-align: justify"><%=rs.getString(3)%></td>
                 <td style="text-align: center"><%=rs.getString(4)%></td>
                 <td style="text-align: center"><%=rs.getString(5)%></td>
                 <td style="text-align: center">
                     <%  
                     
                     try
                     {
                         if(rs.getString(6).equalsIgnoreCase("M"))
                     {
                     %>
                     MALE
                     <%
                     }
                     else
                     {
                     %>
                     FEMALE
                     <%
                     }
                     }
                     catch(Exception e)
                     {
                         
                     }
                     %>
                 </td>
                 <td style="text-align: center"><%=rs.getString(7)%></td>
             </tr>
             <%
            }
             %>
             
             
             
         </table>
   
    </body>
</html>



