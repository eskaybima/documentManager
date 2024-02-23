/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.Dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import oracle.jdbc.pool.OracleConnectionCacheManager;
import oracle.jdbc.pool.OracleDataSource;

/**
 *
 * @author Admin
 */
public class ConnectionManager1 {
    
 
    private static Connection conn = null;
    private static InstanceValues iv;
    
    
    public ConnectionManager1 () {
        iv = new InstanceValues();
        Properties prop = new Properties();
        try {
            prop.load(new FileInputStream("C:/ImmigrationArchive/application.properties")); 
        } catch (IOException ex) {
            Logger.getLogger(ConnectionManager1.class.getName()).log(Level.SEVERE, null, ex);
        }
      iv.setDbHost(prop.getProperty("host"));
      iv.setDbPort(prop.getProperty("port"));
      iv.setDbUser(prop.getProperty("user"));
      iv.setDbName(prop.getProperty("dbName"));
      iv.setDbPassword(prop.getProperty("password"));
    }
    
    
    private static Connection loadConnection() {
        Connection connection = null;
        System.out.println("In get connection.");
//        try {
//            System.out.println("About to load driver");
//            Class.forName("com.mysql.jdbc.Driver");
//            System.out.println("Driver loaded.");
//        } catch (ClassNotFoundException ex) {
//            Logger.getLogger(ConnectionManager1.class.getName()).log(Level.SEVERE, null, ex);
//        }    String host = "jdbc:derby://localhost:1527/sample";

        try {
            String url = null;
            System.out.println("SID");
            String businessName = null;
            url = "jdbc:derby://localhost:1527/sample";
            System.out.println("About to make a new connection,, url is " + url);
            
//            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
//            url = "jdbc:oracle:thin:@" + iv.getDbHost() + ":" + iv.getDbPort() + ":" + iv.getDbName();
            
            connection = DriverManager.getConnection(url, "app", "app");
            System.out.println("Connection made.");
        } catch (Exception ex) {
            Logger.getLogger(ConnectionManager1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }


    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                synchronized (ConnectionManager1.class) {
                    if (conn == null || conn.isClosed()) {
                        conn = loadConnection();
                    }
                }
                if (conn == null) {
                    throw new NullPointerException("Cannot make a connection to the database!");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionManager1.class.getName()).log(Level.SEVERE, null, ex);
        }
        return conn;
    }


    public static Connection getNewConnection() {
        return loadConnection();
    }
    
    public void releaseConnection(Connection con) {
        try {

            if (con != null) {
                
                con.close();
                //logger.info("connection closed successfully !");
            }
        } catch (Exception ex) {
            Logger.getLogger(ex.getMessage());
        }
    }
    public static void main(String[] args) {
        getNewConnection();
    }
}
