/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.vo;

import java.util.ArrayList;
import java.util.List;


public class ParameterValues {
    
private String parameterName;
private String datatype;
private List<String> dropdownValues = new ArrayList<>();

    /**
     * @return the parameterName
     */
    public String getParameterName() {
        return parameterName;
    }

    /**
     * @param parameterName the parameterName to set
     */
    public void setParameterName(String parameterName) {
        this.parameterName = parameterName;
    }

    /**
     * @return the datatype
     */
    public String getDatatype() {
        return datatype;
    }

    /**
     * @param datatype the datatype to set
     */
    public void setDatatype(String datatype) {
        this.datatype = datatype;
    }

    /**
     * @return the dropdownValues
     */
    public List<String> getDropdownValues() {
        return dropdownValues;
    }

    /**
     * @param dropdownValues the dropdownValues to set
     */
    public void setDropdownValues(List<String> dropdownValues) {
        this.dropdownValues = dropdownValues;
    }

    
    
}
