

package com.fasyl.Dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.util.logging.Level;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

/**
 *
 * @author IT Consultant
 */
public class OracleConnManager {

    private Logger logger = Logger.getLogger(OracleConnManager.class.getName());
    
   private static InstanceValues iv;
   private static String url;
   
 
    
     public OracleConnManager () {
      
        iv = new InstanceValues();
        Properties prop = new Properties();
        try {
           prop.load(new FileInputStream("C:/DocumentManager/application.properties")); 
        } catch (IOException ex) {
            java.util.logging.Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
      iv.setDbHost(prop.getProperty("host"));
      iv.setDbPort(prop.getProperty("port"));
      iv.setDbPassword(prop.getProperty("password"));
      iv.setDbUser(prop.getProperty("user"));
      iv.setDbName(prop.getProperty("dbName"));
    }
 
     public static Connection getConnection()
     {
          Connection  con = null;
        //  String jdbcname = "jdbc/OracleNisConn";
        try {
//           
 //           String url = "";
           DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            url = "jdbc:oracle:thin:@" + iv.getDbHost() + ":" + iv.getDbPort() + ":" + iv.getDbName();
//            System.out.println(".....ayam trying to connect....." + url);
            con = DriverManager.getConnection(url, iv.getDbUser(), iv.getDbPassword());
        
//     DataSource   ds = (DataSource)  new InitialContext().lookup("jdbc/OracleNisConn");
//     con = ds.getConnection();
        } catch (Exception  ex) {
            java.util.logging.Logger.getLogger(OracleConnManager.class.getName()).log(Level.SEVERE, null, ex);
        }
       // this();
        return con;
    }

     
     
    public void releaseConnection(Connection con) {
        try {

            if (con != null) {
                
                con.close();
                con=null;
                logger.info("connection closed successfully !");
            }
        } catch (Exception ex) {
            logger.info(ex.getMessage());
        }
    }
    
    
    
    public void  commitTransaction (Connection con) {
        //boolean isCommited = false;

        try {
            con.commit();
           // isCommited = true;
            System.out.println("ConnectionMgr :: commitTransaction :: Transactions successfully committed");
        } catch (Exception ex) {
            System.out.println("ConnectionMgr :: commitTransaction :: Error Occurred");
            System.out.println(ex.getMessage());
           // isErrorReported = true;
        }

        //return isCommited;
    }
    
    
    
    
    
    
}
