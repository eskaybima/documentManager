package com.fasyl.newjobBo;

//import com.LasrraCenRep.util.ConnectionManager;
import com.fasyl.Dao.ConnectionManager;
import com.sun.media.imageioimpl.plugins.jpeg2000.J2KImageReaderSpi;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import javax.imageio.ImageIO;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "PhotoLoaderFile", urlPatterns = {"/PhotoLoaderFile"})
public class PhotoLoaderFile
        extends HttpServlet {
    public SaveToDb sb = new SaveToDb();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getParameter("path");
        String document = request.getParameter("document");
        response.setContentType("image/jpeg");
        ServletOutputStream out = response.getOutputStream();
        HttpSession session = request.getSession(true);
            String applicationId = (String) session.getAttribute("applicationId");
        //String id = request.getParameter("id");
        //ctpv
        path = sb.getValue2("select doc_path from fas_int_documents where document_type = '" + document + "' and ref_id_detl = '" + applicationId + "'");
        path = path.replace("C:ImmArchive", "C:/ImmArchive/");
        File file = new File(path);
        
        System.out.println(">>> THIS IS THE PATH<<<<<<<" + path);
        try {
            //byte[] bytearray = new byte[1048576];
            //int size = 0;
            InputStream photo = new FileInputStream(file);
            response.reset();
            System.out.println(">>>>>>> PHOTO <<<<<<<<<<" + photo);
            //response.setContentType("image/pdf");
             byte[] bytearray = new byte[1048576];
                int size = 0;
            
             while ((size = photo.read(bytearray)) != -1) {
                    response.getOutputStream().write(bytearray, 0, size);
                    response.getOutputStream().flush();
                }
            
            
            //readAndWrite(photo, response);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            out.close();
        }
    }

    public void readAndWrite(InputStream imageByte, HttpServletResponse response)
            throws IOException {
        J2KImageReaderSpi rid = new J2KImageReaderSpi();
        ImageReader imagge = rid.createReaderInstance();
        ImageInputStream ios = ImageIO.createImageInputStream(imageByte);
        imagge.setInput(ios);
        BufferedImage image = imagge.read(0);
        ServletOutputStream out = response.getOutputStream();
        boolean result = ImageIO.write(image, "jpg", out);
        System.out.println("........." + result);
        ios.close();
        out.close();
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
