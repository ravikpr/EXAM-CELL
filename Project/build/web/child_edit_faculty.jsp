<%-- 
    Document   : child_edit_facuty
    Created on : 21 Feb, 2016, 4:38:46 PM
    Author     : Prashant
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
        	<link rel="stylesheet" type="text/css" href="all.css">
 
        <script>
            function clos()
            {
                window.close();
            }
        </script>
        <style>
            table{
                
                text-align: left;
            }
            
            form{
                margin-left: 50px;
                border-radius: 0px;
                border: none;
                align: center;
            }
            h2{
               margin-left: 150px 
            }
            h3{
               margin-left: 65px 
            }
        </style>
    </head>
    <body>
        <%
            try
            {
            String s;
            String id=request.getParameter("id");
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            ResultSet rs;
            rs=stm.executeQuery("select * from Faculty_Info where Faculty_Id='"+id+"'");
            rs.next();
            String department=rs.getString(2);
            String name=rs.getString(3);
            String designation=rs.getString(4);
            String phone=rs.getString(5);
            String gender=rs.getString(6);
            String mail=rs.getString(7);
            

            
        %>
        
        <h2>UPDATE FACULTY <br></h2>
        <h3><%=designation+" "%>&nbsp;<%=name%></h3>
        <form action="Update_Faculty">
            <input type="hidden" value="<%=id%>" name="id">
            <table>
                <tr>
                    <td>Faculty Name</td>
                    <td>:</td>
                    <td><input type="text" name="name" value="<%=name%>" required></td>
                </tr>
                
                <tr>
                    <td>Department</td>
                    <td>:</td>
                    <td><input type="text" readonly="readonly" value="<%=department%>" disabled> </td>
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
                            if(s.equalsIgnoreCase(designation))
                            {
                            %>
                            <option value="<%=s%>" selected><%=s%></option>
                            <%
                            }
                            else
                            {
                            %>
                            <option value="<%=s%>"><%=s%></option>
                            <%
                            }
                            }
                            %>
                        </select>
                    </td>
                </tr>
                
                <tr>
                    <td>Phone Number</td>
                    <td>:</td>
                    <td><input type="number" max="9999999999" min="1000000000" name="phone" value="<%=phone%>" required></td>
                </tr>
               
                <tr>
                    <td>Gender</td>
                    <td>:</td>
                    <td>
                        <%
                        //if(gender.equalsIgnoreCase("M"))
                        //{
                        %>
                        <input type="radio"  name="gender" value=M  required>MALE
                        <input type="radio"  name="gender" value=F required>FEMALE
                        <%
                        //}
                       // else
                        //{
                        %>
                       <!-- <input type="radio"  name="gender" value=M  required>MALE
                        <input type="radio"  name="gender" value=F checked required>FEMALE
                        -->
                        <%
                       // }
                        %>
                    </td>
                </tr>
                
                <tr>
                    <td>e-mail</td>
                    <td>:</td>
                    <td><input type="email" name="mail" value="<%=mail%>" required></td>
                </tr>
                
                <tr>
                    <td><input type="reset"></td>
                    <td></td>
                    <td><input type="submit" autofocus ></td>
                    
                </tr>
                
            </table>
        </form>
        <%
            }
            catch(Exception e)
            {
       
            }
        %>
    </body>
</html>
