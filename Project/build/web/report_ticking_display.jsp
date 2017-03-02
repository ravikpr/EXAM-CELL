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
        <style>
            th{
                text-align: center;
            }
        </style>
    </head>
    <body>
        <h1 align="center"> <img name="akgec" src="images\akgec3.png" width="120" height="121" alt="" align="left">AJAY KUMAR GARG ENGINEERING COLLEGE</h1>
    <h2 align="center" >EXAMINATION DUTY ALLOCATION</h2>
    <hr>
    
        <%
           
             int id =Integer.parseInt(request.getParameter("id"));
             String dpt=request.getParameter("dpt");
             String type=request.getParameter("type");//invigilation ,floor, flying
             String table_name="", table_parameter="";
             if(type.equalsIgnoreCase("INVIGILATION")){
             table_name="id_"+id;
             table_parameter="fi.Faculty_Designation='ASSISTANT PROFESSOR'";
            }
             if(type.equalsIgnoreCase("flying")){
             table_name="id_flying_"+id;
             table_parameter="(fi.Faculty_Designation='PROFESSOR' or fi.Faculty_Designation='ASSOCIATE PROFESSOR')";
            }
             if(type.equalsIgnoreCase("floor")){
             table_name="id_floor_"+id;
             table_parameter="fi.Faculty_Designation='LAB ASSISTANT'";
            }

             
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt=con.createStatement();
            
            //Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm=conn.createStatement();
            ResultSet rst;
            
                  //ResultSet rs=stmt.executeQuery("select max(id) from St_Details");
            //rs.next();
            //id=rs.getInt(1);
            String s="";
            ResultSet rs=stmt.executeQuery("select * from St_Details where id="+id);
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
            
        %>
        

        <h3 style="text-align: center"> <%=type.toUpperCase()%> DUTY CHART FOR <%=exam_type.toUpperCase()%> EXAM (<%=from%>-<%=to%>)</h2>
     
        <p style="text-align: right">
        
        <input type="button" value="CLOSE" onclick="save()" >
        <input type="button" value="PRINT" onclick="prnt()">
    </p>
        
        
        <table align="center" border="3" class="table table-bordered">
            
            <tr>
                <th colspan="3"></th>
            <%
            rs=stmt.executeQuery("select * from id_"+id);
      String query="Select fi.Faculty_Id, fi.Faculty_Name, fi.Faculty_Department";
            ResultSetMetaData metaData = rs.getMetaData();
            
            int columncount=metaData.getColumnCount();
            
            for(i=0;i<nod;i++){
%>
                <th colspan="<%=nodu[i]%>" style="text-align: center"><%=Duty_Date[i]%></th>
            <%
}
             %>
                <th colspan="2"></th>
            </tr>
            <tr>
            <th> FACULTY_ID</th>
            <th> FACULTY_NAME</th>
            <th> DEPARTMENT</th>
                <%
            System.out.println("CHECK");
            int coun=columncount-2;
            for(i=2;i<coun;i++)
            {
                %>
            
                <th><%=metaData.getColumnName(i).substring(6,9) %></th>
                <% query+=", id."+metaData.getColumnName(i); %>
            
            <%
            }
            %>
            <% query+=", id."+metaData.getColumnName(coun); %>
           <th>TICK COUNT</th>
            <th>SIGNATURE</th>
            </thead>
            
            
                <%
            int k=0;
            System.out.println("CHECK123");

            query+=" from Faculty_Info as fi FULL OUTER JOIN "+table_name+" as id ON fi.Faculty_Id=id.Faculty_Id where "+table_parameter+" and fi.Faculty_Department like '"+dpt+"%' order by fi.Faculty_Department";
            System.out.println(query);
            rs=stmt.executeQuery(query);
            System.out.println("CHECK123");
            while(rs.next())
            {
                int j=1;
                k++;
                %>
                <tr>
                <%
                for( i=1;i<=coun+2;i++)
                {   s=rs.getString(i);
                
                    if(i<=3)
                    {
                    
                           
                %>
                <td><%=s %></td>
               <% 
                }
                else if(i==coun+2)
                  {
                %>
                       <td style="text-align: center"><%=s %></td>
                <%
                    }   else if(!s.equalsIgnoreCase(""))//else if(rs.getString(i).equalsIgnoreCase("*"))
                    {
                %>
                       <td style="text-align: center">&#10004;</td>
                <%
                //System.out.println("singhal");
                    j++;
                    }   
                else
                    {
                    
                    //int tikcount=Inteder.parseInt(s);
                %>
                <td style="text-align: center"><%=s%></td>
                <%  j++;
                    }
                }
                %>
                <td></td>
            
                </tr>     
            <%
            }
            
            %>
                       
<tr>
    <td colspan="3" style="text-align: right">COUNT&nbsp;&nbsp;&nbsp;</td>
     <% 
            rs=stmt.executeQuery("select * from id_"+id);
            metaData = rs.getMetaData();
                 for(i=2;i<coun;i++)
            { 
            query = "select count(Faculty_Id) from "+table_name+" where "+metaData.getColumnName(i)+"<>'' and Faculty_Id like '"+dpt+"%'"; 
            System.out.println(query);
            rst=stm.executeQuery(query);
            rst.next();
            int ab=rst.getInt(1);
            System.out.println("count : "+ab);
            
                %>
                <td><%=ab %></td>
            <%
            }
            %>
            <td colspan="2"></td>
    </tr>
                      
    </table>
    
    
    <p style="text-align: center">
        NOTE: Reporting 30 minutes before commencement of exams.<br>
        EXAM TIME:<br>
        
    </p>
    </body>
</html>
