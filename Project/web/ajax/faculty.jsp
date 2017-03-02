<%-- 
    Document   : faculty
    Created on : 23 Feb, 2016, 6:11:15 PM
    Author     : p
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%
String name="";
String id="";
String send="";            
try
    {
            String faculty;// =request.getParameter("faculty");
             id=request.getParameter("id");
            String department=request.getParameter("dpt");
             if(!department.equals("SELECT"))
             {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt = con.createStatement();
            ResultSet rs,rst;
            String query;
           
            query="select Faculty_Id from id_"+id+" where Faculty_Id like '"+department+"%'";
            System.out.println(query);
            rs= stm.executeQuery(query);  

           send="<select name='faculty' id='teacher' onchange='shift(this.value)'><option value='SELECT'>SELECT</option>";
            while(rs.next())
                {
                faculty=rs.getString(1);
                query="select Faculty_Name from Faculty_Info where Faculty_Id='"+faculty+"'";
                System.out.println(query);
                rst=stmt.executeQuery(query);
                rst.next();
                name=rst.getString(1);
                 //name=rs.getString(1);
                 
                 send+="<option value='"+faculty+"'>"+name+" ("+faculty+")</option>";
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
//System.out.println(send);        
%>
<%=send%>