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
//String name="";
String id="";
String from="";
String duty="";
String to="";

String send="";            
try
{
    
id=request.getParameter("id");
from=request.getParameter("from");
duty=request.getParameter("duty");
to=request.getParameter("to");
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
Statement stm = conn.createStatement();
ResultSet rs;
String query="Select "+duty+" from Id_"+id+" where Faculty_Id='"+from+"'";
System.out.println(query);
rs=stm.executeQuery(query);
rs.next();
String res= rs.getString(1);
query="update Id_"+id+" set "+duty+"='"+res+"' where Faculty_Id='"+to+"'";
System.out.println(query);
stm.executeUpdate(query);
query="update Id_"+id+" set Tick_Count=Tick_Count+1 where Faculty_Id='"+to+"'";

stm.executeUpdate(query);

query="update Id_"+id+" set "+duty+"='' where Faculty_Id='"+from+"'";
stm.executeUpdate(query);
query="update Id_"+id+" set Tick_Count=Tick_Count-1 where Faculty_Id='"+from+"'";

stm.executeUpdate(query);

}
catch(Exception e)
{
System.out.println("ajax/replace_faculty.jsp exception occured : "+e.getMessage());
}
//out.println(send);
//System.out.println(send);        
%>