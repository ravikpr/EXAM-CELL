<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
    <div>
        <select onchange="setvalues(this.value)">
            <option value="SELECT">SELECT</option>
        <%
            int id=Integer.parseInt(request.getParameter("id"));
            int day=Integer.parseInt(request.getParameter("day"));
            
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt=con.createStatement();
            ResultSet rs=stmt.executeQuery("Select Number_of_Duties, Shift from Duty_Details where id="+id+" order by Duty_Date");
            int i=1;
            while(rs.next())
            {
            if(i==day)
                {
int nod=Integer.parseInt(rs.getString(1));
String shift=rs.getString(2);
            
for(int k=1;k<=nod;k++)
{
if(shift.indexOf(Integer.toString(k))>=0)
{System.out.println("SHIFT = "+k);
        %>
        <option value="<%=(k)%>"><%=(k)%></option>
        <%
}
}
}
i++;
}
        %>
        </select>
    </div>