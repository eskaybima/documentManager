/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;

import com.fasyl.vo.LoaderVo;

/**
 *
 * @author Admin
 */
public class LoadValues {
    
     public static String[] loadValues(String applicationId) {
         SaveToDb sb = new SaveToDb();
        String table = "fas_int_doc";
        String table2 = "fas_int_documents";
        String parameter = "ref_id";
         String parameter2 = "ref_id_detl";
        String[] values = new String[16]; //ctpv
        values[0] = sb.getValue("passport_no", table, parameter, applicationId);
        values[1] = sb.getValue("surname", table, parameter, applicationId);
        if (values[1] == null) { values[1] = "";}
        values[2] = sb.getValue("first_name", table, parameter, applicationId);
        if (values[2] == null) { values[2] = "";}
        values[3] = sb.getValue("middle_name", table, parameter, applicationId);
        if (values[3] == null) { values[3] = "";}
        values[4] = sb.getValue("state", table, parameter, applicationId);
        if (values[4] == null) { values[4] = "";}
        values[5] = sb.getValue("dob", table, parameter, applicationId);
        values[6] = sb.getValue("sex", table, parameter, applicationId);
        if (values[6] == null) { values[6] = "";}
        values[7] = sb.getValue("country", table, parameter, applicationId);
        if (values[7] == null) { values[7] = "";}
        values[8] = sb.getValue("document_id", table2, parameter2, applicationId);
        values[9] = applicationId;
        values[10] = sb.getValue("comments", table, parameter, applicationId);
        values[11] = sb.getValue("cre_user_id", table, parameter, applicationId);
        values[12] = sb.getValue("passport_category", table, parameter, applicationId);
        values[13] = sb.getValue("Marital_status", table, parameter, applicationId);
        values[14] = sb.getValue("enrol_no", table, parameter, applicationId);
        values[15] = sb.getValue("title", table, parameter, applicationId);
        return values;
    }
     
     public static LoaderVo initiateLoader(LoaderVo lv){
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
//         lv.setParam1("");
         
      return lv;
     }
     
     public static LoaderVo loadUpdateValues(String transNo) {
        LoaderVo lv = new LoaderVo(); 
        SaveToDb sb = new SaveToDb();
        String table = "fas_update_request";
        String parameter = "trans_no";
//        lv.setParam1(sb.getValue("passport_no", table, parameter, transNo));
//        lv.setParam1(sb.getValue("surname", table, parameter, transNo));
//        lv.setParam1(sb.getValue("first_name", table, parameter, transNo));
//        lv.setParam1(sb.getValue("middle_name", table, parameter, transNo));
//        lv.setParam1(sb.getValue("state", table, parameter, transNo));
//        lv.setParam1(sb.getValue("dob", table, parameter, transNo));
//        lv.setParam1(sb.getValue("sex", table, parameter, transNo));
//        lv.setParam1(sb.getValue("country", table, parameter, transNo));
//        lv.setParam1(sb.getValue("local_govt", table, parameter, transNo));
//        lv.setParam1(transNo);
//        lv.setRef_id(sb.getValue("ref_id", table, parameter, transNo));
//        lv.setParam1(sb.getValue("passport_category", table, parameter, transNo));
//        lv.setParam1(sb.getValue("Marital_status", table, parameter, transNo));
//        lv.setParam1(sb.getValue("title", table, parameter, transNo));
//        lv.setParam1(sb.getValue("enrol_no", table, parameter, transNo));
        return lv;
    }
     
    public static LoaderVo processValues(LoaderVo lv) {
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//           lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//        
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
//       
//        if (lv.getParam1() == "") {
//            lv.setParam1(null);
//        }
        return lv;
    }
}
