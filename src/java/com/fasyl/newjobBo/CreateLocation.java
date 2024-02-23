/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author OYEWOLE MORUFF
 */
@WebServlet(name = "CreateLocation", urlPatterns = {"/CreateLocation"})
public class CreateLocation extends HttpServlet {
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
            throws ServletException, IOException {
         createLocation(request, response);
        
    }
 private void createLocation(HttpServletRequest request, HttpServletResponse response){
     SaveToDb sb = new SaveToDb();
        String loc_code = request.getParameter("loc_code");
        String loc_desc = request.getParameter("loc_desc");
        boolean saveLocation = true;
        int k = 0;
        ServletContext context = getServletContext();
         List<String> codes = sb.getList2("select loc_code from fas_mst_location");
         List<String> desc = sb.getList2("select loc_desc from fas_mst_location");
         List<String> loc_id = sb.getList2("select loc_id from fas_mst_location");
        for (int i = 0; i < codes.size(); i++) {
           if (codes.get(i).equalsIgnoreCase(loc_code)) {
               try {
                   request.setAttribute("message", "Code Already Used, Location Creation Failed");
                   request.setAttribute("status", "error");
                   saveLocation = false;
                   RequestDispatcher rd = context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {
                   Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE, null, ex);
               } 
           }
           
           if (desc.get(i).equalsIgnoreCase(loc_desc)) {
               try {
                   request.setAttribute("message", "Description Exists, Location Creation Failed");
                   request.setAttribute("status", "error");
                   saveLocation = false;
                   RequestDispatcher rd = context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {
                   Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE, null, ex);
               } 
           }
            String  idd = loc_id.get(i);
            int idc = Integer.parseInt(idd);
            if (idc > k){ k = idc; }
    }
        if (saveLocation) {
         k++;
         String new_id = String.valueOf(k);
         String zeros = "";
         for(int i = 0; i < (3-new_id.length()); i++ ){
         zeros = zeros + "0";
         }
         new_id = zeros + k;
         
            String columns = "loc_id, loc_code, loc_desc";
            String values = "'"+new_id +"','" + loc_code + "', '" + loc_desc + "'";
            String query = "insert into fas_mst_location(" + columns + ") values(" + values + ")";
            String result = sb.persist(query);
         try {
                   request.setAttribute("message", "Location Creation Successful");
                   request.setAttribute("status", "success");
                   RequestDispatcher rd = context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {
                   Logger.getLogger(CreateLocation.class.getName()).log(Level.SEVERE, null, ex);
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
