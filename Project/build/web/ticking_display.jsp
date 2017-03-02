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
        <script>
            var id;
            function inv_cons()
            {
                id=document.getElementById("idd").value;
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=INVIGILATION&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
            function inv_branch(dp)
            {
                id=document.getElementById("idd").value;
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=INVIGILATION&dpt="+dp, "Popup", "width=1100,height=600");
                popup.focus();
            }
            function floor_cons()
            {
                id=document.getElementById("idd").value;
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=floor&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
            function flying_cons()
            {
                id=document.getElementById("idd").value;
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=flying&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
        </script>
        <style>
            h2{
            color: black;
        margin-left: 100px;
            margin-right: auto;
        }
        select
     {
          margin-left: 15px;
 	
         border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
	font-size: 0.9em;
	background: #F1F5F8;
 	height: 25px;
 	width: 200px;
        text-align: center;
 }  
   input[type="button"]
     {
         margin-left: 15px;
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	background: #F1F5F8;
 	height: 25px;
 	width: 200px;
        
 }  
 table{
     margin-left: 100px;
            margin-right: auto;
        
 }

            td{
                padding: 4px;
            }
        </style>
    </head>

    <body>
        <%
String query;
        int id=Integer.parseInt(request.getParameter("id"));
                   Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
ResultSet rs;

        %>
        <input type="hidden" id="idd" value="<%=id%>">
        <h2>Ticking Value Reports</h2>
<table >
            <tr>
                <td>Invigilation Duty (Consolidated)</td>
                <td><input type="button" value="INVIGILATION DUTY" onclick="inv_cons()"></td>
                
            </tr>
            <tr>
                <td>Invigilation Duty (Branch Wise)</td>
                <td>
                    <%
                    query="select distinct (Faculty_Department) from Faculty_Info";
                    rs=stm.executeQuery(query);
                    String dpt;
                    %>
                   
                    <select onchange="inv_branch(this.value)">
                        <option value="SELECT">SELECT</option>
                        <%
                        while(rs.next())
                        {
                        dpt=rs.getString(1);
                        %>
                        <option value="<%=dpt%>"><%=dpt%></option>
                        <%
                        }
                        %>
                </td>
            </tr>
            <tr>
                <td>Flying Duty</td>
                <td><input type="button" value="FLYING DUTY" onclick="flying_cons()"></td>
            </tr>
            <tr>
                <td>Floor Duty</td>
                <td><input type="button" value="FLOOR DUTY" onclick="floor_cons()"></td>
            </tr>
        </table>
    </body>
</html>
