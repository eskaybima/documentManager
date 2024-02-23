/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.vo;

import java.io.Serializable;

/**
 *
 * @author OYEWOLE
 */
public class DocumentLoaderVo implements Serializable{
    
  private String filepath;
  private String docType;
  private String description;
  private String doc_id;
  private String ref_id;
  private String doc_format;

    /**
     * @return the filepath
     */
    public String getFilepath() {
        return filepath;
    }

    /**
     * @param filepath the filepath to set
     */
    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    /**
     * @return the docType
     */
    public String getDocType() {
        return docType;
    }

    /**
     * @param docType the docType to set
     */
    public void setDocType(String docType) {
        this.docType = docType;
    }

    /**
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * @param description the description to set
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * @return the doc_id
     */
    public String getDoc_id() {
        return doc_id;
    }

    /**
     * @param doc_id the doc_id to set
     */
    public void setDoc_id(String doc_id) {
        this.doc_id = doc_id;
    }

    /**
     * @return the ref_id
     */
    public String getRef_id() {
        return ref_id;
    }

    /**
     * @param ref_id the ref_id to set
     */
    public void setRef_id(String ref_id) {
        this.ref_id = ref_id;
    }

    /**
     * @return the doc_format
     */
    public String getDoc_format() {
        return doc_format;
    }

    /**
     * @param doc_format the doc_format to set
     */
    public void setDoc_format(String doc_format) {
        this.doc_format = doc_format;
    }
}
