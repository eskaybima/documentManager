/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.NewUpload;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class LoadList {
    
    String query;
    
   
    
    public List<NewUpload> loadNewUpload(String user){
        SaveToDb sb = new SaveToDb();
    List<NewUpload> list = new ArrayList<NewUpload>();
    query = "select ref_id from fas_int_doc where cre_user_id = '"+user+"' and approved_status = 'D'";
    List<String> l = sb.getList2(query);
    for (int i = 0; i < l.size(); i++) {
      NewUpload nu = new NewUpload();
      nu.setRef_id(l.get(i));
      list.add(nu);
    }
    
    return list;    
    }
    
    public List<NewUpload> loadNewRenewal(String user){
    List<NewUpload> list = new ArrayList<NewUpload>();
    SaveToDb sb = new SaveToDb();
    query = "select old_passport_no from fas_int_renewal where cre_user_id = '"+user+"' and approved_status = 'D'";
    //fas_int_renewal 
    List<String> l = sb.getList2(query);
    for (int i = 0; i < l.size(); i++) {
      NewUpload nu = new NewUpload();
      nu.setRef_id(l.get(i));
      list.add(nu);
    }
    
    return list;    
    }
    
    public List<NewUpload> loadDeclinedUpdate(String user){
    List<NewUpload> list = new ArrayList<NewUpload>();
    SaveToDb sb = new SaveToDb();
    query = "select passport_no from fas_update_request where cre_user_id = '"+user+"' and approved_status = 'D'";
    //fas_int_renewal 
    List<String> l = sb.getList2(query);
    for (int i = 0; i < l.size(); i++) {
      NewUpload nu = new NewUpload();
      nu.setRef_id(l.get(i));
      list.add(nu);
    }
    
    return list;    
    }
    
}
