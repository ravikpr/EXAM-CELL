<%-- 
    Document   : add_faculty
    Created on : 15 Feb, 2016, 10:57:31 PM
    Author     : p
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        	<link rel="stylesheet" type="text/css" href="all.css">

        <script>
            function warn()
            {
                window.alert("WARNING: ALL THE UN-FINIDHED EXEMS WILL BE DELETED");
                
            }
            </script>
    </head>
    <body onload="warn()">
        <%
        
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            ResultSet rs;
            String s;
            //System.out.println("1234");
            try
            {
        %>
        <form action="Save_Faculty">
            <table>
                <tr>
                    <td>Faculty Name</td>
                    <td>:</td>
                    <td><input type="text" name="name" required></td>
                </tr>
                
                <tr>
                    <td>Department</td>
                    <td>:</td>
                    <td><select name="department">
                            <%
            System.out.println("567");
                            rs=stm.executeQuery("SELECT DISTINCT Faculty_Department FROM Faculty_Info");
                            
                            while(rs.next())
                            {s=rs.getString(1);
                                System.out.println("1234567");
                            %>
                            <option value="<%=s%>"><%=s%></option>
                            <%
                            }
                            %>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Designation</td>
                    <td>:</td>
                    <td><select name="designation">
                            
                            <%
                            System.out.println("udit");
                            rs=stm.executeQuery("SELECT DISTINCT Faculty_Designation FROM Faculty_Info");
                            while(rs.next())
                            {s=rs.getString(1);
                            %>
                            <option value="<%=s%>"><%=s%></option>
                            <%
                            }
                            %>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Phone Number</td>
                    <td>:</td>
                    <td><input type="number" max="9999999999" min="1000000000" name="phone" required></td>
                </tr>
               
                <tr>
                    <td>Gender</td>
                    <td>:</td>
                    <td><input type="radio"  name="gender" value=M required>MALE<input type="radio"  name="gender" value=F required>FEMALE</td>
                </tr>
                
                <tr>
                    <td>e-mail</td>
                    <td>:</td>
                    <td><input type="email" name="mail" required></td>
                </tr>
                
                <tr>
                    <td><input type="reset"></td>
                    <td></td>
                    <td><input type="submit"></td>
                    
                </tr>
                
            </table>
        </form>
                        <%
            }
            catch(Exception e)
            {
                System.out.println(e.getMessage());
            }
                        %>
    </body>
</html>
