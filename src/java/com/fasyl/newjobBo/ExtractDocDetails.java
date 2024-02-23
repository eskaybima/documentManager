/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.DocumentLoaderVo;
import com.fasyl.vo.DocumentsInfo;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "ExtractDocDetails", urlPatterns = {"/ExtractDocDetails"})
public class ExtractDocDetails extends HttpServlet {

    Gson gson = new Gson();

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
        response.setContentType("application/json");
        HttpSession session = request.getSession(true);
        List<String> currentList = (List<String>) session.getAttribute("imageList");
        String curr_image = (String) session.getAttribute("currentImage");
        String cur_doc_id = (String) session.getAttribute("documentId");
        String description = "";
        SaveToDb sb = new SaveToDb();
        PrintWriter out = response.getWriter();
        List<DocumentLoaderVo> extantDocInfo = null;
        try {
            DocumentsInfo documentsInfo = new DocumentsInfo();
            List<DocumentsInfo> documentsInfoList = new ArrayList<>();
            documentsInfo.setDoc_id(cur_doc_id);
            documentsInfo.setDocType(curr_image);
            documentsInfoList.add(documentsInfo);
            extantDocInfo = (List<DocumentLoaderVo>) session.getAttribute("documentLoaderList");
            extantDocInfo = listWasher(extantDocInfo, documentsInfo);
            response.getWriter().print(gson.toJson(documentsInfoList));
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
        System.out.println("size after trip is " + extantDocInfo.size());
        session.setAttribute("documentsInfoList", extantDocInfo);
    }

    List<DocumentLoaderVo> listWasher(List<DocumentLoaderVo> extantDocInfo, DocumentsInfo documentsInfo) {
        for (int j = 0; j < extantDocInfo.size(); j++) {
            if ((extantDocInfo.get(j)).getDocType().contains(documentsInfo.getDocType())) {
                extantDocInfo.remove(j);
            }
        }
        return extantDocInfo;
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
