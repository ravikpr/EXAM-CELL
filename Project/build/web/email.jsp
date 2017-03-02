<%-- 
    Document   : email
    Created on : 3 Mar, 2016, 3:44:20 PM
    Author     : p
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
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
    var a;        
    var id;
    function emal(dp)
            {
                a= new XMLHttpRequest();
            var url="report_ticking_display.jsp?id="+id+"&type=INVIGILATION&dpt="+dp;
           
            //window.alert(url);
            a.open("GET",url,true);
            a.onreadystatechange=function() {
    if (a.readyState == 4 && a.status == 200) {
        
      document.getElementById("message").value = a.responseText;
     
      document.getElementById("department").value = dp;
        document.getElementById("submit").disabled = false;
        
      //window.alert("done");
    }
  };
            a.send(null);
                
            }
            
            function setid(idd)
            {
               
                id=idd;
                document.getElementById("branch").style.visibility = visible;
            }
    
        </script>
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
            form{
                border: 0px;
            }

        </style>
    </head>
    <body>
        
        <%
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select * from St_Details where Exam_Stage= 1 ";
            ResultSet rs=stm.executeQuery(query);
            
        %>
        <h2>SEND E-MAIL</h2>
        
        <table class="table table-bordered table-hover">
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
            
            <td style="text-align: center"><%=rs.getString(2).substring(0,4)%>-<%=rs.getString(3).substring(0,4)%></td>
            <td style="text-align: center"><%=rs.getString(4)%></td>
            <td style="text-align: center"><%=rs.getString(8)%></td>
            <td style="text-align: center"><input type="radio" id="exam" name="exam" value="<%=id%>" onclick="setid(this.value)"></td>
        </tr>
        <%
            }          
        %>
                            
    </table>
        <div id="branch" style="visibility: visible">
        <%
       // String id=request.getParameter("id");
             query ="select distinct(Faculty_Department) from Faculty_Info";
             rs=stm.executeQuery(query);
        %>
        <form action="email" method="post" >
            Department:&nbsp;&nbsp;<select name="dpt" onchange="emal(this.value)">
                <option>SELECT</option>
        <%
        
            while (rs.next())
            {
            String dpt=rs.getString(1);
%>
<option value="<%=dpt%>"><%=dpt%></option>
             
        <%
                
            }
        %>
        </select>
        <input type="hidden" id="message" name="message" >
        <input type="hidden" id="department" name="dpt" >
        
        <!--<input type="button" value="prepare E-MAIL ()" onclick="emal('','')">-->
        <input type="submit" id="submit" value="SEND" disabled>
        <br>
  </form>
        </div>
    </body>
</html>
