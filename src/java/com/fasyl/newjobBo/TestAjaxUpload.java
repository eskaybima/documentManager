/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.DocumentLoaderVo;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author OYEWOLE
 */
@WebServlet(name = "TestAjaxUpload", urlPatterns = {"/TestAjaxUpload"})
public class TestAjaxUpload extends HttpServlet {

    String imagePath;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       String imagepath = "";
       File imageArchive = null;
       String osname = System.getProperty("os.name", "").toLowerCase();
        if (osname.startsWith("windows")) {
            String text = "Hello world Windows";
            System.out.println(text);
            try {
               imagePath = "C://ImmArchive//";
            } catch (Exception e) {
                e.printStackTrace();
            } 
        }else if(osname.startsWith("linux")) {
           imageArchive = new File("/home/notapuser/imageArchive");
        if (imageArchive.exists()) {
          System.out.println(" ayam exist olredi ");
       } else {
         imageArchive.mkdir();  
         imagePath = "/home/notapuser/imageArchive/";
       }  
   } 
        int maxFileSize = 31457280;
        int maxMemSize = 31457280;
        HttpSession session = request.getSession(true);
        String curr_doc_id = (String) session.getAttribute("documentId");
        String doc_type = (String) session.getAttribute("currentImage");
        String contentType = request.getContentType();
        if (contentType.indexOf("multipart/form-data") >= 0) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
         if (osname.startsWith("windows")) {
                 factory.setRepository(new File("C://"));
               } else if (osname.startsWith("linux")){
                factory.setRepository(new File("/home/notapuser/"));
               }
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);
            try {
                List fileItems = upload.parseRequest(request);
                Iterator i = fileItems.iterator();
                while (i.hasNext()) {
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        
                        String fileName = fi.getName();
                        String fileExt = fileName.substring(fileName.indexOf("."), fileName.length());
                        String fieldName = fi.getFieldName();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();
                        //System.out.println("hhhhhhhhhhhhhhhhhhh 33  " + fi.getContentType());
                        //System.out.println("ext is  " + fileExt);
                        File file;
                        if (fileName.lastIndexOf("//") >= 0) {
                            file = new File(imagePath + curr_doc_id);
                        } else {
                            file = new File(imagePath + curr_doc_id);
                        }
                        fi.write(file);
                        System.out.println("writting it mmmmmmmmmmmmmmmmmm");
                        
                         List<DocumentLoaderVo> documentLoaderList = (List<DocumentLoaderVo>)session.getAttribute("documentLoaderList");
                         DocumentLoaderVo documentLoaderVo = new DocumentLoaderVo();
                         documentLoaderVo.setDocType(doc_type);
                         documentLoaderVo.setDoc_id(curr_doc_id);
                         documentLoaderVo.setFilepath(imagePath + curr_doc_id);
                         documentLoaderVo.setDoc_format(fileExt);
                         documentLoaderList = listWasher(documentLoaderList, documentLoaderVo);
                         documentLoaderList.add(documentLoaderVo);
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }

    
 List<DocumentLoaderVo> listWasher(List<DocumentLoaderVo> documentLoaderList, DocumentLoaderVo documentLoaderVo){
                for(int j = 0; j < documentLoaderList.size(); j++ ){
                    if ((documentLoaderList.get(j)).getDocType().contains(documentLoaderVo.getDocType())) {
                        documentLoaderList.remove(j);
                    }
                }
          return documentLoaderList;
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
