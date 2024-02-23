/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;


@WebServlet(name = "RightManager", urlPatterns = {"/RightManager"})
public class RightManager extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
               response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        JSONObject json = new JSONObject();
        String ref_id = request.getParameter("ref_id");
        SaveToDb sb = new SaveToDb();
        String outValue = null;
        HttpSession session = request.getSession(true);
        String userid = (String) session.getAttribute("username");
        String roleId = (String)session.getAttribute("role_id");
        boolean right = checkRight(userid, ref_id, roleId);
           if (right) {
                outValue = "{\"valid\" : true }";
                json.put("valid", true);
                System.out.println(json);
            } else {
                outValue = "{\"valid\" : false }";
                json.put("valid", false);
                System.out.println(json);
            }
            out.print(outValue);
            out.close();
    }

    
    public boolean checkRight(String userId, String ref_id, String roleId){
        boolean right = false;
        SaveToDb sb = new SaveToDb();
        
        String query = "select access_key from access_right where ref_id ='" + ref_id + "'";
        String access_key = sb.getValue2(query);
        if ("public".equalsIgnoreCase(access_key)) {
            return true;
        }
        
         query = "select access_key from access_right where ref_id ='" + ref_id + "' and access_key = '" + userId + "' and access_nature ='individual'";
        if (sb.isAvailable(query)) {
            return true;
        }
         
        query = "select access_key from access_right where ref_id ='" + ref_id + "' and access_key = '" + roleId + "' and access_nature ='role_id'";
        if (sb.isAvailable(query)) {
            return true;
        }
        query = "select access_key from access_right where ref_id ='" + ref_id + "' and access_nature ='user_group'";
        List<String> user_groups =  sb.getList2(query);
        
        for (String user_group : user_groups) {
            query = "select USER_MEMBER from user_group where group_name ='" + user_group + "' and USER_MEMBER = '" + userId + "'";
            if (sb.isAvailable(query)) {
                return true;
            }
        }
        
        
        return right;
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
