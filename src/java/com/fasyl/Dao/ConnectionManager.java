/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.Dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class ConnectionManager {
    
 
    private static Connection conn = null;
    private static InstanceValues iv;
    
    
    public ConnectionManager () {
        iv = new InstanceValues();
        Properties prop = new Properties();
        try {
            prop.load(new FileInputStream("C:/DocumentManager/application.properties")); 
        } catch (IOException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            System.out.println("About to load driver");
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Driver loaded.");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            String url = null;
            System.out.println("SID");
            String businessName = null;
            url = "jdbc:mysql://" + iv.getDbHost() + ":" + iv.getDbPort() + "/" + iv.getDbName();
            System.out.println("About to make a new connection,, url is " + url);
            
//            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
//            url = "jdbc:oracle:thin:@" + iv.getDbHost() + ":" + iv.getDbPort() + ":" + iv.getDbName();
            
            connection = DriverManager.getConnection(url, iv.getDbUser(), iv.getDbPassword());
            System.out.println("Connection made.");
        } catch (Exception ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }


    public static Connection getConnection() {
        try {
            if (conn == null || conn.isClosed()) {
                synchronized (ConnectionManager.class) {
                    if (conn == null || conn.isClosed()) {
                        conn = loadConnection();
                    }
                }
                if (conn == null) {
                    throw new NullPointerException("Cannot make a connection to the database!");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ConnectionManager.class.getName()).log(Level.SEVERE, null, ex);
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
    
}
