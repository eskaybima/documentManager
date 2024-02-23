// Amount formater. Exclusively designed by DrMuphy

package com.fasyl.util;

import com.fasyl.newjobBo.SaveToDb;
import java.util.ArrayList;
import java.util.List;

public class FormatAmount {

  static SaveToDb sb = new SaveToDb();
    public static String formatAmount(String amount) {
      
        List<String> holder = new ArrayList<>();
        
        if (amount != null) {
        amount = amount.replace(",", "");
        int k = 0;
        if (amount.contains(".")) {
         k = amount.length() - 3;
        } else {
          k = amount.length();  
        }
        String dec = amount.substring(k, amount.length());
        int j = 0;
        for (int i = k; i >= 0; i--) {
            j++;
            if (i == 0) {
                break;
            }
            holder.add(String.valueOf(amount.charAt(i - 1)));
            if (j == 3) {
                holder.add(",");
                j = 0;
            }
        }
        int h = holder.size();
        String res = "";
        for (int z = h; z >= 0; z--) {
            if (z <= 0) {
                break;
            }
            res = res + holder.get(z - 1);
        }
        res = res + dec;
        
          if (res.startsWith(",")) {
           res = res.replaceFirst(",", "");
        }

        return res;
        } else {
            return "";
        }
    }
    
 public static String getPendingAmtForUser(String user){
  String amtPending = " select sum(amount_pending) from tax_record where status = 'pending' and user_id ='" + user + "'";
   amtPending = sb.getValue2(amtPending);
  return formatAmount(amtPending);
 }   
 
  public static int getNumberOfSubmissions(String user){
  List<String> templates = sb.getList2("select template_name from template_names");
   int kount = 0;
   for (int i =0; i < templates.size(); i++) {
                    kount = kount + sb.getId("select count(*) from " + templates.get(i)+ " where uploaded_by ='" + user + "'");
                 }
  return kount;
 }   
  
  public static int getNumberOfApproved(String user){
  List<String> templates = sb.getList2("select template_name from template_names");
   int kount = 0;
   for (int i =0; i < templates.size(); i++) {
                    kount = kount + sb.getId("select count(*) from " + templates.get(i)+ " where uploaded_by ='" + user + "' and approved_status = 'A'");
                 }
  return kount;
 }   
  
   public static int getNumberOfDeclined(String user){
  List<String> templates = sb.getList2("select template_name from template_names");
   int kount = 0;
   for (int i =0; i < templates.size(); i++) {
                    kount = kount + sb.getId("select count(*) from " + templates.get(i)+ " where uploaded_by ='" + user + "' and approved_status = 'D'");
                 }
  return kount;
 }   
 
}
