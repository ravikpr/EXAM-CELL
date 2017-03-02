<%-- 
    Document   : faculty
    Created on : 23 Feb, 2016, 6:11:15 PM
    Author     : p
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String name="";
            String id="";
 String send="";            
try
{
            
            String faculty =request.getParameter("faculty");
            String id=request.getParameter("id");
             if(!department.equals("SELECT"))
             {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            ResultSet rs;
            String query;
            int nodays;
            query="select Number_Of_Days from St_Details where Id="+id;
            rs.next();
            nodays=Integer.parseInt(rs.getString(1));
            int noduties[]=new int[nodays];
            query="select Number_Of_Duties from Duty_Details where Id="+id;
            rs=stm.
            
            

            query="select * from id_"+id+"  where Faculty_Id='"+faculty+"'";
            rs= stm.executeQuery(query);  
           send="<select name='faculty'>";
            while(rs.next())
                {
                 name=rs.getString(1);
                 id=rs.getString(2);
                 send+="<option value='"+id+"'>"+name+" ("+id+")</option>";
                 }
                 send+="</select>";
            }
            else
            {
            send="";
            }

}
catch(Exception e)
{
System.out.println("Faculty.jsp exception occured : "+e.getMessage());
}
            //out.println(send);
    

System.out.println(send);        
%>
<%=send%>