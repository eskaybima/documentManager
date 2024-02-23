/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;
import com.fasyl.Dao.ConnectionManager;
//import com.fasyl.Dao.ConnectionManager1;
import com.fasyl.Dao.DataObject;
import com.fasyl.Dao.OracleConnManager;
import com.fasyl.vo.DocumentLoaderVo;
import com.fasyl.vo.LoaderVo;
//import com.fasyl.vo.LoaderVo;
import java.io.File;
import java.sql.Connection;
import java.util.List;


/**
 *
 * @author Admin
 */
public class SaveToDb {
    OracleConnManager comgr;
   //ConnectionManager comgr = new ConnectionManager();
   Connection conn;
    public  SaveToDb(){
        comgr = new OracleConnManager();
        //conn = comgr.getConnection();
        
    }
    
public  String persist(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
     //OracleConnManager comgr = new OracleConnManager();
   Connection conn = comgr.getConnection();
    String result = null ;
   try{
   result = dob.executeStatement(conn, query);
   } catch (Exception Sql){
   Sql.printStackTrace();
   
   }finally{
   //comgr.commitTransaction(conn);
  // comgr.releaseConnection(conn);
  
   }
   return result ;
}

public  int getId(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
     //OracleConnManager comgr = new OracleConnManager();
      Connection conn = comgr.getConnection();
        int k = 0 ;
      try {
         k  = dob.getNumber(conn, query);
      } catch (Exception Sql){
       System.out.println("out of index error in getListss");
         // Sql.printStackTrace();
      } finally {
     System.out.println("IndexOutOfBoundsException error occured in get id method");
      }
    return k;
    
}

public int getId2(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
     //OracleConnManager comgr = new OracleConnManager();
     Connection conn = comgr.getConnection();
    int k = 0 ;
      try {
         k  = dob.getId2(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
    
}
//ctpv
public  String getValue(String column, String table, String parameter, String value){
    String query = "select " + column + " from " + table + " where " + parameter + " = '" + value + "'";
    DataObject dob = new DataObject();
   //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
    String k = null;
    
      try {
         k  = dob.getValue(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
    
}

public String getValue2(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
  
   String k = null;
    
      try {
         k  = dob.getValue(conn, query);
      } catch (Exception Sql){
       System.out.println("out of index error in getListss");
          //Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
     // comgr.releaseConnection(conn);
          System.out.println("IndexOutOfBoundsException error in method getValue2");
      }
    return k;
}



public  List<String> getList(String column, String table, String parameter, String value){
    String query = "select " + column + " from " + table + " where " + parameter + " = '" + value + "'";
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
  List<String> k = null;
    
      try {
         k  =  dob.getList(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
}


public  List<String> getListedit(String column, String table, String parameter, String value){
    String query = "select " + column + " from " + table + " where " + parameter + " = '" + value + "' and PROCESSED = 'Y' ";
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
  List<String> k = null;
    
      try {
         k  =  dob.getList(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
}




public List<String[]> getListss(String query, int i){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
    List<String[]> k = null;
      try {
         k  =  dob.getListss(conn, query, i);
      } catch (Exception Sql){
       System.out.println("out of index error in getListss");
          //Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
         System.out.println("out of index error in getListss");
      }
      System.out.println("tttttttttttttttttttt " + k.size());
    return k;
}


public List<String> getList2(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
  
     List<String> k = null;
    
      try {
         k  =  dob.getList(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
       System.out.println("Oops something went wrong IndexOutOfBoundsException" );
        //  Sql.printStackTrace();
      }
    return k;
}
//
//public  List<LoaderVo> getLoaderList(String id){
//    DataObject dob = new DataObject();
//    //ConnectionManager comgr = new ConnectionManager();
//    //ConnectionManager1 comgr = new ConnectionManager1();
//    //OracleConnManager comgr = new OracleConnManager();
//    Connection conn = comgr.getConnection();
//   
//    
//        List<LoaderVo> k = null;
//    
//      try {
//         k  =  dob.getLoaderList(conn, id);
//      } catch (Exception Sql){
//       
//          Sql.printStackTrace();
//      } finally {
//      //comgr.commitTransaction(conn);
//      //comgr.releaseConnection(conn);
//      }
//    
//    return k;
//}
 
//public List<LoaderVo> getImageUpdateList(String id){
//    DataObject dob = new DataObject();
//    //ConnectionManager comgr = new ConnectionManager();
//    //ConnectionManager1 comgr = new ConnectionManager1();
//    //OracleConnManager comgr = new OracleConnManager();
//    Connection conn = comgr.getConnection();
//
//    
//       List<LoaderVo> k = null;
//    
//      try {
//         k  =  dob.getImageUpdateList(conn, id);
//      } catch (Exception Sql){
//       
//          Sql.printStackTrace();
//      } finally {
//       //comgr.commitTransaction(conn);    
//      //comgr.releaseConnection(conn);
//      }
//    return k;
//}

public  void persistImage(File file, String docType, String ref_id, int i){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
   Connection conn = comgr.getConnection();
   try{
   dob.saveImage(conn, file, docType, ref_id, i);
   } catch(Exception Sql){
    Sql.printStackTrace();
    
   }finally {
   //comgr.commitTransaction(conn);
  // comgr.releaseConnection(conn);
   }
}

public void saveDocuments(List<DocumentLoaderVo> documentLoaderList, String ref_id){
    DataObject dob = new DataObject();
    Connection conn =  comgr.getConnection();
    try{
   dob.saveDocuments(conn, documentLoaderList, ref_id);
   } catch(Exception Sql){
    Sql.printStackTrace();
    
   }finally {
   //comgr.commitTransaction(conn);
  // comgr.releaseConnection(conn);
   }
}

public  List<String[]> getList3(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
    
    List<String[]> k = null;
    
      try {
         k  =  dob.getList3(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
    //  comgr.releaseConnection(conn);
      }
    return k;
}

public List<String[]> getList5(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
    List<String[]> k = null;
      try {
         k  =  dob.getList5(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
}

public  boolean isAvailable(String query){
    DataObject dob = new DataObject();
    boolean result = false;
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
    
    
       try {
        result  = dob.isAvailable(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
  
       
     
    return result;
}


 public java.sql.Date chkDate(String query) {
       DataObject dob = new DataObject();
     // java.sql.Date  date = new java.sql.Date(new java.util.Date().getTime());
         java.sql.Date  date = null ;
        //OracleConnManager comgr = new OracleConnManager();
       Connection conn = comgr.getConnection();
       
       
        // List<String[]> k = null;
      try {
        date  = dob.chkDate(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
     // comgr.releaseConnection(conn);
      }
  //  return k;
       
       return date;
 }
 
 public List<String[]> getList4(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
   //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
    List<String[]> k = null;
      try {
         k  = dob.getList4(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
}

 public List<String[]> getList4b(String query){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
   //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
    List<String[]> k = null;
      try {
         k  = dob.getList4b(conn, query);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    return k;
}
 
 public String[] getArrays(String query, int i){
    DataObject dob = new DataObject();
    Connection conn = comgr.getConnection();
    String[] k = null;
      try {
         k  =  dob.getArrays(conn, query, i);
      } catch (Exception Sql){
          Sql.printStackTrace();
      } finally {
      }
    return k;
}
 
 
 public  List<LoaderVo> getLoaderList(String id){
    DataObject dob = new DataObject();
    //ConnectionManager comgr = new ConnectionManager();
    //ConnectionManager1 comgr = new ConnectionManager1();
    //OracleConnManager comgr = new OracleConnManager();
    Connection conn = comgr.getConnection();
   
    
        List<LoaderVo> k = null;
    
      try {
         k  =  dob.getLoaderList(conn, id);
      } catch (Exception Sql){
       
          Sql.printStackTrace();
      } finally {
      //comgr.commitTransaction(conn);
      //comgr.releaseConnection(conn);
      }
    
    return k;
}
 
}
