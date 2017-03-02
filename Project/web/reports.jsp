<%-- 
    Document   : reports
    Created on : 26 Feb, 2016, 12:13:08 PM
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
            var id,a,day,shif,duty;
            function setvalues(shi){
                shif=shi;
                duty="Day_"+day+"_D_"+shif;
                document.getElementById("udii").style.visibility="visible";
            }
            
        function actual(type,type2)
            {
                url="report_duty.jsp?id="+id+"&duty="+duty+"&type="+type+"&type2="+type2;
                popup = window.open(url, "Popup", "width=1100,height=600");
                popup.focus();
            }
            

            function setid(ide)
            {
                id=ide;
                document.getElementById("disp").style.visibility="visible";
                a= new XMLHttpRequest();
                var url="ajax/duty_date.jsp?id="+id;
                a.open("GET",url,true);
                a.onreadystatechange=function() {
                    if (a.readyState == 4 && a.status == 200) {
                        document.getElementById("duty_date").innerHTML = a.responseText;
                    }
                };
                a.send(null);
            }
            
            function shift(da)
            {   if(da!=="SELECT")
                {
                day=da;
              //  window.alert("shift "+da);
                a= new XMLHttpRequest();
                var url="ajax/duty_shift.jsp?id="+id+"&day="+day;
            //    window.alert(url);
                a.open("GET",url,true);
                a.onreadystatechange=function() {
                    if (a.readyState == 4 && a.status == 200) {
                        //window.alert("shift "+da);
                        document.getElementById("shift_div").style.visibility="visible";
                        document.getElementById("duty_shift").innerHTML = a.responseText;
                    }
                };
                a.send(null);
            }
            }
            function inv_cons()
            {
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=INVIGILATION&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
            function inv_branch(dp)
            {
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=INVIGILATION&dpt="+dp, "Popup", "width=1100,height=600");
                popup.focus();
            }
            function floor_cons()
            {
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=floor&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
            function flying_cons()
            {
                 popup = window.open("report_ticking_display.jsp?id="+id+"&type=flying&dpt=", "Popup", "width=1100,height=600");
                popup.focus();
            }
        </script>
    </head>
    <body>
               
                
        <%
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select * from St_Details where Exam_Stage= 1 ";
            ResultSet rs=stm.executeQuery(query);
            
        %>
        <h2>REPORTS</h1>
        
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
        <div id="disp" style="visibility: hidden">
        <table>
            <tr>
                <td><h3>TICKING VALUE REPORTS</h3></td>
            </tr>
            <tr>
                <td>Invigilation Duty (Consolidated)&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
                <table>
                    <tr>
                        <td colspan="3">
                            <h3>ACTUAL DUTY</h3>
                        </td>
                    </tr>
                    <tr>
                        <td>Duty Date:&nbsp;&nbsp;<div style="float: right" id="duty_date"></div></td>
                        <td><div style="float: right; visibility: hidden" id="shift_div">Shift:</div></td>
                        <td><div style="float: left" id="duty_shift"></div></td>
                        
                    </tr>
                    <div id="udii" style="visibility: hidden">       
                    <tr>
                
                <td>Invigilation Duty</td>
                <td><input type="button" value="INVIGILATION DUTY" onclick="actual('invigilation','actual')">&nbsp;&nbsp;</td>
                <td><input type="button" value="INVIGILATION DUTY RESERVE" onclick="actual('invigilation','reserve')"></td>
                    </tr>
                    <tr>
                <td>Flying Duty</td>
                <td><input type="button" value="FLYING DUTY" onclick="actual('flying','actual')">&nbsp;&nbsp;</td>
                <td><input type="button" value="FLYING DUTY RESERVE" onclick="actual('flying','reserve')"></td>
                    </tr>
                    <tr>
                <td>Floor Duty</td>
                <td><input type="button" value="FLOOR DUTY" onclick="actual('floor','actual')">&nbsp;&nbsp;</td>
                <td><input type="button" value="FLOOR DUTY RESERVE" onclick="actual('floor','reserve')"></td>
                    </tr>
                 </div>
                </table>
        </div>
    </body>
</html>
