/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.AccessControl;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;;
import com.google.gson.Gson;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;


@WebServlet(name = "PostAccessSettings", urlPatterns = {"/PostAccessSettings"})
public class PostAccessSettings extends HttpServlet {
private static final long serialVersionUID = 1L;
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        JSONObject res = new JSONObject();
        String outValue = null;
        try {
        BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
        String json  = br.readLine();
        System.out.println("Data is : "+json);
        Gson gson = new Gson();
        
        List<AccessControl> accessControl = new ArrayList();
        ConfigureJobController cj = new ConfigureJobController();
         
        AccessControl[]  ac = gson.fromJson(json, AccessControl[].class);
        accessControl.addAll(Arrays.asList(ac));
         boolean result = cj.configureAccess(request, response, accessControl);
            if (result) {
                 res.put("valid", true);
                 outValue = "{\"valid\" : true}";
            } else {
                res.put("valid", false);
                outValue = "{\"valid\" : false}";
            }
            
        } finally {  
            out.print(outValue);
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