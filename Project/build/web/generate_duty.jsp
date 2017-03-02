<%-- 
    Document   : generate_duty
    Created on : 18 Feb, 2016, 11:50:28 PM
    Author     : Prashant
--%>

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
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
 	<link rel="stylesheet" type="text/css" href="all.css">
        <style>
            body{
                background-color: floralwhite;
            }
            input[type="submit"],input[type="button"]
            {
                padding: 0px;
                margin-left: 0px;
                margin-top: 0px;
            }
        </style>
        <script type="text/javascript">
    var popup,popu;
    function popupwindow(url, title, w, h) {
    var left = Math.round((screen.width/2)-(w/2));
    var top = Math.round((screen.height/2)-(h/2));
    return window.open(url, title, 'toolbar=no, location=no, directories=no, status=no, '
            + 'menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w 
            + ', height=' + h + ', top=0, left=' + left);
}
    function SelectName(tv,duty) {
        popup = popupwindow("child.jsp?tv="+tv+"&duty="+duty, "Popup", "800","600");
        popup.focus();
    }
    function GenerateRoom(duty_date,shift,duty) {
        popu = popupwindow("Generate_Duty_New?duty_date="+duty_date+"&shift="+shift+"&duty="+duty, "Popup", "800","600");
        popu.focus();
    }
        </script>
    </head>
    <body>
        <h2>GENERATE DUTY</h2>
       <%
           int id=0;
           try
           {
            id=Integer.parseInt(request.getParameter("id"));
           
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String  query= "select * from St_details where Id="+id;
            ResultSet rs=stm.executeQuery(query);
            String mindate, maxdate, exam, semester, year;
           rs.next();
           mindate=rs.getString(2);//request.getParameter("session_start_date");
           maxdate=rs.getString(3);//request.getParameter("session_end_date");
           semester=rs.getString(4);//request.getParameter("semester");
           exam=rs.getString(8);//request.getParameter("exam");
           
           year=maxdate.substring(0,4);//request.getParameter("year");
           int y=Integer.parseInt(year);
           
           
       %> 
       <table class="table table-hover">
           <tr>
               <td>SESSION</td>
               <td>:</td>
               <td><%=(y-1)%>-<%=y%></td>
           </tr>
         
           <tr>
               <td>EXAM</td>
               <td>:</td>
               <td><%=exam.toUpperCase()%></td>
           </tr>
           <%
           id=0;
           
        System.out.println(mindate+"        "+ maxdate+"     ");
        query="Select Id, Number_Of_Days, Number_Of_Rooms from St_details where Session_From='"+mindate+"' and Session_To='"+maxdate+"' and semester='"+semester+"' and Exam_type='"+exam+"'";
        
        rs=stm.executeQuery(query);
        rs.next();
        id=rs.getInt(1);
        int no_of_days=Integer.parseInt(rs.getString(2)); 
         int tv=Integer.parseInt(rs.getString(3));
         System.out.println(tv);
          
                 System.out.println("testasdf"); 
         String duty_dates[]=new String[no_of_days];
         int no_of_duties[]=new int[no_of_days];
         int i=0;
         query="Select Duty_Date,Number_Of_Duties from Duty_Details where id='"+id+"'";
         
         rs=stm.executeQuery(query);
         
         while(rs.next())
         {
             duty_dates[i]=rs.getString(1);
             no_of_duties[i++]=Integer.parseInt(rs.getString(2));
             
         }int j;
         System.out.println("test5");
         for(i=0;i<no_of_days;i++)
         {
             
             query="Select Shift from Duty_Details where Duty_Date='"+duty_dates[i]+"' and Id="+id;
                   rs=stm.executeQuery(query);
                   System.out.println("Generate DDuty: query="+query);
                   rs.next();
                   String d=rs.getString(1);
                   System.out.println("value="+d);
                   
           %>
           
           <tr>
          
               <td rowspan="<%=no_of_duties[i]%>">DAY-<%=i+1%>&nbsp;<%=duty_dates[i]%></td>
               <% for(j=0;j<no_of_duties[i];j++)
               {%>
           <form action="Generate_Duty_N" method="post">
               <td> SHIFT-<%=j+1%></td>
               <%
               System.out.println("askjdals"+d.indexOf(Integer.toString(j+1)));
                   if(d.indexOf(Integer.toString(j+1))>=0)
                   {
                      System.out.println(d.indexOf(Integer.toString(j+1))); 
                           
               
               %>
               
               <td> <input type="text" disabled name="Day_<%=i+1%>_D_<%=j+1%>"  id="Day_<%=i+1%>_D_<%=j+1%>" value="Duty has been been alocated">
                   <%-- <td> <input type="button" value="Select Room(s)" disabled>
               <td> <input type="button" value="Generated" disabled>
                   --%>
                <%
                   }
                   else
                   {
                   %>
               <td> <input type="text" readonly="readonly" name="Day_<%=i+1%>_D_<%=j+1%>"  id="Day_<%=i+1%>_D_<%=j+1%>" required >
               <td> <input type="button" value="Select Room(s)" onclick="SelectName(<%=tv%>,'Day_<%=i+1%>_D_<%=j+1%>')">
               <td> <input type="submit" value="Generate" id="Day_<%=i+1%>_D_<%=j+1%>_gen"  disabled>
               <td><input type="hidden" name="id" value="<%=id%>"></td>
               <td><input type="hidden" name="shift_no" value="<%=j+1%>"></td>
              <td><input type="hidden" name="duty_date" value="<%=duty_dates[i]%>"></td>
               <td><input type="hidden" name="duty" value="Day_<%=i+1%>_D_<%=j+1%>"></td>
                <%
                   }
               %>
               <td> <input type="hidden" readonly="readonly" name="Day_<%=i+1%>_D_<%=j+1%>_floors" id="Day_<%=i+1%>_D_<%=j+1%>_floors" required>    
 
                   <%
                   int k;
        for(k=1;k<=64;k++)
        {
        %>
               <td> <input type="hidden" id="Day_<%=i+1%>_D_<%=j+1%>_<%=k%>" name="Day_<%=i+1%>_D_<%=j+1%>_list" readonly="readonly" /><br>
               </td>
                   <%
        
        }
        for(k=1;k<=8;k++)
        {
            %>
            <td> <input type="hidden"  id="Day_<%=i+1%>_D_<%=j+1%>_floor_<%=k%>" name="Day_<%=i+1%>_D_<%=j+1%>_floor_list" readonly="readonly"/><br>
            </td>
            <%
        }
        %>
           
           </tr>
           <tr>
                         </form>

               <%}%>
            </tr> 
                       
     <% }
           }
           catch(Exception e)
           {
               System.out.println(e.getMessage());
           }
      %>
      
       </table>
      
       </body>
</html>
