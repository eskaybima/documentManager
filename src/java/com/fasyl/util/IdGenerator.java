/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.util;

import com.fasyl.newjobBo.SaveToDb;

/**
 *
 * @author Admin
 */
public class IdGenerator {
    public static String generateId(String column) {
        SaveToDb sb = new SaveToDb();
        String id = null;
        int num = sb.getId("select doc_count from fas_int_counter");
        String numToString = String.valueOf(num);
        int length = numToString.length();
        int diff = 9 - length;
        String zeros = "";
        for (int i = 0; i < diff; i++) {
            zeros = zeros + "0";
        }
        int k = num + 1;
        sb.persist("update fas_int_counter set doc_count = '" + k + "'");
        id = zeros + numToString ;
        return id;
    }
    
    public static int generateNumber(String column) {
        String id = null;
        SaveToDb sb = new SaveToDb();
        int num = sb.getId("select " + column + " from fas_int_counter");
        int k = num + 1;
        sb.persist("update fas_int_counter set " + column + " = '" + k + "'");
        return num;
    }
    
}
