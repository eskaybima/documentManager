/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;

import com.fasyl.Dao.OracleConnManager;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PDFLoader", urlPatterns = {"/PDFLoader"})
public class PDFLoader extends HttpServlet {
   Connection conn;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        PrintWriter out = response.getWriter();
        
        if (request.getParameter("view") != null) {
        String doc_id = request.getParameter("view");
        String type = request.getParameter("type");
        response.setContentType("application/pdf");
        try  {
            out.println("<!DOCTYPE pdf>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PDFLoader</title>");            
            out.println("</head>");
            out.println("<body>");
            InputStream photo = getStream(doc_id, type);
            response.reset();
             byte[] bytearray = new byte[31457280];
                int size = 0;
             while ((size = photo.read(bytearray)) != -1) {
                    response.getOutputStream().write(bytearray, 0, size);
                    response.getOutputStream().flush();
                } 
            out.println("</body>");
            out.println("</html>");
        }  catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            out.close();
        }
        } else if (request.getParameter("fileView") != null) {
            String fileView = request.getParameter("fileView");
             InputStream photo = null;
            response.setContentType("application/pdf");
                //photo = getImageFromFile(fileView);
                //PrintWriter out = response.getWriter();
                response.setContentType("application/pdf");
                try {
                    out.println("<!DOCTYPE pdf>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet PDFLoader</title>");
                    out.println("</head>");
                    out.println("<body>");
                    // File imageArchive = new File(System.getProperty("user.home")+"/imageArchive"); // just added
                    String osname = System.getProperty("os.name", "").toLowerCase();
                    String imagepath = "";
                    File imageArchive = null;
                    if (osname.startsWith("windows")) {
                        String text = "Hello world Windows";
                        System.out.println(text);
                        try {

                            imageArchive = new File("C:/ImmArchive/");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else if (osname.startsWith("linux")) {
                        String text = "Hello world Linux";
                        System.out.println(text);
                        try {
                            imageArchive = new File("/home/notapuser/imageArchive");
                            imageArchive.mkdir();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    // String imagepath ="C:/ImmArchive/" + fileView;
                    imagepath = imageArchive.getPath() + "/" + fileView;   // just added
                    photo = new FileInputStream(imagepath);
                    response.reset();
                    byte[] bytearray = new byte[31457280];
                    int size = 0;
                    while ((size = photo.read(bytearray)) != -1) {
                        response.getOutputStream().write(bytearray, 0, size);
                        response.getOutputStream().flush();
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                } finally {
                    out.close();
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

    public InputStream getStream(String doc_id, String type){
        String doc = null;
        if (type == null) {
            doc = "document";
        } else {
            doc = "document_update";
        }
        InputStream sImage = null;
         try {
            conn = OracleConnManager.getConnection();
            Statement st = conn.createStatement();
            String q = "select " + doc + " from fas_int_documents where document_id ='" + doc_id + "'";
            ResultSet rs = st.executeQuery(q);
            if (rs.next()) {
                byte[] bytearray = new byte[31457280];
                int size = 0;
                sImage = rs.getBinaryStream(1);
                rs.close();
                st.close();
            }
        } catch (SQLException ex) {
            Logger.getLogger(PhotoLoader2.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
         }
        return sImage;
    }
    
}

