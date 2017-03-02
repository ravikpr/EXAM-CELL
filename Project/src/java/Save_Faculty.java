/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import com.sun.xml.registry.uddi.bindings_v2_2.Phone;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author p
 */
@WebServlet(urlPatterns = {"/Save_Faculty"})
public class Save_Faculty extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
            Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stm = conn.createStatement();
            Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
            Statement stmt = con.createStatement();
            String name=request.getParameter("name");
            String department=request.getParameter("department");
            String designation=request.getParameter("designation");
            String number=request.getParameter("phone");
            String gender=request.getParameter("gender");
            String mail=request.getParameter("mail");
            
            ResultSet rs=stm.executeQuery("select * from Faculty_Info where Faculty_Phone='"+number+"' or Faculty_Email='"+mail+"'");
            if(rs.next())
            {
                response.sendRedirect("blank.jsp?message=Faculty Phone Number/E-Mail Already Exists<br>Insertion Unsucessful");
            }
            else
            {
            String query,maxid;
                
            //DELETING THE UN-FINISHED EXAMS
            int id;
            rs=stm.executeQuery("select Id from St_Details where Exam_Stage<>3");
                while (rs.next()) {
                   id=rs.getInt(1);
                   query="drop table Id_"+id;
                    System.out.println(query);
                    stmt.executeUpdate(query);
                    query="drop table Id_floor_"+id;
                    stmt.executeUpdate(query);
                    query="drop table Id_flying_"+id;  
                    stmt.executeUpdate(query);
                    
                    query="delete from St_Details where id="+id;
                    System.out.println(query);
                    stmt.executeUpdate(query);
                    query="delete from Duty_Details where id="+id;
                    System.out.println(query);
                    stmt.executeUpdate(query);
                    
                }
                
            
            // OBTAINING MAX FACULTY ID FOR THE NEXT FACULTY ID 
            
            query="select max (Faculty_Id) from Faculty_Info where Faculty_Id like '"+department+"%'";
            rs=stm.executeQuery(query);
            rs.next();
            maxid=rs.getString(1);
            
            //GENERATING NEXT FACULTY ID
            
            maxid=maxid.substring(3);
            id= Integer.parseInt(maxid);
            id++;
            maxid=department+String.format("%03d",id);
            
            //INSERTION OF THE NEW FACULTY
            
            query="insert into Faculty_Info values('"+maxid+"','"+department+"','"+name+"','"+designation+"','"+number+"','"+gender+"','"+mail+"')";
            System.out.println(query);
            stm.executeUpdate(query);
            response.sendRedirect("blank.jsp?message=Sucessful Insertion ");
            
            }
            
            
            
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Save_Faculty.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Save_Faculty.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Save_Faculty.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Save_Faculty.class.getName()).log(Level.SEVERE, null, ex);
        }
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
