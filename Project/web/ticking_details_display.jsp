<%--
    Document   : ticking_details_display
    Created on : 2 Sep, 2015, 5:59:56 PM
    Author     : p
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.xml.crypto.Data"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
           
            function back()
            {
                window.location="ticking_details.jsp";
            }
        </script>
        <style>
            h2{
            color: black;
        margin-left: 100px;
            margin-right: auto;
        }
   input[type="submit"],input[type="button"]
     {
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	background: #F1F5F8;
 	height: 25px;
 	width: 120px;
        margin-top: 30px;
 }  

            form{
                font-weight: 500;
                padding: 10px;
                width: 50%;
                border-radius: 10px;
                border: 2px solid #73AD21;
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
            String from=request.getParameter("session_start_date");
            String to=request.getParameter("session_end_date");
            String semester=request.getParameter("semester");
            String nod=request.getParameter("no_of_days");
            String[] dd=request.getParameterValues("duty_date");
            String[] nodu=request.getParameterValues("number_of_duties");
            String nor=request.getParameter("no_of_rooms");
            String exam_type=request.getParameter("exam_type");
            //String tv=request.getParameter("tick_value");
           int tv=Integer.parseInt(nor);
           tv*=1.25;
           try
           {
            DateFormat dt=new SimpleDateFormat("yyyy-MM-dd");
            Date dt1=(Date)dt.parse(to);
           String message=request.getParameter("message");
            
           }
           catch(Exception e)
           {}
           Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
           Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
        %>
        
        
        <% String msg=null;
        try {
                exam_type=request.getParameter("message").toString();
                
                msg=exam_type;
                if(!exam_type.equals("null"))
                {
                    if(exam_type.equals("st1"))
                    { 
                    
        %>
        <h2>Sessional Tests-1 Exam Schedule</h2>
        <%}
            else if(exam_type.equals("st2"))
           {         
        %>
        <h2>Sessional Tests-2 Exam Schedule</h2>
        <%
    }
else if(exam_type.equals("put"))
     {               
        %>
        <h2>Pre-University Test Exam Schedule</h2>
        <%
}}
}    catch(Exception e)
            {}
        %>
        <form action="ticking_details_save">
        <table>
            <tr>
                <td>FROM</td>
                <td>:</td>
                <td><%=from%></td>
            </tr>
            <tr>
                <td>TO</td>
                <td>:</td>
                <td><%=to%></td>
            </tr>
            <tr>
                <td>SEMESTER</td>
                <td>:</td>
                <td><%=semester%></td>
            </tr>
            
            <tr>
                <td>NUMBER OF DAYS</td>
                <td>:</td>
                <td><%=nod%></td>
            </tr>
            <%
            int j;
            for(j=0;j<Integer.parseInt(nod);j++)
            {
            %>
            <tr>
                <td>DUTY DATE</td>
                <td>:</td>
                <td><%=dd[j]%></td>
                <td>NUMBER OF EXAMS</td>
                <td>:</td>
                <td><%=nodu[j]%></td>
            <input type="hidden" name="dd<%=j%>" id="query" value="<%=dd[j]%>">
            <input type="hidden" name="nodu<%=j%>" id="query" value="<%=nodu[j]%>">
            <input type="hidden" name="exam_type"  value="<%=msg%>">
                   
            </tr>
            
            <%
            }
            %>
            <tr>
                <td>NUMBER OF ROOMS</td>
                <td>:</td>
                <td><%=nor%></td>
            </tr>
            <!--
            TICKING VALUE NOT REQD
            
            <tr>
                <td>TICKING VALUE</td>
                <td>:</td>
                <td>tv value print using jsp</td>
            </tr>
            -->
            
                
                <input type="hidden" name="query" id="query" value="insert into St_Details values('<%=from%>','<%=to%>','<%=semester%>','<%=nod%>','<%=nor%>','<%=tv%>','<%=msg%>',1)">
                <input type="hidden" name="nod" value="<%=nod%>"
                <tr>
                <td><input type="submit" value="SAVE" ></td>
            </form>
            
                <td></td>
                <td><input type="button" value="BACK" onclick="back()"></td>
            </tr>
            
            
            
        </table>
                
    </body>
</html>
