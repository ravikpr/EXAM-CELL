<%-- 
    Document   : ticking_details
    Created on : 1 Sep, 2015, 10:55:14 PM
    Author     : p
--%>

<%@page import="java.sql.Date"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <script>
        var mindate;
        function setdate(i)
        {
            enddate=i+"-06-30";
            i=i-1;
            mindate=i+"-07-01";
            document.getElementById("hide").innerHTML="<input type='hidden'  name='session_start_date' value="+mindate+"><input type='hidden'  name='session_end_date' value="+enddate+">"
            //j=(i-1);
            
            
            //window.alert(mindate);
            //window.confirm(enddate);
          /*  tv="<td>Ticking value:</td><td><input type='number' id='tick_value' name='tick_value' min='"+nor+"' required></td>";
            document.getElementById("tv").innerHTML=tv;
            document.getElementById("tv").style.marginLeft="103px";
        */}
        function loadto(todate)
        {
            //mindate=todate;
            td="<input type='date' id='session_end_date' name='session_end_date' min='"+mindate+"' required>";
            document.getElementById("td").innerHTML=td;
        }
        function st_dates(nod)
        {//dat="";
            //enddate=document.getElementById("session_end_date").value;
            document.getElementById("dat").innerHTML="";
            dat="";
           for( i=1;i<=nod;i++)
            {
                dat+="<tr><td>Day "+i+"&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<td></td>"+"</td><td>Date: </td><td><input type='date' name='duty_date' id='duty_date' min='"+mindate+"' max='"+enddate+"' required></td></tr><tr><td>&nbsp&nbsp&nbsp&nbsp&nbsp&nbspNo. of Exams:</td><td><input type='number' name='number_of_duties' id='number_of_duties' min ='1' required></td></tr><br>";
           }
           
            document.getElementById("dat").innerHTML=dat;
     document.getElementById("dat").style.marginLeft="103px";
        }
     
            
    </script>
    <style>
        .c1
        {
            border-color: black;
            border-width: 1px;
            align: center;
            margin-left: 100px;
            margin-right: auto;
        }
        table{
            text-align: left;
        }
         input,select
     {
         margin: 4px;
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border-radius: 5px;
	font-size: 0.9em;
	background: #F1F5F8;
 	height: 20px;
 	width: 300px;
 }  
      input[type="radio"]
     {
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	background: #F1F5F8;
 	height: 15px;
 	width: 30px;
 }  
   input[type="submit"],input[type="reset"]
     {
 	border: 1px solid #D7DFE5;
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	background: #F1F5F8;
 	height: 25px;
 	width: 120px;
        margin-top: 30px;
 }  

        body{
           align: center;
        }
        h2{
           
            color: black;
        margin-left: 100px;
            margin-right: auto;
        }
    </style>
    
    </head>
    <body>
       <% String exam_type=null;
            try {
                exam_type=request.getParameter("message").toString();
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
}
            catch(Exception e)
            {
            response.sendRedirect("blank.jsp?message=WARNING: ILLEGAL OPERATION PERFORMED");
            }
        %>
        <form action="ticking_details_display.jsp?message=<%=exam_type%>" method="post">
            <table class="c1">
                <tr>
                    <!--<td>Session :</td>
                    <td><select name="session" id="session" oninput="setdate(this.value)" required>
                            <%
                              //  for(int i=2015 ;i<=3000;i++)
                                //{
                            %><%
                               // }
                            %>
                        </select>
                    </td>
                    <td><div id="chk"></div></td>
                </tr>-->
      
        
                <tr>
                    <td>Session :</td>
                    <td>
                        <select onchange="setdate(this.value)" autofocus>
                             <%             
                                 for(int i=2014;i<2115;i++)
                                    {
                             %>
                                      <option value="<%=(i+1)%>" ><%=i%>-<%=(i+1)%></option>
        
                             <%
                                    }
                             %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Semester:</td>
                    <td> ODD: <input type="radio" id="semester" name="semester" value="odd"  required>&nbsp&nbsp EVEN: <input type="radio" id="semester" name="semester" value="even" required></td>
                    
                </tr>
                <tr>
                    <td>Number Of Days:</td>
                    <td><input type="number" name="no_of_days" id="no_of_days" min="1"  oninput="st_dates(this.value)" required></td>
                    
                </tr>
                </table>
                <table class="c1">
                
                <div id="dat">
                    
                </div>
               <tr>
                    <td>Estimate of number of duties to be allocated:</td>
                    <td><input type="number" id="no_of_rooms" name="no_of_rooms" min="1" oninput="load(this.value)" max=64 placeholder="MAX ROOM NUMBER" required></td>
                </tr>
                
                </table>
        <table class="c1">
                <tr>
                <div id='tv'></div>
                </tr>
                <tr>
                <div id="hide"></div>
                <tr>
                    <td><input type="submit" value="Generate"></td>
                    <td><input type="reset"></td>
                </tr>
            
            </table>
        </form>
    
    </body>
</html>
