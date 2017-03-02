
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Prashant
 */
public class Generate_Flooring {
 static void flooring(int id, String Day_i_D_j,String floor_lists[], int floor_size,String desi, String table) throws ClassNotFoundException, SQLException
 {
     System.out.println("CHECK POINT FLOORS");
               
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();           
        Statement stmt=con.createStatement();
        ResultSet rs,rst;
        //String shift_no=request.getParameter("shift_no");
        
        
       String query="Select Number_Of_Days from St_details where id="+id+"";
            System.out.println(query);
        rs=stm.executeQuery(query);
        rs.next();
        int no_of_days=Integer.parseInt(rs.getString(1)); 
         int tv_ori=7;
        
        int tv=10; 
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
         
         
        int k=0;
               
       k++;
                          System.out.println("Prashnat:"+ floor_size);
               floor_lists=Duty_Allocator.ran_num(floor_lists,floor_size);

        /*for(i=0;i<total_duties;i++)
        {
            lists[i]=Duty_Allocator.ran_num(lists[i],list_size[i]);
        }*/
        k=0;
        int m=0;
        String duty,fid;
        
        //APPLYING RESERVES
       rs=stmt.executeQuery("select count(Faculty_Id), count(distinct Faculty_Department) from Faculty_Info where "+desi);
    
        rs.next();
        
        int no_of_faculties=rs.getInt(1);
        int no_of_dept=rs.getInt(2);
        
        String dept[]=new String[no_of_dept];
        String dept_ori[]=new String[no_of_dept];
        int no_of_fac[][]=new int[no_of_dept][4];
        
//first column is totl faculties...second is total reserve %.....third is total initially ticks generated....fourth is ticks remaining
       System.out.println("testasdfasdasdasdasda");
       System.out.println("Select Faculty_Department, count(Faculty_Id) from Faculty_Info where "+desi);
         rs=stm.executeQuery("Select Faculty_Department, count(Faculty_Id) from Faculty_Info where "+desi+" group by Faculty_Department");
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
        
        
        
        
        System.out.println("asjjndlasdlasldasl");
         
               ++count;
                res=0;
                duty=Day_i_D_j;
                System.out.println(duty);
                cal_res=tv-floor_size;
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
                
                    System.out.println("Select Faculty_Id from "+table+id+" where Faculty_Id like '"+dept[k]+"%' and "+duty+"='*'");
                    rs=stm.executeQuery("Select Faculty_Id from "+table+id+" where Faculty_Id like '"+dept[k]+"%' and "+duty+"='*'");
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
                        query="update "+table+id+" set "+duty+"='RES' where Faculty_Id='"+fac_id[l]+"'";
               System.out.println(query);
                        stm.executeUpdate(query);
                        stm.executeUpdate("update "+table+id+" set Reserve_Count=Reserve_Count+1 where Faculty_Id='"+fac_id[l]+"'");
                        
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
                   // int x=0;
                    System.out.println("/n No-of fac="+no_of_faculties);
                    
                    for(l=0;l<no_of_dept;l++)
                    {
                    System.out.print(no_of_fac[l][0]+"  "+no_of_fac[l][1]+"  "+no_of_fac[l][2]+"  "+no_of_fac[l][3]+"  ");
                    
                    System.out.println();
                    }
            int x = 0;
                    for(l=0;l<no_of_dept && x<res;l++)
                    {
                        rs=stm.executeQuery("Select Faculty_Id from "+table+id+" where Faculty_Id like '"+sort_dept[l]+"%' and "+duty+"='*'");
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
                        stm.executeUpdate("update "+table+id+" set "+duty+"='RES' where Faculty_Id='"+fac_id_res[0]+"'");
                       // no_of_fac[index][3]--;
                        stm.executeUpdate("update "+table+id+" set Reserve_Count=Reserve_Count+1 where Faculty_Id='"+fac_id_res[0]+"'");
                        
                        x++;
                    }
                    System.out.println("unknown  ");
                    m=0;
                    String q="Select Faculty_Id from "+table+id+" where "+duty+"='*'";
                        System.out.println(q);
                        
                    rs=stm.executeQuery(q);
                    while(rs.next())
                    {
                        fid=rs.getString(1);
                        query="update "+table+id+" set "+duty+"='"+floor_lists[m++]+"' where Faculty_Id='"+fid+"'";
                        System.out.println(query);
                        stmt.executeUpdate(query);
                        stmt.executeUpdate("update "+table+id+" set Duty_Count=Duty_Count+1 where Faculty_Id='"+fid+"'");
                        
                    }
                    for(m=0;m<no_of_dept;m++)
                        dept[m]=dept_ori[m];
        
                    
        
        //response.sendRedirect("duty_display.jsp?id="+id);
        
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
    public void generate(int id, String Day_i_D_j,String floor_lists[], int floor_size) throws ClassNotFoundException, SQLException
    {
        String desi="Faculty_Designation='ASSOCIATE PROFESSOR' or Faculty_Designation='PROFESSOR'";
        String table="id_flying_";
        flooring(id, Day_i_D_j, floor_lists, floor_size,desi,table);
        desi="Faculty_Designation='LAB ASSISTANT'";
        table="id_floor_";
        flooring(id, Day_i_D_j, floor_lists, floor_size, desi, table);
    }

}
