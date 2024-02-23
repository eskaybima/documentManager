/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.Dao.ConnectionManager1;
import com.fasyl.Dao.OracleConnManager;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Adebayo
 */
public class PageUtil {
  public static boolean isDocAvailable(String doc_id) {
      boolean display = false;
      String query = "select document from fas_int_documents where document_id ='" +doc_id+ "'";
      InputStream sImage = getStream(query);
      if (sImage != null) { display = true;}
      return display; 
    }
    private static InputStream getStream(String query){
        String doc = null;
         OracleConnManager  comgr ;
          Connection conn = null;
        InputStream sImage = null;
         try {
            //ConnectionManager comgr = new ConnectionManager();
            //ConnectionManager1 comgr = new ConnectionManager1();
            //comgr = new OracleConnManager();
            conn = OracleConnManager.getConnection();
            Statement st = conn.createStatement();
          
            String q = query;
            System.out.println(q);
            ResultSet rs = st.executeQuery(q);
            if (rs.next()) {
                byte[] bytearray = new byte[31457280];
                int size = 0;
                sImage = rs.getBinaryStream(1);
                rs.close();
                st.close();
                  // conn.commit();
               // comgr.releaseConnection(conn);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PhotoLoader2.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                
                // comgr.releaseConnection(conn);
                  conn.close();
                   conn=null;
                
            } catch (SQLException ex) {
                Logger.getLogger(PDFLoader.class.getName()).log(Level.SEVERE, null, ex);
            }
               
         }
        return sImage;
    }
}
