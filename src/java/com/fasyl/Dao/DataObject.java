/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.Dao;

import com.fasyl.vo.DocumentLoaderVo;
import com.fasyl.vo.LoaderVo;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


public class DataObject {
    
    public String executeStatement(Connection conn, String query) {
        Statement st = null;
        System.out.println(query);
        try {
            
            st = conn.createStatement();
            st.execute(query);
            conn.commit();
            return "success";
        } catch (Exception ex) {
            ex.printStackTrace();
            return "failure";
        } finally {
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
    }
    
    public int getNumber(Connection conn, String query) {
        Statement st = null;
        int i = 0;
        ResultSet rs = null;
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) { i = rs.getInt(1);
               conn.commit();
                   
                   }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
             DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
           
        }
        return i;
    }

    
    public List<String[]> getListss(Connection conn, String query, int k) {
        System.out.println("yyyyyyyyyyyyyyyyyy" + query);
        Statement st = null;
        List<String[]> list = new ArrayList<String[]>();
        String[] l = null;
        ResultSet rs = null;
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[k];
                   for (int i = 1; i <= k ; i++) {
                   l[i-1] = rs.getString(i);
               }
               list.add(l);
               }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
         
        }
        return list;
    }
    
     public String[] getListStringArray(Connection conn, String query, int k) {
        System.out.println("yyyyyyyyyyyyyyyyyy" + query);
        Statement st = null;
        String[] l = null;
        ResultSet rs = null;
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[k];
                   for (int i = 1; i <= k ; i++) {
                   l[i-1] = rs.getString(i);
               }
               }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
         
        }
        return l;
    }
  

    
    public String getValue(Connection conn, String query) {
        Statement st = null;
        String value = null;
        ResultSet rs = null;
        System.out.println("this is the connection" + conn);
        System.out.println(query);
        
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) { value = rs.getString(1);
           //conn.commit();
           }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
             DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return value;
    }
    
    public List<String> getList(Connection conn, String query) {
        Statement st = null;
        ResultSet rs = null;
        List<String> list = new ArrayList<String>();
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               String docType = rs.getString(1);
               System.out.println(docType);
               list.add(docType);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
    
    public List<LoaderVo> getLoaderList(Connection conn, String id) {
        Statement st = null;
        String query = "select document_type, document_id from fas_int_documents where ref_id_detl = '" + id + "'";
        List<LoaderVo> list = new ArrayList<LoaderVo>();
        LoaderVo lv = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) {
                lv = new LoaderVo();
                String type = rs.getString(1);
                String doc_id = rs.getString(2);
                lv.setType(type);
                lv.setDoc_id(doc_id);
                list.add(lv);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
    
    
    public List<LoaderVo> getImageUpdateList(Connection conn, String id) {
        Statement st = null;
        String query = "select document_type, document_id from fas_int_documents where ref_id_detl = '" + id + "' and approved_status = 'U'";
        List<LoaderVo> list = new ArrayList<LoaderVo>();
        LoaderVo lv = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            while (rs.next()) {
                lv = new LoaderVo();
                String type = rs.getString(1);
                String doc_id = rs.getString(2);
                lv.setType(type);
                lv.setDoc_id(doc_id);
                list.add(lv);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
             DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
    
    public void saveImage(Connection conn, File file, String docType, String ref_id, int i){
        PreparedStatement psmnt = null;
        FileInputStream fis;
        
        String doc = null;
        switch (i) {
            case 0:
                doc = "document";
                break;
            case 1:
                doc = "document_update";
                break;
        }
           System.out.println("lllllllllllllll   update fas_int_documents set "+ doc +" = ? where document_type = '"+ docType +"' and ref_id_detl = '" + ref_id +"'");
        try {
            psmnt = conn.prepareStatement("update fas_int_documents set "+ doc +" = ? where document_type = ? and ref_id_detl = ?");
            fis = new FileInputStream(file);
            psmnt.setBinaryStream(1, (InputStream) fis, (int) (file.length()));
            psmnt.setString(2, docType);
            psmnt.setString(3, ref_id);
            int s = psmnt.executeUpdate();
            //conn.commit();
            if (s > 0) {
                System.out.println("Uploaded successfully !");
            } else {
                System.out.println("unsucessfull to upload image.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
                DbUtil.closeStatement(psmnt);
            DbUtil.closeConnection(conn);
        }
    }
    
    public void saveDocuments(Connection conn, List<DocumentLoaderVo> documentLoaderList, String ref_id){
        PreparedStatement psmnt = null;
        FileInputStream fis;
        File file;
        try {
            for (DocumentLoaderVo documentLoaderList1 : documentLoaderList) {
                psmnt = conn.prepareStatement("insert into fas_int_documents(ref_id_detl, document_type, document_id, DOCUMENT, DOC_PATH, doc_format) values (?,?,?,?,?,?)");
                psmnt.setString(1, ref_id);
                psmnt.setString(2, documentLoaderList1.getDocType());
                psmnt.setString(3, documentLoaderList1.getDoc_id());
                fis = new FileInputStream(documentLoaderList1.getFilepath());
                file = new File(documentLoaderList1.getFilepath());
                psmnt.setBinaryStream(4, (InputStream) fis, (int) (file.length()));
                psmnt.setString(5, documentLoaderList1.getFilepath());
                psmnt.setString(6, documentLoaderList1.getDoc_format());
                int s = psmnt.executeUpdate();
                if (s > 0) {
                    System.out.println(documentLoaderList1.getDocType() + " uploaded successfully for " + ref_id) ;
                } else {
                     System.out.println(documentLoaderList1.getDocType() + " uploaded unsuccessfully for " + ref_id) ;
                } 
            }
        } catch (SQLException | FileNotFoundException ex) {
            ex.printStackTrace();
        } finally {
                DbUtil.closeStatement(psmnt);
            DbUtil.closeConnection(conn);
        }
    }
    
    public List<String[]> getList3(Connection conn, String query) {
        Statement st = null;
        List<String[]> list = new ArrayList<String[]>();
        String[] l = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[2];
               l[0] = rs.getString(1);
               l[1] = rs.getString(2);
               list.add(l);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
         
        }
        return list;
    }
    
     public List<String[]> getList4(Connection conn, String query) {
        Statement st = null;
        List<String[]> list = new ArrayList<String[]>();
        String[] l = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[3];
               l[0] = rs.getString(1);
               l[1] = rs.getString(2);
               l[2] = rs.getString(3);
               list.add(l);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
               DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
     
        public List<String[]> getList5(Connection conn, String query) {
        Statement st = null;
        List<String[]> list = new ArrayList<String[]>();
        String[] l = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[7];
               l[0] = rs.getString(1);
               l[1] = rs.getString(2);
               l[2] = rs.getString(3);
               l[3] = rs.getString(4);
               l[4] = rs.getString(5);
               l[5] = rs.getString(6);
               l[6] = rs.getString(7);
               list.add(l);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
               DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
 public boolean isAvailable(Connection conn, String query) {
        Statement st = null;
        boolean result = false;
        ResultSet rs = null;
        System.out.println(query);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
            result = rs.next();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
             DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return result;
    }   
 
 
 
 public java.sql.Date chkDate(Connection conn, String query) {
        Statement st = null;
        java.sql.Date result  = null ;
        ResultSet rs = null;
        
         // java.sql.Date  result = new java.sql.Date(new java.util.Date().getTime());
      //  result ;
               System.out.println(query);
        try {
            st = conn.createStatement();
            rs = st.executeQuery(query);
         rs.next();
         result = rs.getDate(1);
             
          System.out.println("This the date returned from chk date "+ result);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return result;
    }   
 
 
 
  public int getId2(Connection conn, String query) {
        Statement st = null;
        int y = 0;
        System.out.println(query);
        try {
           st = conn.createStatement();
             y =  st.executeUpdate(query);
           //ResultSet rs =  st.executeQuery(query);
          // rs.next();
           
               
          //  y = rs.getInt(1);
           
           
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return y;
    }
 


  public int getId(Connection conn, String query) {
        Statement st = null;
        int i = 0;
        System.out.println(query);
        ResultSet rs = null;
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) { i = rs.getInt(1);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return i;
    }
  public List<String[]> getList4b(Connection conn, String query) {
        Statement st = null;
        List<String[]> list = new ArrayList<String[]>();
        String[] l = null;
        ResultSet rs = null;
        System.out.println(query);
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[4];
               l[0] = rs.getString(1);
               l[1] = rs.getString(2);
               l[2] = rs.getString(3);
               l[3] = rs.getString(4);
               list.add(l);}
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
               DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return list;
    }
 
   public String[] getArrays(Connection conn, String query, int k) {
        Statement st = null;
        String[] l = null;
        ResultSet rs = null;
        try {
           st = conn.createStatement();
           rs =  st.executeQuery(query);
           while (rs.next()) {
               l = new String[k];
                   for (int i = 1; i <= k ; i++) {
                   l[i-1] = rs.getString(i);
               }
               }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
              DbUtil.closeResultSet(rs);
            DbUtil.closeStatement(st);
            DbUtil.closeConnection(conn);
        }
        return l;
    }
 
}
