<%-- 
    Document   : leave_assign_form_1
    Created on : 23 Feb, 2016, 5:34:30 PM
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
            var b=0;
            var id,department1,faculty1;
            var send1,send2,send3,send4;
            function setid(ide){
               // window.alert(ide);
              
               document.getElementById("faculty").innerHTML="";
               document.getElementById("shift").innerHTML="";
               document.getElementById("rep").innerHTML="";
              // document.getElementById("exam").disabled=true;
              id=ide;
              send1=id;
                document.getElementById("udit").disabled=false;
               document.getElementById("replace_from").style.visibility="visible";
            }
            
            function facl(dpt,div)
            {
                document.getElementById(div).innerHTML="";
               document.getElementById("shift").innerHTML="";
               //document.getElementById("udit").disabled=true;
               // window.alert("fac called");
                department1=dpt;
                //window.alert("check ajax");
            a= new XMLHttpRequest();
            var url="ajax/faculty.jsp?dpt="+department1+"&id="+id;
            a.open("GET",url,true);
            a.onreadystatechange=function() {
    if (a.readyState == 4 && a.status == 200) {
      document.getElementById(div).innerHTML = a.responseText;
    }
  };
            a.send(null);
           //indow.alert("facl ended");
   }  
       function shift(fid){
            //document.getElementById("shift").innerHTML="";
            //window.alert("shift called");
            document.getElementById("teacher").disabled=true;
            document.getElementById("shift").innerHTML = "";
            faculty1=fid;
            send2=fid;
             a= new XMLHttpRequest();
            var url="ajax/shift.jsp?id="+id+"&faculty="+fid;
            a.open("GET",url,true);
            a.onreadystatechange=function() {
    if (a.readyState == 4 && a.status == 200) {
      document.getElementById("shift").innerHTML = a.responseText;
    }
  };
            a.send(null);
            //window.alert("shift end");
        }
        function replace(duty){
            //window.alert("replace called duty = "+duty);
            var cb=document.getElementById("shift_"+duty);
            if(cb.checked)
            {cb.disabled=true;
                send3=duty;
              //  window.alert("replace called duty = "+duty);
            a= new XMLHttpRequest();
            var url="ajax/replace.jsp?id="+id+"&duty="+duty;
            a.open("GET",url,true);
            a.onreadystatechange=function() {
    if (a.readyState == 4 && a.status == 200) {
      document.getElementById("rep").innerHTML =a.responseText;
    }
  };
            a.send(null);
        }
        else
        {
           
            d="div_"+duty;
            // window.alert("relpace else part called divsion = "+d);
            document.getElementById(d).innerHTML="waiting";
            //window.alert("relpace else part called divsion = "+d);
        }
            
            
        }
        function fac1(dp,di,duty1)//dp=new department and di= dividion for faculty
        {
            //window.alert("fac1 called /n duty = "+duty1+" /n division = "+di+" /n department = "+dp);
            a= new XMLHttpRequest();
            var url="ajax/faculty1.jsp?id="+id+"&duty="+duty1+"&dpt="+dp;
            //window.alert(url);
            a.open("GET",url,true);
            a.onreadystatechange=function() {
    if (a.readyState == 4 && a.status == 200) {
      document.getElementById(di).innerHTML = a.responseText;
    }
  };
            a.send(null);
        }
        function proceed(to){
            send4=to;
            document.getElementById("btn").disabled=false;
           // window.alert("FACULTY SELECTED WAS "+to);
        }
        function execute(){
            //window.alert(send1);
            //window.alert(send2);
            //window.alert(send3);
            //window.alert(send4);
            //send1= exam id
            //send2= faculty to be replaced from
            //send3= duty
            //send4= faculty to be replaced by
                
            a= new XMLHttpRequest();
            var url="ajax/replace_faculty.jsp?id="+send1+"&from="+send2+"&duty="+send3+"&to="+send4;
            //window.alert(url);
            a.open("GET",url,true);
            a.onreadystatechange=function() {
                if (a.readyState == 4 && a.status == 200) {
                    
                    //document.getElementById("btn").disabled=true;
                    document.getElementById("rep").innerHTML="<h2>SUCESSFUL REPLACEMENT</h2>";
                    //document.getElementById("hp").disabled=true;
                    //document.getElementById("faclty").disabled=true;
                    window.alert("SUCESSFUL UPDATION");
                }
            };
            a.send(null);
            
            
        }
        </script>
        <style>
        body,table,h2,html
        {
            background-color: floralwhite;
        }
           
        input[type="button"]
        {
            margin-top: 0px;
        }
        </style>
            
    </head>
    <body>
        
        
        <%
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select * from St_Details where Exam_Stage= 1";
            ResultSet rs=stm.executeQuery(query);
            
        %>
        <h2>ASSIGN LEAVE</h2>
        
         <table class="table table-bordered table-hover">
                   
                    <th>SESSION</th>
                    <th>SEMESTER</th>
                    <th>TYPE OF EXAM</th>
                    <th></th>
        <%
            while(rs.next())
            { 
                int id=rs.getInt(1);
        %>
        <tr>
            
            <td><%=rs.getString(2).substring(0,4)%>-<%=rs.getString(3).substring(0,4)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(8)%></td>
            <td><input type="radio" id="exam" name="exam" value="<%=id%>" onclick="setid(this.value)"></td>
        </tr>
        <%
            }          
        %>
                            
        
    </table>
         <%
         query="select distinct (Faculty_Department) from Faculty_Info";
            rs=stm.executeQuery(query);
            String dpt;
        %>
       
        <div id="replace_from" style="visibility: hidden" >
        
        <table>
            <tr>
                <TD>DEPARTMENT</TD>
                <td>:</td>
                <td><select id="udit" disabled onchange="facl(this.value,'faculty')" autofocus required>
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
                    </select>
                </td>
            </tr>
            <tr>
                <td>FACULTY NAME</td>
                <td>:</td>
                <TD><div id="faculty"></div></TD>
            </tr>
            <tr>
                
                <TD>SHIFT</TD>
                <td>:</td>
                <td><div id="shift"></div></td>
            
            </tr>
         
            <tr>
                <td><a href="leave_assign_form_1.jsp"><input type="button" value="RESET"></a></td>
                
            </tr>
            
        </table>
                     <%
         query="select distinct (Faculty_Department) from Faculty_Info";
            rs=stm.executeQuery(query);
            
        %>
                    
            
       
        </div>
        
        <div id="rep">
            
            
        </div>
        
         
    </body>
</html>
