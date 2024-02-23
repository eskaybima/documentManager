/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.Dao.OracleConnManager;
import com.fasyl.vo.DefineWorkFlowVo;
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
@WebServlet(name = "GetWorkFlow", urlPatterns = {"/GetWorkFlow"})
public class GetWorkFlow extends HttpServlet {
    Gson gson = new Gson();
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(true);
        PrintWriter out = response.getWriter();
        SaveToDb sb = new SaveToDb();
        String template = (String)session.getAttribute("template");
         //String query = "select user_member, auth_level from fas_work_flow_define where template_name ='" + template + "' order by auth_level asc";
        String query = "select user_member, auth_level from fas_work_flow_define where template_name ='" + template + "' order by auth_level asc";
        Connection con = null;
         Statement st = null;
         ResultSet rSet = null;
        try {
            con = OracleConnManager.getConnection();
            st = con.createStatement();
            System.out.println("mmm " + query);
            rSet = st.executeQuery(query);
            List<DefineWorkFlowVo> wf = new ArrayList<>();
            while (rSet.next()) 
            {
                DefineWorkFlowVo wsInfo = new DefineWorkFlowVo();
                wsInfo.setUserId(rSet.getString("user_member")); //rSet.getString("param_names")
                wsInfo.setAuthLevel(rSet.getString("auth_level"));
                wf.add(wsInfo);
            }
          
          response.getWriter().print(gson.toJson(wf));
           out.flush();
          
        }  catch (Exception e) {
            e.printStackTrace();
        } finally {      
              out.close();
               try {
                rSet.close();
                st.close();
                con.close();
            } catch (SQLException ex) {
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
