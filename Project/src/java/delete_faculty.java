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
@WebServlet(urlPatterns = {"/delete_faculty"})
public class delete_faculty extends HttpServlet {

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
            Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        Connection con = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stmt=con.createStatement();
        Connection conn = DriverManager.getConnection("jdbc:odbc:project","","");
        Statement stm=conn.createStatement();
        ResultSet rs;
        //DELETING THE UN-FINISHED EXAMS
            int id;
            String query;
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
                    stmt.executeUpdate(query);}
             // DELETING THE FACULTY   
            String del[]=request.getParameterValues("del");
            for(int i=0;i<del.length;i++)
            {
                stmt.executeUpdate("delete from Faculty_Info where Faculty_Id='"+del[i]+"'");
                System.out.println(del[i]+" sucessfully deleted");
            }
            
            response.sendRedirect("blank.jsp?message=Sucessful Deletion");
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
            Logger.getLogger(delete_faculty.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(delete_faculty.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(delete_faculty.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(delete_faculty.class.getName()).log(Level.SEVERE, null, ex);
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
