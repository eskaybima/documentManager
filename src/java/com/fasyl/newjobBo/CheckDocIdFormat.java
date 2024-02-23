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
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(name = "CheckDocIdFormat", urlPatterns = {"/CheckDocIdFormat"})
public class CheckDocIdFormat extends HttpServlet {

    Gson gson = new Gson();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession(true);
        String doc_id = request.getParameter("docId");
        PrintWriter out = response.getWriter();
        String outValue = null;
        ResultSet rSet = null;
        String query = "";
        String element = "";
        SaveToDb sb = new SaveToDb();
        DocumentsInfo docuInfo = new DocumentsInfo();
        List<DocumentsInfo> df = new ArrayList<>();
            query = "select document_id, doc_format from fas_int_documents where document_id = '" + doc_id + "'";
            List<String[]> detail = sb.getListss(query, 2);
            if (!detail.isEmpty()) {
                if (".pdf".equalsIgnoreCase(detail.get(0)[1])) {
               docuInfo.setDoc_format("pdf");
                } else {
                     docuInfo.setDoc_format("notPdf");
                }
                 df.add(docuInfo);
            } else {
            List<DocumentLoaderVo> documentLoaderList = (List<DocumentLoaderVo>)session.getAttribute("documentLoaderList");
            for (DocumentLoaderVo documentLoaderList1 : documentLoaderList) {
                if (doc_id != null) {
                    if (doc_id.equalsIgnoreCase(documentLoaderList1.getDoc_id())) {
                        if (".pdf".equalsIgnoreCase(documentLoaderList1.getDoc_format())) {
                            docuInfo.setDoc_format("pdf");
                        } else {
                            docuInfo.setDoc_format("notPdf");
                        }
                        df.add(docuInfo);
                    }
                }
            }
            }
        response.getWriter().print(gson.toJson(df));
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
