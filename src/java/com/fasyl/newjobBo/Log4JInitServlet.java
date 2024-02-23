/*   1:    */ package com.fasyl.newjobBo;
/*   2:    */ 
/*   3:    */ import java.io.File;
/*   4:    */ import java.io.IOException;
/*   5:    */ import java.io.PrintStream;
/*   6:    */ import java.io.PrintWriter;
/*   7:    */ import javax.servlet.ServletConfig;
/*   8:    */ import javax.servlet.ServletContext;
/*   9:    */ import javax.servlet.ServletException;
/*  10:    */ import javax.servlet.annotation.WebServlet;
/*  11:    */ import javax.servlet.http.HttpServlet;
/*  12:    */ import javax.servlet.http.HttpServletRequest;
/*  13:    */ import javax.servlet.http.HttpServletResponse;
/*  14:    */ import org.apache.log4j.BasicConfigurator;
/*  15:    */ import org.apache.log4j.PropertyConfigurator;
/*  16:    */ 
/*  17:    */ @WebServlet(name="Log4JInitServlet1", urlPatterns={"/Log4JInitServlet1"})
/*  18:    */ public class Log4JInitServlet
/*  19:    */   extends HttpServlet
/*  20:    */ {
/*  21:    */   public void init(ServletConfig config)
/*  22:    */     throws ServletException
/*  23:    */   {
/*  24: 39 */     System.out.println("Log4jInitServlet is initializing log4j");
/*  25: 40 */     String log4jLocation = config.getInitParameter("log4j-properties-location");
/*  26: 41 */     ServletContext sc = config.getServletContext();
/*  27: 43 */     if (log4jLocation == null)
/*  28:    */     {
/*  29: 44 */       System.out.println("No log4j properties-location therefore initializing with basic configurator");
/*  30:    */     }
/*  31:    */     else
/*  32:    */     {
/*  33: 46 */       String webAppPath = sc.getRealPath("/");
/*  34: 47 */       String log4jProp = webAppPath + log4jLocation;
/*  35: 48 */       File f = new File(log4jProp);
/*  36: 49 */       if (f.exists())
/*  37:    */       {
/*  38: 50 */         System.out.println("Initializing log4j with:" + log4jProp);
/*  39: 51 */         PropertyConfigurator.configure(log4jProp);
/*  40:    */       }
/*  41:    */       else
/*  42:    */       {
/*  43: 53 */         System.out.println(log4jProp + " file not found, so initializing log4j with BasicConfigurator");
/*  44: 54 */         BasicConfigurator.configure();
/*  45:    */       }
/*  46:    */     }
/*  47: 57 */     super.init(config);
/*  48:    */   }
/*  49:    */   
/*  50:    */   protected void processRequest(HttpServletRequest request, HttpServletResponse response)
/*  51:    */     throws ServletException, IOException
/*  52:    */   {
/*  53: 62 */     response.setContentType("text/html;charset=UTF-8");
/*  54: 63 */     PrintWriter out = response.getWriter();
/*  55:    */     try
/*  56:    */     {
/*  57: 66 */       out.println("<!DOCTYPE html>");
/*  58: 67 */       out.println("<html>");
/*  59: 68 */       out.println("<head>");
/*  60: 69 */       out.println("<title>Servlet Log4JInitServlet</title>");
/*  61: 70 */       out.println("</head>");
/*  62: 71 */       out.println("<body>");
/*  63: 72 */       out.println("<h1>Servlet Log4JInitServlet at " + request.getContextPath() + "</h1>");
/*  64: 73 */       out.println("</body>");
/*  65: 74 */       out.println("</html>");
/*  66:    */     }
/*  67:    */     finally
/*  68:    */     {
/*  69: 76 */       out.close();
/*  70:    */     }
/*  71:    */   }
/*  72:    */   
/*  73:    */   protected void doGet(HttpServletRequest request, HttpServletResponse response)
/*  74:    */     throws ServletException, IOException
/*  75:    */   {
/*  76: 93 */     processRequest(request, response);
/*  77:    */   }
/*  78:    */   
/*  79:    */   protected void doPost(HttpServletRequest request, HttpServletResponse response)
/*  80:    */     throws ServletException, IOException
/*  81:    */   {
/*  82:108 */     processRequest(request, response);
/*  83:    */   }
/*  84:    */   
/*  85:    */   public String getServletInfo()
/*  86:    */   {
/*  87:118 */     return "Short description";
/*  88:    */   }
/*  89:    */ }


/* Location:           H:\lasrracentralregistry\WEB-INF\classes\
 * Qualified Name:     com.LasrraCenRep.client.Log4JInitServlet
 * JD-Core Version:    0.7.0.1
 */