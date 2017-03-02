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
                 <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">

        <script>
            var a;
            var b=0;
           
           
        function prnt()
        {
            window.print();
        }
        function save()
        {
            window.close();
        }
        </script>
    </head>
    <body>
        <h1 align="center"> <img name="akgec" src="images\akgec3.png" width="120" height="121" alt="" align="left">AJAY KUMAR GARG ENGINEERING COLLEGE</h1>
    <h2 align="center" >EXAMINATION DUTY ALLOCATION</h2>
    <hr>
        <%
           
             int id =Integer.parseInt(request.getParameter("id"));
             String duty=request.getParameter("duty");
             String type=request.getParameter("type");//invigilation ,floor, flying
             String type2=request.getParameter("type2");//actual or reserved
             String table_name="", table_parameter="";
             

            if(type.equalsIgnoreCase("invigilation")){
             table_name="id_"+id;
             
            }
           /*  if(type.equalsIgnoreCase("flying")){
             table_name="id_flying_"+id;
            
            }
             if(type.equalsIgnoreCase("floor")){
             table_name="id_floor_"+id;
           */else
            {
                table_name="id_"+type+"_"+id;
            }
             if(type2.equalsIgnoreCase("reserve")){
             
             table_parameter=" in('RES')";
            }
            else{
                type2="";
                table_parameter="not in('','RES')";
            }
            
             
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt=con.createStatement();
            
                  //ResultSet rs=stmt.executeQuery("select max(id) from St_Details");
            //rs.next();
            //id=rs.getInt(1);
            String s="select * from St_Details where id="+id;
            System.out.println(s);
            ResultSet rs=stmt.executeQuery(s);
            rs.next();
            String from=rs.getString(2).substring(0,4);
            String to=rs.getString(3).substring(0,4);
            String sem=rs.getString(4);
            String nd = rs.getString(5);
            String exam_type = rs.getString(8);

            int nod=Integer.parseInt(nd);
               
            String Duty_Date[]=new String[nod];
            int nodu[]=new int[nod];
            int i=0;
            rs=stmt.executeQuery("Select * from Duty_Details where id="+id+" order by Duty_Date");
            while(rs.next())
            {
                Duty_Date[i]=rs.getString(2);
                nodu[i]=Integer.parseInt(rs.getString(3));
                i++;
            }
                //query="select ";
String query="select id."+duty+", fa.Faculty_Name, fa.Faculty_Department, fa.Faculty_Phone from "+table_name+" as id, Faculty_Info as fa where id.Faculty_Id=fa.Faculty_Id and "+duty+" "+table_parameter+" order by "+duty;
System.out.println(query);          
rs=stmt.executeQuery(query);  
        %>
        

        <h3 style="text-align: center"> <%=type.toUpperCase()%> <%=type2.toUpperCase()%> DUTY CHART FOR <%=exam_type.toUpperCase()%> EXAM (<%=from%>-<%=to%>)</h2>
        <h3 style="text-align: center">  <%=Duty_Date[Integer.parseInt(duty.substring(4,5))-1]%> SHIFT-<%=duty.substring(8,9)%></h2>
        
        <p style="text-align: right">
        
        <input type="button" value="CLOSE" onclick="save()" >
        <input type="button" value="PRINT" onclick="prnt()">
    </p>
        
        
        <table class="table table-bordered">
            <thead>
                <th>Sr. No.</th>
                <th>DUTY</th>
                <th>FACULTY NAME</th>
                <th>DEPARTMENT</th>
                <th>PHONE</th>
                <th>SIGNATURE</th>
            </thead>
            <%
            i=1;
            while (rs.next())
            {
            %>
            <tr>
                <td><%=i%></td>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td></td>
                
            </tr>
            
            <%
            i++;
            }
            
            %>
            
        </table>    
    <p style="text-align: center">
        NOTE: Reporting 30 minutes before commencement of exams.<br>
        EXAM TIME:<br>
        
    </p>
    </body>
</html>
