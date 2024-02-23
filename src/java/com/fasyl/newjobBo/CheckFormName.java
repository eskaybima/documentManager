/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.Dao.OracleConnManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;

@WebServlet(name = "CheckFormName", urlPatterns = {"/CheckFormName"})
public class CheckFormName extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String templateName =  request.getParameter("templateName");
        String description = request.getParameter("description");
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        Connection con = null;
        String outValue = null;
        ResultSet rSet = null;
        PreparedStatement preparedStmt = null;
        String query = "";
        String element = "";
        
        if ( templateName != null ) {
            templateName =  templateName.trim();
            templateName =  templateName.replace(" ", "_").toUpperCase();
            query = "select template_name from  template_names where UPPER(template_name) like ?";
            element = templateName;
        }  
        
        if ( description != null ) {
            description =  description.trim();
            description =  description.toUpperCase();
            query = "select description from  template_names where UPPER(description) like ?";
            element = description;
        }  
        
          try  {
            con = OracleConnManager.getConnection();
            preparedStmt = con.prepareStatement(query);
            String forSql = "%"+element+"%";
            preparedStmt.setString(1, forSql);
          
            rSet =  preparedStmt.executeQuery();        
            if ((!rSet.next()) ) {
               outValue = "{\"valid\" : true }";
             json.put("valid", true);
            System.out.println(json);
            } else {
             outValue = "{\"valid\" : false }";
             json.put("valid", false);
            System.out.println(json);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally { 
              out.print(outValue);
              out.close();
                try {
                rSet.close();
                preparedStmt.close();
                con.close();
            } catch (SQLException ex) {
               // Logger.getLogger(CapitaStructure2.class.getName()).log(Level.SEVERE, null, ex);
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
