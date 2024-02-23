/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;

/**
 *
 * @author OYEWOLE MORUFF
 */
public class GetRange {
    
    public static String[] retRange(String[] rangeIncoming){
      String[] rangeOutgoing = new String[2];
      int up = 0;
      int lo = 0;
        if (rangeIncoming != null) {
        up = Integer.parseInt(rangeIncoming[0]) + 3;
        lo = Integer.parseInt(rangeIncoming[1]) + 3;
        rangeOutgoing[0] = String.valueOf(up);
        rangeOutgoing[1] = String.valueOf(lo);
        
    } else {
        rangeOutgoing[0] = "1";
        rangeOutgoing[1] = "3"; 
        }
        return rangeOutgoing;
    }
    
    public static String[] retRange2(String[] rangeIncoming){
      String[] rangeOutgoing = new String[2];
      int up = 0;
      int lo = 0;
      System.out.println("....upper ...." + rangeIncoming[1]);
        System.out.println("....lower ...." + rangeIncoming[0]);
        if (rangeIncoming != null) {
         up = Integer.parseInt(rangeIncoming[0]) - 4;
        lo = Integer.parseInt(rangeIncoming[1]) - 3;
        if ((up > 0)&& (lo > 0)) {
        rangeOutgoing[0] = String.valueOf(up);
        rangeOutgoing[1] = String.valueOf(lo);
                } else {
        rangeOutgoing[0] = "1";
        rangeOutgoing[1] = "3"; 
        }
    } else {
        rangeOutgoing[0] = "1";
        rangeOutgoing[1] = "3"; 
        }
        return rangeOutgoing;
    }
    
}
