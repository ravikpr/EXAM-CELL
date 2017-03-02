<%-- 
    Document   : update_check
    Created on : 6 Feb, 2016, 10:37:06 PM
    Author     : p
--%>


<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
           // String send=null;
           try{
               
           
            int no =Integer.parseInt(request.getParameter("no"));// number of the check box ticked or unticked
            int id =Integer.parseInt(request.getParameter("id"));//table name
            String fid =request.getParameter("fid");//faculty id
            System.out.println("faculty id ="+fid);
            String dayduty="";
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            String query="select Number_Of_Days from St_Details where Id='"+id+"'";
            System.out.println(query);
            ResultSet rs= stm.executeQuery(query);
            rs.next();
            int nod=rs.getInt(1);
            query="select Number_Of_Duties from Duty_Details where Id='"+id+"'";
            rs= stm.executeQuery(query);
            int nodu=0,i=1,x,j,flag=0;
            while(rs.next()&& flag==0)
                //System.out.println("1234567890");
            {
                x=rs.getInt(1);
                nodu+=x;
                if(no<=nodu)
                {
                    j=(no+x)-nodu;
                    dayduty = "Day_"+i+"_D_"+j;
                    flag=1;
                    
                }
                i++;
            }
            System.out.println("dayduty="+dayduty);
            query="select "+dayduty+" from id_"+id+" where Faculty_Id='"+fid+"'";
            rs=stm.executeQuery(query);
            rs.next();
            String tik=rs.getString(1);
            if(tik.equalsIgnoreCase("*"))
            {
                query="update id_"+id+" set "+dayduty+"='' where Faculty_Id='"+fid+"'";
            }
            else
            {
                query="update id_"+id+" set "+dayduty+"='*' where Faculty_Id='"+fid+"'";
            }        
            System.out.println(query);
            stm.executeUpdate(query);
            
           }
           catch(Exception e)
           {
               System.out.println(e.getMessage());
           }
            
            
          /*  
            String query="select username from login where username='"+str+"'";
            ResultSet rs= stm.executeQuery(query);
            if(rs.next())
                send ="<p style='color:#ff0066'>USERNAME UNAVAILABLE</P> ";
            else
                send ="<p style='color:#99ff99'>USERNAME AVAILABLE</P> ";
            //out.println(send);
            */
%>
