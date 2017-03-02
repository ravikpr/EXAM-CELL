<%-- 
    Document   : assign_duty
    Created on : 18 Feb, 2016, 11:39:36 PM
    Author     : Prashant
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
 	<link rel="stylesheet" type="text/css" href="all.css">

        <script>
        var mindate;
        function setdate(i)
        {
            enddate=i+"-06-30";
            i=i-1;
            mindate=i+"-07-01";
            document.getElementById("hide").innerHTML="";
            document.getElementById("hide").innerHTML="<input type='hidden'  name='session_start_date' value="+mindate+"><input type='hidden'  name='session_end_date' value="+enddate+">"
            //j=(i-1);
            
            
            //window.alert(mindate);
            //window.confirm(enddate);
          /*  tv="<td>Ticking value:</td><td><input type='number' id='tick_value' name='tick_value' min='"+nor+"' required></td>";
            document.getElementById("tv").innerHTML=tv;
            document.getElementById("tv").style.marginLeft="103px";
        */}
   function proceed(id)
   {
       window.open("generate_duty.jsp?id="+id,"_self");
   }
        
            
    </script>
    <style>
         body,table,h2,html
        {
            background-color: floralwhite;
        }
        .c1
        {
            align: center;
            margin-left: 100px;
            margin-right: auto;
        }
        input[type="button"]
        {
            width: 80px;
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
    
    </head>
    <body>
        <h2>ASSIGN DUTY</h2>
                <% 
            try {
                String msg=request.getParameter("message").toString();
                if(!msg.equals("null"))
        %>
        <h2><%= msg %></h2>
        <%
        }
            catch(Exception e)
            {}
        %>
         <%
              Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select *from St_Details where Exam_Stage= 1";
            ResultSet rs=stm.executeQuery(query);
                        
         %>
            <table class="table table-bordered table-hover">
                <col width="100">
                <col width="100">
                <col width="100">
                <col width="100">
                
                
                <thead> 
                    
                    <th>SESSION</th>
                    <th>SEMESTER</th>
                    <th>TYPE OF EXAM</th>
                    <th></th>
                </thead>
        <%
            while(rs.next())
            { 
                int id=rs.getInt(1);
        %>
        <tr>
            
            <td><%=rs.getString(2).substring(0,4)%>-<%=rs.getString(3).substring(0,4)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(8)%></td>
            <td><input type="button" value="PROCEED" onclick="proceed(<%=id%>)"></td>
        </tr>
        <%
            }          
        %>
                            
            </table>
    </body>
</html>
