/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.LoaderVo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Adebayo
 */
@WebServlet(name = "checkenrolnum", urlPatterns = {"/checkenrolnum"})
public class checkenrolnum extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
       SaveToDb sb = new SaveToDb();
        
        String exits = "Exits";
        String notexits = "NotExits";
        System.out.println("About to check the Database for existing Enrolment number");
           try {
          String enrolnum  = request.getParameter("age").toUpperCase();  
           String pas = "select enrol_no from fas_int_doc where enrol_no = '" +enrolnum+ "'";
           int  count = sb.getId2(pas);
           if (count > 0 ){
               System.out.println("This Enronlment number" +enrolnum + " was found");
           out.println(exits);
           } else {
            HttpSession session = request.getSession(true);
            String applicationId = (String) session.getAttribute("applicationId");
           LoaderVo lv =  (LoaderVo) session.getAttribute("LoaderVo");
//           lv.setParam1(enrolnum);
            System.out.println("This Enrolment number" +enrolnum + " was not found");
            out.println(notexits);
           }
             System.out.println("Finish checking the Database for existing Enrolment number");
         }
           catch(Exception e)
          {
            out.println(""+e);       
          
        } finally {            
            out.close();
        }
    
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
     * Handles the HTTP
     * <code>POST</code> method.
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
