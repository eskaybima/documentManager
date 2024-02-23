package com.fasyl.newjobBo;

//import com.LasrraCenRep.dao.AfisProcessLoaderDao;
//import com.LasrraCenRep.vo.LasAppFileVo;
import com.fasyl.newjobBo.*;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
//import org.apache.log4j.Logger;

@WebServlet(name = "CorrectSTATE", urlPatterns = {"/CorrectSTATE"})
public class CorrectSTATE
        extends HttpServlet {

    //String doc_type = "DOCUMENTS";
    
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession(true);
         String doc_type =  (String)session.getAttribute("currentImage");
         System.out.println("Doc_type sent is :" +doc_type);
         HandleUpdateUpload.uploadJob(request, response, doc_type, 0);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }

}
