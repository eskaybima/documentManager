package com.fasyl.vo;

import java.io.Serializable;

public class UserRoleVo implements Serializable {

    private String roleId;
    private String roleName = "N";
    private String adminitration = "N";
    private String resDataUpdating = "N";
    private String resDataEnqury = "N";
    private String enrolReg = "N";
    private String afisIntegration = "N";
    private String cardOperations = "N";
    private String reporting = "N";
    private String hubManagement = "N";
    private int loadCount = 0;
    private static UserRoleVo ROLEVO;

    public static UserRoleVo getROLEVO() {
        return ROLEVO;
    }

    public static void setROLEVO(UserRoleVo ROLEVO) {
        ROLEVO = ROLEVO;
    }

    public int getLoadCount() {
        return this.loadCount;
    }

    public void setLoadCount(int loadCount) {
        this.loadCount = loadCount;
    }

    public String getRoleId() {
        return this.roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return this.roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getAdminitration() {
        return this.adminitration;
    }

    public void setAdminitration(String adminitration) {
        this.adminitration = adminitration;
    }

    public String getResDataUpdating() {
        return this.resDataUpdating;
    }

    public void setResDataUpdating(String resDataUpdating) {
        this.resDataUpdating = resDataUpdating;
    }

    public String getResDataEnqury() {
        return this.resDataEnqury;
    }

    public void setResDataEnqury(String resDataEnqury) {
        this.resDataEnqury = resDataEnqury;
    }

    public String getEnrolReg() {
        return this.enrolReg;
    }

    public void setEnrolReg(String enrolReg) {
        this.enrolReg = enrolReg;
    }

    public String getAfisIntegration() {
        return this.afisIntegration;
    }

    public void setAfisIntegration(String afisIntegration) {
        this.afisIntegration = afisIntegration;
    }

    public String getCardOperations() {
        return this.cardOperations;
    }

    public void setCardOperations(String cardOperations) {
        this.cardOperations = cardOperations;
    }

    public String getReporting() {
        return this.reporting;
    }

    public void setReporting(String reporting) {
        this.reporting = reporting;
    }

    public String getHubManagement() {
        return this.hubManagement;
    }

    public void setHubManagement(String hubManagement) {
        this.hubManagement = hubManagement;
    }

    public String toString() {
        return "UserRoleVo{roleId=" + this.roleId + ", roleName=" + this.roleName + ", adminitration=" + this.adminitration + ", resDataUpdating=" + this.resDataUpdating + ", resDataEnqury=" + this.resDataEnqury + ", enrolReg=" + this.enrolReg + ", afisIntegration=" + this.afisIntegration + ", cardOperations=" + this.cardOperations + ", reporting=" + this.reporting + ", hubManagement=" + this.hubManagement + '}';
    }
}
