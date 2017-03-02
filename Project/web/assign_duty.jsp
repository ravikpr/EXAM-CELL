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
        table {
                 border-collapse: separate;
                 border-spacing: 50px 0;
                 border: black;
                 
        }

        td {
            padding: 10px 0;
            }
        .c1
        {
            align: center;
            margin-left: 100px;
            margin-right: auto;
        }
        body{
           align: center;
        }
    </style>
    
    </head>
    <body>
        <h1 style="text-align: center">ASSIGN DUTY</h1>
                <% 
            try {
                String msg=request.getParameter("message").toString();
                if(!msg.equals("null"))
        %>
        <h1><%= msg %></h1>
        <%
        }
            catch(Exception e)
            {}
        %>
       <!-- <form action="generate_duty.jsp" method="get">
            <table class="c1">
                <tr>
        
                <tr>
                    <td>Session :</td>
                    <td>
                        <select onchange="setdate(this.value)" name="year">
                            <option >SELECT</option>
                                         sirf strting invisible
                                 for(int i=2014;i<2115;i++)
                                    {
                             %>
                                      <option value="=(i+1)%>" >=i%>-=(i+1)%></option>
        
                             
                                    }
                             %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Semester:</td>
                    <td> ODD: <input type="radio" id="semester" name="semester" value="odd"  required>&nbsp&nbsp EVEN: <input type="radio" id="semester" name="semester" value="even" required></td>
                    
                </tr>
                <tr> <td>Exam: </td>
                    <td><select name="exam">
                <option value="st1">ST-1</option>
                <option value="st2">ST-2</option>
                <option value="put">PUT</option>
                <option value="ut">UT</option>
                        </select></td>
            
                </tr>
                <tr><td><input type="submit" value="proceed" >
                    </td>
                    <td><input type="reset" name="reset" value="reset"></td>
                </tr>
            </table>
                        <div id="hide"></div>
        </form>
                        -->
         <%
              Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select *from St_Details where Exam_Stage= 1";
            ResultSet rs=stm.executeQuery(query);
                        
         %>
            <table>
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
            <td style="text-align: center"><input type="button" value="PROCEED" onclick="proceed(<%=id%>)"></td>
        </tr>
        <%
            }          
        %>
                            
            </table>
    </body>
</html>
