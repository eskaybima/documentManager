/*   1:    */ package com.fasyl.newjobBo;
/*   2:    */ 
/*   3:    */ import java.io.IOException;
/*   4:    */ import java.io.PrintStream;
/*   5:    */ import java.io.PrintWriter;
/*   6:    */ import java.io.StringWriter;
/*   7:    */ import java.util.logging.Level;
/*   8:    */ import java.util.logging.Logger;
/*   9:    */ import javax.servlet.Filter;
/*  10:    */ import javax.servlet.FilterChain;
/*  11:    */ import javax.servlet.FilterConfig;
/*  12:    */ import javax.servlet.ServletContext;
/*  13:    */ import javax.servlet.ServletException;
/*  14:    */ import javax.servlet.ServletOutputStream;
/*  15:    */ import javax.servlet.ServletRequest;
/*  16:    */ import javax.servlet.ServletResponse;
/*  17:    */ import javax.servlet.http.HttpServletRequest;
/*  18:    */ import javax.servlet.http.HttpServletResponse;
/*  19:    */ import javax.servlet.http.HttpSession;
/*  20:    */ 
/*  21:    */ public class GeneralFilter
/*  22:    */   implements Filter
/*  23:    */ {
/*  24:    */   private static final boolean debug = true;
/*  25: 34 */   private static final Logger logger = Logger.getLogger(GeneralFilter.class.getName());
/*  26: 38 */   private FilterConfig filterConfig = null;
/*  27:    */   
/*  28:    */   private void doBeforeProcessing(ServletRequest request, ServletResponse response)
/*  29:    */     throws IOException, ServletException
/*  30:    */   {
/*  31: 49 */     log("GeneralFilter:DoBeforeProcessing");
/*  32:    */   }
/*  33:    */   
/*  34:    */   private void doAfterProcessing(ServletRequest request, ServletResponse response)
/*  35:    */     throws IOException, ServletException
/*  36:    */   {
/*  37: 71 */     log("GeneralFilter:DoAfterProcessing");
/*  38:    */   }
/*  39:    */   
/*  40:    */   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
/*  41:    */     throws IOException, ServletException
/*  42:    */   {
/*  43:109 */     log("GeneralFilter:doFilter()");
/*  44:    */     
/*  45:    */ 
/*  46:112 */     doBeforeProcessing(request, response);
/*  47:113 */     HttpSession hs = ((HttpServletRequest)request).getSession(false);
/*  48:114 */     System.out.println("The session is " + hs);
/*  49:115 */     if (isUserAuthenticated(hs))
/*  50:    */     {
/*  51:116 */       Throwable problem = null;
/*  52:    */       try
/*  53:    */       {
/*  54:118 */         setResponseHeaders(response);
/*  55:119 */         chain.doFilter(request, response);
/*  56:    */       }
/*  57:    */       catch (Throwable t)
/*  58:    */       {
/*  59:124 */         problem = t;
/*  60:125 */         Logger.getLogger(GeneralFilter.class.getName()).log(Level.SEVERE, null, t);
/*  61:126 */         System.out.println("Problem caught!");
/*  62:    */       }
/*  63:129 */       doAfterProcessing(request, response);
/*  64:133 */       if (problem != null)
/*  65:    */       {
/*  66:134 */         if ((problem instanceof ServletException)) {
/*  67:135 */           throw ((ServletException)problem);
/*  68:    */         }
/*  69:137 */         if ((problem instanceof IOException)) {
/*  70:138 */           throw ((IOException)problem);
/*  71:    */         }
/*  72:    */       }
/*  73:    */     }
/*  74:    */     else
/*  75:    */     {
/*  76:142 */       saveUserTarget(request, response);
/*  77:143 */       redirectToHomePage(request, response);
/*  78:    */     }
/*  79:    */   }
/*  80:    */   
/*  81:    */   private void setResponseHeaders(ServletResponse response)
/*  82:    */   {
/*  83:148 */     HttpServletResponse hres = (HttpServletResponse)response;
/*  84:149 */     hres.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
/*  85:150 */     hres.setHeader("Pragma", "no-cache");
/*  86:151 */     hres.setDateHeader("Expires", 0L);
/*  87:    */   }
/*  88:    */   
/*  89:    */   private boolean isUserAuthenticated(HttpSession hs)
/*  90:    */   {
/*  91:155 */     if ((hs == null) || (hs.getAttribute("loggedin") == null) || (((Boolean)hs.getAttribute("loggedin")).booleanValue() != true)) {
/*  92:156 */       return false;
/*  93:    */     }
/*  94:158 */     return true;
/*  95:    */   }
/*  96:    */   
/*  97:    */   private void saveUserTarget(ServletRequest request, ServletResponse response)
/*  98:    */   {
/*  99:163 */     HttpSession hs = ((HttpServletRequest)request).getSession(true);
/* 100:164 */     HttpServletRequest hreq = (HttpServletRequest)request;
/* 101:165 */     HttpServletResponse hres = (HttpServletResponse)response;
/* 102:166 */     hs.setAttribute("target", "?" + hreq.getQueryString());
/* 103:    */   }
/* 104:    */   
/* 105:    */   private void redirectToHomePage(ServletRequest request, ServletResponse response)
/* 106:    */     throws IOException
/* 107:    */   {
/* 108:170 */     HttpServletRequest hreq = (HttpServletRequest)request;
/* 109:171 */     HttpServletResponse hres = (HttpServletResponse)response;
/* 110:172 */     hres.sendRedirect(hreq.getServletContext().getContextPath());
/* 111:    */   }
/* 112:    */   
/* 113:    */   public FilterConfig getFilterConfig()
/* 114:    */   {
/* 115:180 */     return this.filterConfig;
/* 116:    */   }
/* 117:    */   
/* 118:    */   public void setFilterConfig(FilterConfig filterConfig)
/* 119:    */   {
/* 120:189 */     this.filterConfig = filterConfig;
/* 121:    */   }
/* 122:    */   
/* 123:    */   public void destroy() {}
/* 124:    */   
/* 125:    */   public void init(FilterConfig filterConfig)
/* 126:    */   {
/* 127:203 */     this.filterConfig = filterConfig;
/* 128:204 */     if (filterConfig != null) {
/* 129:206 */       log("GeneralFilter:Initializing filter");
/* 130:    */     }
/* 131:    */   }
/* 132:    */   
/* 133:    */   public String toString()
/* 134:    */   {
/* 135:216 */     if (this.filterConfig == null) {
/* 136:217 */       return "GeneralFilter()";
/* 137:    */     }
/* 138:219 */     StringBuffer sb = new StringBuffer("GeneralFilter(");
/* 139:220 */     sb.append(this.filterConfig);
/* 140:221 */     sb.append(")");
/* 141:222 */     return sb.toString();
/* 142:    */   }
/* 143:    */   
/* 144:    */   private void sendProcessingError(Throwable t, ServletResponse response)
/* 145:    */   {
/* 146:226 */     String stackTrace = getStackTrace(t);
/* 147:228 */     if ((stackTrace != null) && (!stackTrace.equals(""))) {
/* 148:    */       try
/* 149:    */       {
/* 150:230 */         response.setContentType("text/html");
/* 151:231 */         PrintStream ps = new PrintStream(response.getOutputStream());
/* 152:232 */         PrintWriter pw = new PrintWriter(ps);
/* 153:233 */         pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n");
/* 154:    */         
/* 155:    */ 
/* 156:236 */         pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
/* 157:237 */         pw.print(stackTrace);
/* 158:238 */         pw.print("</pre></body>\n</html>");
/* 159:239 */         pw.close();
/* 160:240 */         ps.close();
/* 161:241 */         response.getOutputStream().close();
/* 162:    */       }
/* 163:    */       catch (Exception ex) {}
/* 164:    */     } else {
/* 165:    */       try
/* 166:    */       {
/* 167:246 */         PrintStream ps = new PrintStream(response.getOutputStream());
/* 168:247 */         t.printStackTrace(ps);
/* 169:248 */         ps.close();
/* 170:249 */         response.getOutputStream().close();
/* 171:    */       }
/* 172:    */       catch (Exception ex) {}
/* 173:    */     }
/* 174:    */   }
/* 175:    */   
/* 176:    */   public static String getStackTrace(Throwable t)
/* 177:    */   {
/* 178:261 */     String stackTrace = null;
/* 179:    */     try
/* 180:    */     {
/* 181:263 */       StringWriter sw = new StringWriter();
/* 182:264 */       PrintWriter pw = new PrintWriter(sw);
/* 183:265 */       t.printStackTrace(pw);
/* 184:266 */       pw.close();
/* 185:267 */       sw.close();
/* 186:268 */       stackTrace = sw.getBuffer().toString();
/* 187:    */     }
/* 188:    */     catch (Exception ex) {}
/* 189:271 */     return stackTrace;
/* 190:    */   }
/* 191:    */   
/* 192:    */   public void log(String msg)
/* 193:    */   {
/* 194:279 */     this.filterConfig.getServletContext().log(msg);
/* 195:    */   }
/* 196:    */   
/* 197:    */   public static void main(String[] args)
/* 198:    */   {
/* 199:287 */     System.out.println((Boolean)null);
/* 200:    */   }
/* 201:    */ }


/* Location:           H:\lasrracentralregistry\WEB-INF\classes\
 * Qualified Name:     com.LasrraCenRep.client.GeneralFilter
 * JD-Core Version:    0.7.0.1
 */