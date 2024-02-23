package com.fasyl.newjobBo;

import com.fasyl.Dao.ConnectionManager;
import com.fasyl.Dao.OracleConnManager;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PhotoLoader2", urlPatterns = {"/PhotoLoader2"})
public class PhotoLoader2
        extends HttpServlet {
OracleConnManager comgr;
   Connection conn;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ayam there there");
        try {
          //  ConnectionManager comgr = new ConnectionManager();
             conn = comgr.getConnection();
            String id = request.getParameter("id");
         //  String transN = request.getParameter("transN");
         //  String document = request.getParameter("document");
         //   HttpSession session = request.getSession(true);
         //   String applicationId = (String) session.getAttribute("applicationId");
            System.out.println("ayam there there");

            Statement st = conn.createStatement();
            String q = "select document from fas_int_documents where document_id ='" + id + "'";
            System.out.println(q);
            ResultSet rs = st.executeQuery(q);
            if (rs.next()) {
                byte[] bytearray = new byte[31457280];
                int size = 0;
                InputStream sImage = rs.getBinaryStream(1);
                response.reset();
                response.setContentType("image/jpeg");
                while ((size = sImage.read(bytearray)) != -1) {
                    response.getOutputStream().write(bytearray, 0, size);
                    response.getOutputStream().flush();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(PhotoLoader2.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
        //comgr.releaseConnection(conn);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }
}
