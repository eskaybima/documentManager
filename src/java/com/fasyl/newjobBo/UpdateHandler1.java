
package com.fasyl.newjobBo;

//import com.fasyl.vo.Section6;
//import com.fasyl.vo.Section7;
//import com.fasyl.vo.TransferVo;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UpdateHandler1", urlPatterns = {"/UpdateHandler1"})
public class UpdateHandler1 extends HttpServlet {

     
private SaveToDb sb = new SaveToDb();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
      String fileView = request.getParameter("fileView");
          InputStream photo = null;
            if (fileView != null) {
               response.setContentType("application/pdf");
               //photo = getImageFromFile(fileView);
               PrintWriter out = response.getWriter();
        response.setContentType("application/pdf");
        try  {
            out.println("<!DOCTYPE pdf>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PDFLoader</title>");            
            out.println("</head>");
            out.println("<body>");
         //   String imagepath ="C:/ImmArchive/" + fileView;
             // String imagepath  = System.getProperty("user.home")+"/imageArchive"+"/"+ fileView;
             String osname = System.getProperty("os.name", "").toLowerCase();
                String imagepath = "";
        if (osname.startsWith("windows")) {
            String text = "Hello world Windows";
            System.out.println(text);
              imagepath ="C:/ImmArchive/" + fileView;             
            } else if (osname.startsWith("linux")) {
               imagepath  = "/home/notapuser/imageArchive"+"/"+ fileView;
              }
            photo = new FileInputStream(imagepath);
            response.reset();
             byte[] bytearray = new byte[31457280];
                int size = 0;
             while ((size = photo.read(bytearray)) != -1) {
                    response.getOutputStream().write(bytearray, 0, size);
                    response.getOutputStream().flush();
                } 
        }  catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            out.close();
        }
      }
           
  }     
     
}
