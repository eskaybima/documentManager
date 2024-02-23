/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.vo;


import com.fasyl.newjobBo.SaveToDb;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author Admin
 */
public class LoadList {

    String query;
    SaveToDb sb;
    
    public List<LoaderVo> loadSharedList(String user) {
        sb = new SaveToDb();
        List<LoaderVo> list = new ArrayList<LoaderVo>();
        query = "select doc_id, shared_by, shared_with, date_shared from fas_doc_share where shared_with = '"+ user +"' order by date_shared desc";
        List<String[]> l = sb.getListss(query, 4);
        for (int i = 0; i < l.size(); i++) {
            LoaderVo lv = new LoaderVo();
            lv.setDoc_id(l.get(i)[0]);
            lv.setShared_by(l.get(i)[1]);
            lv.setShared_with(l.get(i)[2]);
            lv.setDate_shared(l.get(i)[3]);
            list.add(lv);
        }
        return list;
    }
    
   
    
     private String getMonth(String in) {
        String month = null;
        switch (in) {
            case "01":
                month = "JAN";
                break;
            case "02":
                month = "FEB";
                break;
            case "03":
                month = "MAR";
                break;
            case "04":
                month = "APR";
                break;
            case "05":
                month = "MAY";
                break;
            case "06":
                month = "JUN";
                break;
            case "07":
                month = "JUL";
                break;
            case "08":
                month = "AUG";
                break;
            case "09":
                month = "SEP";
                break;
            case "10":
                month = "OCT";
                break;
            case "11":
                month = "NOV";
                break;
            case "12":
                month = "DEC";
                break;
        }
        return month;
    }
    
}
