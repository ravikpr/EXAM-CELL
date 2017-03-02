<%-- 
    Document   : delete_faculty
    Created on : 17 Feb, 2016, 1:17:36 PM
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
                	<link rel="stylesheet" type="text/css" href="all.css">

        <script>
            var a;
            function disp(dpt)
            {
            //window.location="disp_delete_faculty.jsp?department="+dpt;
            //document.getElementById("delet").src="disp_delete_faculty.jsp?department="+dpt;
            if(dpt=="SELECT"){
                
            }
            else
            {/*
                a= new XMLHttpRequest();
                var url="disp_show_faculty.jsp?department="+dpt;
                a.open("GET",url,true);
                a.onreadystatechange=function() {
                if (a.readyState == 4 && a.status == 200) 
                {
                    document.getElementById("fram").innerHTML = a.responseText;
                }
            };
            a.send(null);*/
                document.getElementById("fram").innerHTML="<object type='text/html' data=disp_show_faculty.jsp?department="+dpt+" height=400px width=100%>";
            }
            
           /* a= new XMLHttpRequest();
            var url="disp_delete_faculty.jsp?department="+dpt;
            a.open("GET",url,true);
            a.onreadystatechange=disp1;
            a.send(null);
            */
            }

 
        </script>
        <style>
            body
            {
                overflow-y: hidden;
            }
            object
            {
                display:block;
               // height:200%;
                //width: 100%;
            }
        </style>
    </head>
    <body>
        <h2>SHOW FACULTY</h2>
        <%
        
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            ResultSet rs;
            String query,id,dpt;
            query="select distinct (Faculty_Department) from Faculty_Info";
            rs=stm.executeQuery(query);
        %>
        <P style="text-align: right"><a href="blank.jsp?message=Welcome Back">HOME</a></P>
        SELECT THE DEPARTMENT : <select onchange="disp(this.value)"autofocus>
            <option>SELECT</option>
            <%
            while(rs.next())
            {   
            dpt=rs.getString(1);
            %>
            <option value="<%=dpt%>"><%=dpt%></option>
            <%
            }
            %>
        </select>
        
        
        <div id="fram">
           <!-- <iframe name="delet" src="blank.jsp" id="delet" style="width: 100%; height: 100%"></iframe> -->
        </div>
        
     
    </body>
</html>
