/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.util.Escalator;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 *
 * @author OYEWOLE
 */

public class ThreadRunner  implements ServletContextListener {

   private Escalator escalator = null;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
      if (escalator == null || (!escalator.isAlive())) {
          escalator = new Escalator();
          System.out.println("now starting the thread");
          escalator.start();
      }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("now stopping the thread");
       escalator.stop();
    }

}
