/*  1:   */ package com.fasyl.newjobBo;
/*  2:   */ 
/*  3:   */ import java.io.IOException;
/*  4:   */ import java.io.PrintStream;
/*  5:   */ import javax.servlet.RequestDispatcher;
/*  6:   */ import javax.servlet.ServletContext;
/*  7:   */ import javax.servlet.ServletException;
/*  8:   */ import javax.servlet.annotation.WebServlet;
/*  9:   */ import javax.servlet.http.HttpServlet;
/* 10:   */ import javax.servlet.http.HttpServletRequest;
/* 11:   */ import javax.servlet.http.HttpServletResponse;
/* 12:   */ import javax.servlet.http.HttpSession;
/* 13:   */ 
/* 14:   */ @WebServlet(name="InvalidateUser", urlPatterns={"/InvalidateUser"})
/* 15:   */ public class InvalidateUser
/* 16:   */   extends HttpServlet
/* 17:   */ {
/* 18:   */   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
/* 19:   */     throws ServletException, IOException
/* 20:   */   {
/* 22:38 */     ServletContext context = getServletContext();
/* 24:40 */     HttpSession hts = request.getSession(false);
/* 26:42 */     if (hts != null)
/* 27:   */     {
/* 29:44 */       hts.invalidate();
/* 30:   */     }
/* 34:49 */     RequestDispatcher rd = context.getRequestDispatcher("/Login.jsp");
/* 35:50 */     rd.forward(request, response);
/* 36:   */   }
/* 37:   */   
/* 38:   */   protected void doGet(HttpServletRequest request, HttpServletResponse response)
/* 39:   */     throws ServletException, IOException
/* 40:   */   {
/* 41:66 */     processRequest(request, response);
/* 42:   */   }
/* 43:   */   
/* 44:   */   protected void doPost(HttpServletRequest request, HttpServletResponse response)
/* 45:   */     throws ServletException, IOException
/* 46:   */   {
/* 47:81 */     processRequest(request, response);
/* 48:   */   }
/* 49:   */   
/* 50:   */   public String getServletInfo()
/* 51:   */   {
/* 52:91 */     return "Short description";
/* 53:   */   }
/* 54:   */ }


/* Location:           H:\lasrracentralregistry\WEB-INF\classes\
 * Qualified Name:     com.LasrraCenRep.client.InvalidateUser
 * JD-Core Version:    0.7.0.1
 */