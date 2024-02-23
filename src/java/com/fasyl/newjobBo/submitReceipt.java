/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.LoaderVo;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Adebayo
 */
@WebServlet(name = "submitReceipt", urlPatterns = {"/submitReceipt"})
public class submitReceipt extends HttpServlet {
      SaveToDb sb = new SaveToDb();
        
    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         response.setContentType("application/json");
        PrintWriter out = response.getWriter();
       // boolean success  = false;
        String success = null;
        HttpSession session = request.getSession(false);
        
        System.out.println("Submit receipt Servlet is  called");
        String amount = request.getParameter("start");
        String taxtype = request.getParameter("end");
        String user_id = (String)session.getAttribute("username");
        taxtype = taxtype.replace("kk", "");
        taxtype = taxtype.replace("_", " ");
        String trans_id = request.getParameter("id").replace("jj", "");

        System.out.println("Amount  sent  is : " + amount);
        System.out.println("Tax type sent is : " + taxtype);
       // insert into fas_int_revenue (id,location,tax_type,amount,year) values (1,'Oyo East','Interest',200000,'2012');
        try {
             String query = "insert into fas_int_revenue (id,location,tax_type,amount,year,user_id, trans_id) values (1,'Oyo East','"+taxtype+"','"+amount+"','2016', '" + user_id + "', '" + trans_id + "')";
             sb.persist(query);    
             
            //query = "select amount_paid, amount_pending from tax_record where user_id ='" + user_id + "' and tax_type ='" + taxtype + "'";
            query = "select amount_paid, amount_pending from tax_record where trans_id ='" + trans_id + "'";
            List<String[]> amtpds = sb.getListss(query, 2);
            double amtpd = 0.00;
            if (amtpds.get(0)[0] == null) {
             amtpds.get(0)[0] = "0.00";
            }
            amtpd = Double.parseDouble(amtpds.get(0)[0]) + Double.parseDouble(amount);
            double amount_pending = Double.parseDouble(amtpds.get(0)[1]) - Double.parseDouble(amount);
            //query = "update tax_record set amount_paid = '" + amtpd + "',  amount_pending ='" +amount_pending+ "' where user_id ='" + (String)session.getAttribute("username") + "' and tax_type ='" + taxtype + "'";
            query = "update tax_record set amount_paid = '" + amtpd + "',  amount_pending ='" +amount_pending+ "' where trans_id ='" + trans_id + "'";
            success = sb.persist(query); 
            //success = true ;
            if("success".equalsIgnoreCase(success)){
              System.out.println("Success");
            } else {
            System.out.println("Failed");
            }
            
            if(amount_pending <= 0.0){
              query = "update tax_record set status = 'paid' where trans_id ='" + trans_id + "'";
              success = sb.persist(query);   
            }
            
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
