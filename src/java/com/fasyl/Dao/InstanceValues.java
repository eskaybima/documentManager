/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.Dao;

/**
 *
 * @author Emm
 */
public class InstanceValues {

    private String dbHost = "";
    private String dbPort = "";
    private String dbUser = "";
    private String dbPassword = "";
    private String dbName = "";
    private String testDatabase = "";
    private boolean sendErrorEmail = false;
    private String errorEmail = "";
    private String actualServerName = "";
    static private String fileStorageDirectory = "";
    private String queueHostName = "";
    private static InstanceValues instanceValues;

    public String getDbHost() {
        return dbHost;
    }

    public String getDbPassword() {
        return dbPassword;
    }

    public String getDbPort() {
        return dbPort;
    }

    public String getDbUser() {
        return dbUser;
    }

    public String getDbName() {
        return dbName;
    }

    public String getErrorEmail() {
        return errorEmail;
    }

    public boolean isSendErrorEmail() {
        return sendErrorEmail;
    }

    public static String getFileStorageDirectory() {
        return fileStorageDirectory;
    }

    public String getActualServerName() {
        return actualServerName;
    }

    public String getTestDatabase() {
        return testDatabase;
    }

    public String getQueueHostName() {
        return queueHostName;
    }

    public void setQueueHostName(String queueHostName) {
        this.queueHostName = queueHostName;
    }

    public void setDbHost(String dbHost) {
        this.dbHost = dbHost;
    }

    public void setDbPort(String dbPort) {
        this.dbPort = dbPort;
    }

    public void setDbUser(String dbUser) {
        this.dbUser = dbUser;
    }

    public void setDbPassword(String dbPassword) {
        this.dbPassword = dbPassword;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public void setTestDatabase(String testDatabase) {
        this.testDatabase = testDatabase;
    }

    public void setSendErrorEmail(boolean sendErrorEmail) {
        this.sendErrorEmail = sendErrorEmail;
    }

    public void setErrorEmail(String errorEmail) {
        this.errorEmail = errorEmail;
    }

    public void setActualServerName(String actualServerName) {
        this.actualServerName = actualServerName;
    }

    public void setFileStorageDirectory(String fileStorageDirectory) {
        this.fileStorageDirectory = fileStorageDirectory;
    }

    public static InstanceValues getInstanceValues() {
        return instanceValues;
    }

    public static void setInstanceValues(InstanceValues instanceValues) {
        InstanceValues.instanceValues = instanceValues;
    }

    @Override
    public String toString() {
        return "InstanceValues{" + "host=" + dbHost + ", port=" + dbPort + ", user=" + dbUser +
                ", password=" + dbPassword + ", database=" + dbName + ", testDatabase=" + testDatabase +
                ", VexAppFiles=" + fileStorageDirectory + ", sendErrorEmail=" + sendErrorEmail +
                ", errorEmail=" + errorEmail + ", actualServerName=" + actualServerName + '}';
    }
}