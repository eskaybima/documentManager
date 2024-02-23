package com.fasyl.vo;

import java.io.Serializable;
import java.util.Date;

public class UserVo implements Serializable {

    private String id;
    private String password;
    private String roleId;
    private String firstName;
    private String middleName;
    private Date dateCreated;
    private String lastName;
    private String phoneNumber;
    private String email;
    private String active = "Y";
    private String gender;
    private String address;
    private String userName;
    private String resetPassword;
    private String locationId;
    private String authorizer;
    private String location;
    private String role;

    public String getResetPassword() {
        return this.resetPassword;
    }

    public void setResetPassword(String resetPassword) {
        this.resetPassword = resetPassword;
    }

    public boolean checkParam(String a) {
        a = null;
        if (a.equalsIgnoreCase("Y")) {
            return true;
        }
        return false;
    }

    public String getId() {
        return this.id;
    }

    public String getUserName() {
        return this.userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return this.password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRoleId() {
        return this.roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public String getFirstName() {
        return this.firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public Date getDateCreated() {
        return this.dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhoneNumber() {
        return this.phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getActive() {
        return this.active;
    }

    public void setActive(String active) {
        this.active = active;
    }

    public String getGender() {
        return this.gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean hasPermission(String perm) {
        if (perm.equals("Y")) {
            return true;
        }
        return false;
    }

    public String toString() {
        return "UserVo{id=" + this.id + ", password=" + this.password+ ", roleId=" + this.roleId + ", firstName=" + this.firstName + ",dateCreated=" + this.dateCreated + ", lastName=" + this.lastName + ",phoneNumber=" + this.phoneNumber + ", email=" + this.email + ",active=" + this.active + ", gender=" + this.gender + ", address=" +this.address + ", userName=" + this.userName + '}';
    }

    /**
     * @return the middleName
     */
    public String getMiddleName() {
        return middleName;
    }

    /**
     * @param middleName the middleName to set
     */
    public void setMiddleName(String middleName) {
        this.middleName = middleName;
    }

    /**
     * @return the locationId
     */
    public String getLocationId() {
        return locationId;
    }

    /**
     * @param locationId the locationId to set
     */
    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    /**
     * @return the authorizer
     */
    public String getAuthorizer() {
        return authorizer;
    }

    /**
     * @param authorizer the authorizer to set
     */
    public void setAuthorizer(String authorizer) {
        this.authorizer = authorizer;
    }

    /**
     * @return the location
     */
    public String getLocation() {
        return location;
    }

    /**
     * @param location the location to set
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * @return the role
     */
    public String getRole() {
        return role;
    }

    /**
     * @param role the role to set
     */
    public void setRole(String role) {
        this.role = role;
    }
}