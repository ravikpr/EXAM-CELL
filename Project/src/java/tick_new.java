
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
 * @author p
 */
public class tick_new {
    public int ticking()throws ClassNotFoundException, SQLException
    {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
  
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stmt=con.createStatement();
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();
        ResultSet rs=stm.executeQuery("select max(id)from St_Details");

		//id is for table name generation
		
		int id=0;
        rs.next();
        id=rs.getInt(1);

        int[] nums=null; 
      
        int i,j;
        
        rs=stmt.executeQuery("select Ticking_Value,Number_Of_Days from St_Details where id='"+id+"'");
        rs.next();
 
        int no_of_rooms=Integer.parseInt(rs.getString(1));
        int no_of_days=Integer.parseInt(rs.getString(2));
         
        String duty_dates[]=new String[no_of_days];
        int duty_counts[]=new int[no_of_days];
        
        rs=stmt.executeQuery("select * from Duty_Details where Id='"+id+"' order by Duty_Date");
       
	   // System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
        
	for(i=0;i<=no_of_days && rs.next();i++)
        {   
            duty_dates[i]=(rs.getString(2));
            duty_counts[i]=Integer.parseInt(rs.getString(3));
        }
        
	rs=stmt.executeQuery("select count(Faculty_Id) from Faculty_Info where Faculty_Designation='ASSISTANT PROFESSOR'");
        rs.next();
        int no_of_faculties=Integer.parseInt(rs.getString(1));
        System.out.println("no of facilties:"+no_of_faculties);
//Creating farji tables query
        String table_query="create table id_"+id+"(Faculty_Id varchar(50)";
        for(i=0;i<no_of_days;i++)
            for(j=0;j<duty_counts[i];j++)
                table_query+=", Day_"+(i+1)+"_D_"+(j+1)+" varchar(50)";
        table_query+=", Tick_Count int, Duty_Count int, Reserve_Count int)";
        table_query=table_query.replace("-","_");
        stmt.executeUpdate(table_query);
        System.out.println(table_query);
        
//ticking
        System.out.println("ticking start");
        ResultSet rst=stmt.executeQuery("select Faculty_Id from Faculty_info where Faculty_Designation='ASSISTANT PROFESSOR'");
        System.out.println("CHECK POIONT");
        String fa_query;
        while(rst.next())
        {
            fa_query="";
            fa_query+="insert into id_"+id+" values('"+rst.getString(1)+"'";
            for(i=0;i<no_of_days;i++)
                for(j=0;j<duty_counts[i];j++)
                    fa_query+=",''";
            fa_query+=",0,0,0)";
            System.out.println(fa_query);
            stm.executeUpdate(fa_query);
        }
        
        System.out.println("CHECK POIONT");
        System.out.println("successful insertion");
        int z=0;
		
        //COUNTING NUMBER OF FACULTIES IN  paRTICULAR DEPARTMENT
        rst=stm.executeQuery("Select count(distinct Faculty_Department) from Faculty_Info where Faculty_Designation='ASSISTANT PROFESSOR'");
        rst.next();
        int no_of_dept=rst.getInt(1);
        String dept[]=new String[no_of_dept];
        int no_of_fac[][]=new int[no_of_dept][2];
        
        rst=stm.executeQuery("Select Faculty_Department, count(Faculty_Id) from Faculty_Info where Faculty_Designation='ASSISTANT PROFESSOR' group by Faculty_Department");
        i=0;
        while(rst.next())
        {
            dept[i]=rst.getString(1);
            no_of_fac[i][0]=rst.getInt(2);
            double r=Math.ceil(no_of_fac[i][0]*no_of_rooms/(double)no_of_faculties);
            no_of_fac[i][1]=(int)r;
            System.out.println(r+"   "+ dept[i]);
            i++;
        }
        



// GENERATION
        int k,l;
        String fac_id[];
        for(k=0;k<no_of_dept;k++)
        {
            rs=stm.executeQuery("Select Faculty_Id from Faculty_Info where Faculty_Department='"+dept[k]+"' and Faculty_Designation='ASSISTANT PROFESSOR'");
            fac_id=new String[no_of_fac[k][0]];
            l=0;
            while(rs.next())
            {
                fac_id[l++]=rs.getString(1);
            }
            fac_id=Duty_Allocator.ran_num(fac_id,fac_id.length);
            z=0;
            for(i=0;i<no_of_days;i++)//days
            {
                for(j=0;j<duty_counts[i];j=j+1)//duty numbers
                {
            
                    for(l=0;l<no_of_fac[k][1];l++)
                    {
            
                        String query="update id_"+id+" set Day_"+(i+1)+"_D_"+(j+1)+"='*', Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'";
                        z++;
                        stm.executeUpdate(query);
                       // stm.executeUpdate("update id_"+id+" set Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'");
                    
                    }
                }
            }
        
        }
        String query = "select count(Faculty_Id) from id_"+id+" where Day_1_D_1='*'";
        rs=stm.executeQuery(query);
        rs.next();
        int x=rs.getInt(1);
        stm.executeUpdate("update St_Details set Ticking_Value="+x+" where Id="+id);
        System.out.println("End Point");
        return id;
    }
    public void flying(int id) throws ClassNotFoundException, SQLException
    {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stmt=con.createStatement();
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();
        ResultSet rs=stm.executeQuery("select max(id)from St_Details");
		        System.out.println("1");
		//id is for table name generation
		
		int idf=0;
        rs.next();
        idf=rs.getInt(1);

        int[] nums=null; 
      
        int i,j;
        
        rs=stmt.executeQuery("select Number_Of_Days from St_Details where Id='"+id+"'");
        rs.next();
 	        System.out.println("2");
	
        int no_of_rooms=7;
        int no_of_days=Integer.parseInt(rs.getString(1));
        
        // System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
        //deleting previous ticks
        //stmt.executeUpdate("delete from St_1");
        
        String duty_dates[]=new String[no_of_days];
        int duty_counts[]=new int[no_of_days];
        System.out.println("MY SPACEE");
         System.out.println("3");
        rs=stmt.executeQuery("select * from Duty_Details where Id='"+id+"' order by Duty_Date");
       
	   // System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
         System.out.println("4");
		for(i=0;i<=no_of_days && rs.next();i++)
        {   
             //System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
            duty_dates[i]=(rs.getString(2));
            duty_counts[i]=Integer.parseInt(rs.getString(3));
            //System.out.println("wifklswhyjwiO");
        }
        
        //SortIntoDatabase sid=new SortIntoDatabase();
        //sid.sort("Faculty","Department");
        //RoomTransfer rt=new RoomTransfer();
        //rt.shiftRoom();
       
	   //System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
        
       //to GET NUMBER OF FACULTIES AVAILABLE
        System.out.println("5");
	rs=stmt.executeQuery("select count(Faculty_Id) from Faculty_Info where Faculty_Designation='PROFESSOR' or Faculty_Designation='ASSOCIATE PROFESSOR'");
         System.out.println("6");
        rs.next();
        
        int no_of_faculties=Integer.parseInt(rs.getString(1));
        
        
//Creating farji tables query
        
         System.out.println("7");
        String table_query="create table id_flying_"+id+"(Faculty_Id varchar(50)";
         
        for(i=0;i<no_of_days;i++)
            for(j=0;j<duty_counts[i];j++)
                table_query+=", Day_"+(i+1)+"_D_"+(j+1)+" varchar(50)";
        table_query+=", Tick_Count int, Duty_Count int, Reserve_Count int)";
        table_query=table_query.replace("-","_");
        stmt.executeUpdate(table_query);
        System.out.println(table_query);
        
//ticking
        System.out.println("ticking start");
        ResultSet rst=stmt.executeQuery("select Faculty_Id from Faculty_info where Faculty_Designation='PROFESSOR' or Faculty_Designation='ASSOCIATE PROFESSOR'");
        System.out.println("CHECK POIONT");
        String fa_query;
         System.out.println("8");
        while(rst.next())
        {
            fa_query="";
            fa_query+="insert into id_flying_"+id+" values('"+rst.getString(1)+"'";
            for(i=0;i<no_of_days;i++)
                for(j=0;j<duty_counts[i];j++)
                    fa_query+=",''";
            fa_query+=",0,0,0)";
            System.out.println(fa_query);
            stm.executeUpdate(fa_query);
        }
        
        System.out.println("CHECK POIONT");
        System.out.println("successful insertion");
        int z=0;
		
        //COUNTING NUMBER OF FACULTIES IN  paRTICULAR DEPARTMENT
        rst=stm.executeQuery("Select count(distinct Faculty_Department) from Faculty_Info where Faculty_Designation='PROFESSOR' or Faculty_Designation='ASSOCIATE PROFESSOR'");
        rst.next();
        int no_of_dept=rst.getInt(1);
        String dept[]=new String[no_of_dept];
        int no_of_fac[][]=new int[no_of_dept][2];
        
        rst=stm.executeQuery("Select Faculty_Department, count(Faculty_Id) from Faculty_Info where Faculty_Designation='PROFESSOR' or Faculty_Designation='ASSOCIATE PROFESSOR' group by Faculty_Department");
        i=0;
        while(rst.next())
        {
            dept[i]=rst.getString(1);
            no_of_fac[i][0]=rst.getInt(2);
            double r=Math.ceil(no_of_fac[i][0]*no_of_rooms/(double)no_of_faculties);
            no_of_fac[i][1]=(int)r;
            System.out.println(r+"   "+ dept[i]);
            i++;
        }
        



// GENERATION
        int k,l;
        String fac_id[];
        for(k=0;k<no_of_dept;k++)
        {
            rs=stm.executeQuery("Select Faculty_Id from Faculty_Info where Faculty_Department='"+dept[k]+"' and (Faculty_Designation='PROFESSOR' or Faculty_Designation='ASSOCIATE PROFESSOR')");
            fac_id=new String[no_of_fac[k][0]];
            l=0;
            while(rs.next())
            {
                fac_id[l++]=rs.getString(1);
            }
             System.out.println("asdasdasdasdass");
            fac_id=Duty_Allocator.ran_num(fac_id,fac_id.length);
            z=0;
            for(i=0;i<no_of_days;i++)//days
            {
                for(j=0;j<duty_counts[i];j=j+1)//duty numbers
                {
            
                    for(l=0;l<no_of_fac[k][1];l++)
                    {
            
                        String query="update id_flying_"+id+" set Day_"+(i+1)+"_D_"+(j+1)+"='*', Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'";
                        z++;
                        stm.executeUpdate(query);
                        //stm.executeUpdate("update id_flying_"+id+" set Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'");
                    }
                }
            }
        
        }/*
        String query = "select count(Faculty_Id) from id_flying_"+id+" where Day_1_D_1='*'";
        rs=stm.executeQuery(query);
        rs.next();
        int x=rs.getInt(1);
        stm.executeUpdate("update St_Details set Ticking_Value="+x+" where Id="+id);
        */
    }public void flooring(int id) throws ClassNotFoundException, SQLException
    {
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stmt=con.createStatement();
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();
        ResultSet rs=stm.executeQuery("select max(id)from St_Details");
		        System.out.println("1");
		//id is for table name generation
		
		int idf=0;
        rs.next();
        idf=rs.getInt(1);

        int[] nums=null; 
      
        int i,j;
        
        rs=stmt.executeQuery("select Number_Of_Days from St_Details where Id='"+id+"'");
        rs.next();
 	        System.out.println("2");
	
        int no_of_rooms=7;
        int no_of_days=Integer.parseInt(rs.getString(1));
        
        // System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
        //deleting previous ticks
        //stmt.executeUpdate("delete from St_1");
        
        String duty_dates[]=new String[no_of_days];
        int duty_counts[]=new int[no_of_days];
        System.out.println("MY SPACEE");
         System.out.println("3");
        rs=stmt.executeQuery("select * from Duty_Details where Id='"+id+"' order by Duty_Date");
       
	   // System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
         System.out.println("4");
		for(i=0;i<=no_of_days && rs.next();i++)
        {   
             //System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
            duty_dates[i]=(rs.getString(2));
            duty_counts[i]=Integer.parseInt(rs.getString(3));
            //System.out.println("wifklswhyjwiO");
        }
        
        //SortIntoDatabase sid=new SortIntoDatabase();
        //sid.sort("Faculty","Department");
        //RoomTransfer rt=new RoomTransfer();
        //rt.shiftRoom();
       
	   //System.out.println("NUMBER OF ROOMS = "+no_of_rooms);
        
       //to GET NUMBER OF FACULTIES AVAILABLE
        System.out.println("5");
	rs=stmt.executeQuery("select count(Faculty_Id) from Faculty_Info where Faculty_Designation='LAB ASSISTANT'");
         System.out.println("6");
        rs.next();
        
        int no_of_faculties=Integer.parseInt(rs.getString(1));
        
        
//Creating farji tables query
        
         System.out.println("7");
        String table_query="create table id_floor_"+id+"(Faculty_Id varchar(50)";
         
        for(i=0;i<no_of_days;i++)
            for(j=0;j<duty_counts[i];j++)
                table_query+=", Day_"+(i+1)+"_D_"+(j+1)+" varchar(50)";
        table_query+=", Tick_Count int, Duty_Count int, Reserve_Count int)";
        table_query=table_query.replace("-","_");
        stmt.executeUpdate(table_query);
        System.out.println(table_query);
        
//ticking
        System.out.println("ticking start");
        ResultSet rst=stmt.executeQuery("select Faculty_Id from Faculty_info where Faculty_Designation='LAB ASSISTANT'");
        System.out.println("CHECK POIONT");
        String fa_query;
         System.out.println("8");
        while(rst.next())
        {
            fa_query="";
            fa_query+="insert into id_floor_"+id+" values('"+rst.getString(1)+"'";
            for(i=0;i<no_of_days;i++)
                for(j=0;j<duty_counts[i];j++)
                    fa_query+=",''";
            fa_query+=",0,0,0)";
            System.out.println(fa_query);
            stm.executeUpdate(fa_query);
        }
        
        System.out.println("CHECK POIONT");
        System.out.println("successful insertion");
        int z=0;
		
        //COUNTING NUMBER OF FACULTIES IN  paRTICULAR DEPARTMENT
        rst=stm.executeQuery("Select count(distinct Faculty_Department) from Faculty_Info where Faculty_Designation='LAB ASSISTANT'");
        rst.next();
        int no_of_dept=rst.getInt(1);
        String dept[]=new String[no_of_dept];
        int no_of_fac[][]=new int[no_of_dept][2];
        
        rst=stm.executeQuery("Select Faculty_Department, count(Faculty_Id) from Faculty_Info where Faculty_Designation='LAB ASSISTANT' group by Faculty_Department");
        i=0;
        while(rst.next())
        {
            dept[i]=rst.getString(1);
            no_of_fac[i][0]=rst.getInt(2);
            double r=Math.ceil(no_of_fac[i][0]*no_of_rooms/(double)no_of_faculties);
            no_of_fac[i][1]=(int)r;
            System.out.println(r+"   "+ dept[i]);
            i++;
        }
        



// GENERATION
        int k,l;
        String fac_id[];
        for(k=0;k<no_of_dept;k++)
        {
            rs=stm.executeQuery("Select Faculty_Id from Faculty_Info where Faculty_Department='"+dept[k]+"' and (Faculty_Designation='LAB ASSISTANT')");
            fac_id=new String[no_of_fac[k][0]];
            l=0;
            while(rs.next())
            {
                fac_id[l++]=rs.getString(1);
            }
             System.out.println("asdasdasdasdass");
            fac_id=Duty_Allocator.ran_num(fac_id,fac_id.length);
            z=0;
            for(i=0;i<no_of_days;i++)//days
            {
                for(j=0;j<duty_counts[i];j=j+1)//duty numbers
                {
            
                    for(l=0;l<no_of_fac[k][1];l++)
                    {
            
                        String query="update id_floor_"+id+" set Day_"+(i+1)+"_D_"+(j+1)+"='*', Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'";
                        z++;
                        stm.executeUpdate(query);
                       // stm.executeUpdate("update id_floor_"+id+" set Tick_Count=Tick_Count+1 where Faculty_Id='"+fac_id[z%no_of_fac[k][0]]+"'");
                    
                    }
                }
            }
        
        }/*
        String query = "select count(Faculty_Id) from id_flying_"+id+" where Day_1_D_1='*'";
        rs=stm.executeQuery(query);
        rs.next();
        int x=rs.getInt(1);
        stm.executeUpdate("update St_Details set Ticking_Value="+x+" where Id="+id);
        */
    }
}
