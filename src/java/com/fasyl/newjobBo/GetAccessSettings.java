/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.Dao.OracleConnManager;
import com.fasyl.vo.AccessControl;
import com.fasyl.vo.DocumentsInfo;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author OYEWOLE
 */
@WebServlet(name = "GetAccessSettings", urlPatterns = {"/GetAccessSettings"})
public class GetAccessSettings extends HttpServlet {
    Gson gson = new Gson();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        SaveToDb sb = new SaveToDb();
        String ref_id = (String)request.getParameter("ref_id");
         String query = "select access_key, access_nature from access_right where ref_id = '" + ref_id + "'";
         System.out.println("kkkkkkkkkkkkkkkkkkkkkkk " + query);
         List<String[]> data = sb.getListss(query, 2);
         List<AccessControl> accessControlList = new ArrayList<>();
            for (String[] data1 : data) 
            {
                AccessControl accessControl = new AccessControl();
                accessControl.setAccess_key(data1[0]);
                accessControl.setAccess_nature(data1[1]);
                accessControlList.add(accessControl);
            }
          response.getWriter().print(gson.toJson(accessControlList));
           out.flush();
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
