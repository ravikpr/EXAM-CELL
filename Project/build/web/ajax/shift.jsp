<%-- 
    Document   : newjsp
    Created on : 24 Feb, 2016, 11:46:14 AM
    Author     : p
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
       // try
         //   {
            String name="";
            String id="";
            String send="";   
            
            String faculty =request.getParameter("faculty");
             id=request.getParameter("id");
             if(!faculty.equals("SELECT"))
             {
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            ResultSet rs;
            String query;
            int nodays;
            query="select Number_Of_Days from St_Details where Id="+id;
            
System.out.println(query);
rs= stm.executeQuery(query);
rs.next();
            nodays=Integer.parseInt(rs.getString(1));
            int noduties[]=new int[nodays];
            String date[]=new String[nodays];
            query="select Number_Of_Duties, Duty_Date from Duty_Details where Id="+id+" order by Duty_Date";
            rs= stm.executeQuery(query);
            int i=0;
            while(rs.next())
            {
            noduties[i]=Integer.parseInt(rs.getString(1));
            System.out.println("number of duties "+i+"  value="+noduties[i]);
            date[i]=rs.getString(2);
            i++;
            }
            query="select * from Id_"+id+" where Faculty_Id='"+faculty+"'";
System.out.println(query);
            rs= stm.executeQuery(query);
            rs.next();
            String duty,value;
int k=2;
            for(i=1;i<=nodays;i++)
            {
                for(int j=1;j<=noduties[i-1];j++)
                    {
                    duty="Day_"+i+"_D_"+j;

                    value=rs.getString(k);
System.out.println("VALUE : "+value+"     DUTY = "+duty);
//System.out.println("DUTY : "+duty);
                    k++;
                    if(value.equals("*"))
                       {System.out.println("DUTY : "+duty);
%>
<input type="checkbox" name="shift" id="shift_<%=duty%>" value="<%=duty%>" onclick="replace(this.value)"><%=date[i-1]%> -SHIFT<%=j%><br>
<%
                        }
                        else{}

                    
                    }
            }
}
/*}
catch(Exception e)
{
System.out.println("ajsx/shift.jsp exception occured : "+e.getMessage());
}

*/
%>