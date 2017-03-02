<%-- 
    Document   : newjsp
    Created on : 24 Feb, 2016, 2:51:04 PM
    Author     : p
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
String duty,id,query;
duty=request.getParameter("duty");
id=request.getParameter("id");
query="select distinct (Faculty_Department) from Faculty_info";
Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
Statement stm = conn.createStatement();
ResultSet rs=stm.executeQuery(query);
String dpt;
    
    %>
    <div id="div_<%=duty%>">    
        <h3>REPLACE BY:- </h3>
        <table>
            <tr>
                <td>DEPARTMENT</td>
                <td>:</td>
                <td>
                    <select id="hp" onchange="fac1(this.value,'faculty_<%=duty%>','<%=duty%>')" autofocus required>
                        <option value="SELECT">SELECT</option>
                        <%
                        while(rs.next())
                        {
                        dpt=rs.getString(1);
                        %>
                        <option value="<%=dpt%>"><%=dpt%></option>
                        <%
                        }
                        %>
                    </select>
                </td>
            </tr>
            <tr>
            <td>FACULTY</td>
            <td>:</td>
            <td><div id="faculty_<%=duty%>"></div></td>
            </tr>
            <tr>
                <td><input type="button" id="btn" value="REPLACE" onclick="execute()" disabled></td>
            </tr>
        </table>
    </div>
