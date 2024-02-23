/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.util;

import com.fasyl.newjobBo.SaveToDb;
import static java.lang.Thread.sleep;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author OYEWOLE
 */
public class Escalator extends Thread {
SaveToDb sb = new SaveToDb();
String emailAddress;
    @Override
    public void run() {
       while (true) {
           long timeNow = System.currentTimeMillis();
            List<String[]> allPendings = sb.getListss("select user_id, init_time_sys_mill, ref_id, cre_dt  from FAS_WORK_FLOW where action_status = 'pending' and reminder_sent is null", 4);
           for (String[] allpending : allPendings) {
               if( (timeNow - Long.parseLong(allpending[1])) > 60*60*1000)  {
                   emailAddress = sb.getValue2("select email from fas_mst_users where user_id ='" + allpending[0] + "'");
                   String query = "select email from fas_mst_users where user_id in (select user_auth_id from fas_mst_users where user_id = '" + allpending[0]  + "')";
                   String auth_email = sb.getValue2(query);
                             
                        String send = null ;
                        send = "failed";
                        try  {
                        EmailService mail = new EmailService(); 
                        mail.sendemail(emailAddress, allpending[0], allpending[2], allpending[3], auth_email);
                        send = "success";
                        System.out.println(send);
                        query = "update fas_work_flow set reminder_sent = 'Y' where user_id ='" + allpending[0] + "' and init_time_sys_mill ='" + allpending[1] + "'";
                        sb.persist(query);
                       } catch(Exception e) {
                           System.out.println(send);
                       e.printStackTrace();
                       } 
                    }
               }
           try {
               sleep(60*60*1000);
           } catch (InterruptedException ex) {
               Logger.getLogger(Escalator.class.getName()).log(Level.SEVERE, null, ex);
           }
           }
       }
    }
    
    

