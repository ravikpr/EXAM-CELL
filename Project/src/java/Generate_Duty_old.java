/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Prashant
 */
public class Generate_Duty_old extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
        
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();           
        Statement stmt=con.createStatement();
        ResultSet rs;
        int id=Integer.parseInt(request.getParameter("id"));
        String query="Select Number_Of_Days, Number_Of_Rooms, Ticking_Value from St_details where id='"+id+"'";
        
        rs=stm.executeQuery(query);
        rs.next();
        int no_of_days=Integer.parseInt(rs.getString(1)); 
         int tv_ori=(int)(Integer.parseInt(rs.getString(2))*1.25);
        
        int tv=Integer.parseInt(rs.getString(3)); 
        String duty_dates[]=new String[no_of_days];
        int no_of_duties[]=new int[no_of_days];
        int i=0;
        query="Select Duty_Date,Number_Of_Duties from Duty_Details where id='"+id+"'";
        int total_duties=0; 
        rs=stm.executeQuery(query);
        while(rs.next())
        {
            duty_dates[i]=rs.getString(1);
            no_of_duties[i]=Integer.parseInt(rs.getString(2));
            total_duties+=no_of_duties[i++]; 
         }int j;
        
//64 is the current room number replace accordingly
         
         
        String lists[][]=new String[total_duties][64];
        String floor_lists[][]=new String[total_duties][8];
        int floor_size[]=new int[total_duties];
        int list_size[]=new int[total_duties];
        int k=0;
        for(i=0;i<no_of_days;i++)
         {
           for(j=0;j<no_of_duties[i];j++)
           {
               
               lists[k]=request.getParameterValues("Day_"+(i+1)+"_D_"+(j+1)+"_list");
               
               list_size[k]=Integer.parseInt(request.getParameter("Day_"+(i+1)+"_D_"+(j+1)));
               
               lists[k]=Duty_Allocator.ran_num(lists[k],list_size[k]);
       k++;
               floor_lists[k]=request.getParameterValues("Day_"+(i+1)+"_D_"+(j+1)+"_floor_list");
               floor_size[k]=Integer.parseInt(request.getParameter("Day_"+(i+1)+"_D_"+(j+1)+"floors"));
               
               floor_lists[k]=Duty_Allocator.ran_num(floor_lists[k],floor_size[k]);
           }
         }
         
        /*for(i=0;i<total_duties;i++)
        {
            lists[i]=Duty_Allocator.ran_num(lists[i],list_size[i]);
        }*/
        k=0;
        int m=0;
        String duty,fid;
        
        //APPLYING RESERVES
       rs=stmt.executeQuery("select count(Faculty_Id) from Faculty_Info where Faculty_Department='ASSISTANT PROFESSOR'");
        
        rs.next();
        
        int no_of_faculties=Integer.parseInt(rs.getString(1));
        
        rs=stm.executeQuery("Select count(distinct Faculty_Department) from Faculty_Info where Faculty_Department='ASSISTANT PROFESSOR'");
        rs.next();
        int no_of_dept=rs.getInt(1);
        String dept[]=new String[no_of_dept];
        String dept_ori[]=new String[no_of_dept];
        int no_of_fac[][]=new int[no_of_dept][4];
        //first column is totl faculties...second is total reserve %.....third is total initially ticks generated....fourth is ticks remaining
       System.out.println("testasdfasdasdasdasda");
         rs=stm.executeQuery("Select Faculty_Department, count(Faculty_Id) from Faculty_Info group by Faculty_Department where Faculty_Department='ASSISTANT PROFESSOR'");
        i=0;
        while(rs.next())
                {
                   dept[i]=rs.getString(1);
                   dept_ori[i]=dept[i];
                   no_of_fac[i][0]=rs.getInt(2);
           i++;
                }
        
        //no_of_fac stores total faculty in a dept in one column and reserve applied on basis of floor in seconf column
        int res=0;
        k=0;
        int d,l,count=-1;
        int cal_res=0;
        
        for(i=0;i<no_of_days;i++)
         {
           
           for(j=0;j<no_of_duties[i];j++)
           {
                              System.out.println("asjjndlasdlasldasl");
         
               ++count;
                res=0;
                duty="Day_"+(i+1)+"_D_"+(j+1);
                System.out.println(duty);
                cal_res=tv-list_size[count];
                for(d=0;d<no_of_dept;d++)
                {
                
                        double r=Math.floor(no_of_fac[d][0]*cal_res/(double)no_of_faculties);
                        no_of_fac[d][1]=(int)r;
                        no_of_fac[d][2]=(int)(Math.ceil(no_of_fac[d][0]*tv_ori/(double)no_of_faculties));
                        no_of_fac[d][3]=no_of_fac[d][2]-no_of_fac[d][1];
                        res+=no_of_fac[d][1];
                }
                for(k=0;k<no_of_dept;k++)
                {
                
                    System.out.println("Select Faculty_Id from id_"+id+" where Faculty_Id like '"+dept[k]+"%' and "+duty+"='*'");
                    rs=stm.executeQuery("Select Faculty_Id from id_"+id+" where Faculty_Id like '"+dept[k]+"%' and "+duty+"='*'");
                    System.out.println("NO of fac k,2  "+no_of_fac[k][2]);
                    String fac_id[]=new String[no_of_fac[k][2]];
                    l=0;
                    while(rs.next())
                    {
                        fac_id[l++]=rs.getString(1);                    
                    }
                
                    fac_id=Duty_Allocator.ran_num(fac_id,no_of_fac[k][2]);
                  
                    for(l=0;l<no_of_fac[k][1];l++)
                    {
                        query="update id_"+id+" set "+duty+"='RES' where Faculty_Id='"+fac_id[l]+"'";
               System.out.println(query);
                        stm.executeUpdate(query);
                        
                    }
                }
                ///i dont know
                    int a[]=new int[no_of_dept];
                    for(l=0;l<no_of_dept;l++)
                        a[l]=no_of_fac[l][3];
                    res=cal_res-res;
                    String sort_dept[]=sort(dept,a);
                    
                    //applyning remaining reserves
                    System.out.println("SORTED  "+res+"  "+cal_res);
                    int x=0;
                    System.out.println("/n No-of fac="+no_of_faculties);
                    
                    for(l=0;l<no_of_dept;l++)
                    {
                    System.out.print(no_of_fac[l][0]+"  "+no_of_fac[l][1]+"  "+no_of_fac[l][2]+"  "+no_of_fac[l][3]+"  ");
                    
                    System.out.println();
                    }
                    x=0;
                    for(l=0;l<no_of_dept && x<res;l++)
                    {
                        rs=stm.executeQuery("Select Faculty_Id from id_"+id+" where Faculty_Id like '"+sort_dept[l]+"%' and "+duty+"='*'");
                        int index=search(dept_ori,sort_dept[l]);
 System.out.println("Searched  "+index);                   
                        String fac_id_res[]=new String[no_of_fac[index][3]];
                        int z=0;
                        while(rs.next())
                        {
                        
                            fac_id_res[z]=rs.getString(1);
                            z++;

                        }
                        
                        fac_id_res=Duty_Allocator.ran_num(fac_id_res,fac_id_res.length);
                        stm.executeUpdate("update id_"+id+" set "+duty+"='RES' where Faculty_Id='"+fac_id_res[0]+"'");
                       // no_of_fac[index][3]--;
                        x++;
                    }
                    System.out.println("unknown  ");
                    m=0;
                    String q="Select Faculty_Id from id_"+id+" where "+duty+"='*'";
                        System.out.println(q);
                        
                    rs=stm.executeQuery(q);
                    while(rs.next())
                    {
                        fid=rs.getString(1);
                        query="update id_"+id+" set "+duty+"='"+lists[count][m++]+"' where Faculty_Id='"+fid+"'";
                        System.out.println(query);
                        stmt.executeUpdate(query);
                    }
                    for(m=0;m<no_of_dept;m++)
                        dept[m]=dept_ori[m];
                }
            
        
        }
        query="update St_Details set Exam_Stage = 2 where Id="+id;
        stm.executeUpdate(query);
        response.sendRedirect("duty_display.jsp?id="+id);
        
      }
        catch(Exception e)
        {
            System.out.println("A");
           System.out.println(e.getMessage());
        }
        
    }
    static String[] sort(String dept[],int a[])
    {
        int temp;
        String t;
        for(int i=0;i<dept.length;i++)
        {
            for(int j=0;j<(dept.length-1-i);j++)
            {
                if(a[j]<a[j+1])
                {
                    temp=a[j];
                    a[j]=a[j+1];
                    a[j+1]=temp;
                    t=dept[j];
                    dept[j]=dept[j+1];
                    dept[j+1]=t;
                }
            }
        }
        for(int l=0;l<dept.length;l++)
                    {
                        System.out.print(dept[l]+"  "+a[l]);
                    }
        return dept;
    }
    static int search(String dept[],String d)
    {
        for(int i=0;i<dept.length;i++)
        {
            if(dept[i].equalsIgnoreCase(d))
                return i;
        }
        return 0;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
