<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
    <div>
        <select onchange="shift(this.value)">
            <option value="SELECT">SELECT</option>
        <%
            int id=Integer.parseInt(request.getParameter("id"));
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("Select Duty_Date from Duty_Details where id="+id+" order by Duty_Date");
            int i=0;
            while(rs.next())
            {
            i++;

        %>
        <option value="<%=(i)%>"><%=rs.getString(1)%></option>
        
        <%
        }
        %>
        </select>
    </div>