/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.fasyl.newjobBo;

import static com.fasyl.newjobBo.HandleUpdateUpload.imagePath;
import com.fasyl.util.IdGenerator;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Admin
 */
public class HandleUpdateUpload {
   static String imagePath;
   
    public static void uploadJob(HttpServletRequest request, HttpServletResponse response, String doc_type, int flow)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        //AfisProcessLoaderDao afd = new AfisProcessLoaderDao();
        //LasAppFileVo lasApp = new LasAppFileVo();
        imagePath = "C://ImmArchive//";
        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");
        
        String documentId = (String) session.getAttribute("documentId");
        String applicationId = null;
        int maxFileSize = 31457280;
        int maxMemSize = 31457280;
      
        
        String contentType = request.getContentType();
        if (contentType.indexOf("multipart/form-data") >= 0) {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxMemSize);
            factory.setRepository(new File("C://"));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxFileSize);
            File file = null;
            try {
                List fileItems = upload.parseRequest(request);
                Iterator i = fileItems.iterator();
                while (i.hasNext()) {
                    FileItem fi = (FileItem) i.next();
                    if (!fi.isFormField()) {
                        System.out.println("hhhhhhhhhhhhhhhhhhh 33  " + fi.getContentType());
                        String fileName = fi.getName();
                        String fileExt = fileName.substring(fileName.indexOf("."), fileName.length());
                        String fieldName = fi.getFieldName();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();
                        
                      /** Addeed by Bayo **/  
                        if ( sizeInBytes > maxMemSize  ) {
                             request.setAttribute("message", "File size in more than allowed size");
                            request.setAttribute("status", "error");
                        } else {


                            if (fileName.lastIndexOf("//") >= 0) {
                                file = new File(imagePath + documentId + fileName.substring(fileName.lastIndexOf("//")));
                            } else {
                                file = new File(imagePath + documentId + fileName.substring(fileName.lastIndexOf("//") + 1));
                            }
                            System.out.println("this is it " + fi.getName());
                            fi.write(file);
                            applicationId = (String) session.getAttribute("applicationId");

                            if (flow == 1) {
                                
                                

                              //    documentId = doc_type + IdGenerator.generateId(column);
                             //   documentId = IdGenerator.generateId(column);
                               // documentId =  doc_type + IdGenerator.generateId("app_form_id");
                                documentId =  doc_type + IdGenerator.generateId(doc_type);
                                String columns = "ref_id_detl, document_type, document_id, approved_status";
                                String values = "'" + applicationId + "','" + doc_type + "', '" + documentId + "', 'U'";
                                String query = "insert into fas_int_documents(" + columns + ") values(" + values + ")";
                                //String query = "insert into fas_int_documents set ref_id_detl = '" + applicationId + "', document_type = '" + doc_type + "', document_id = '" + documentId + "'";                    
                                sb.persist(query);
                                sb.persistImage(file, doc_type, applicationId, 0);
                                List<String> documentUpdate = (List<String>) session.getAttribute("documentUpdates");
                                documentUpdate.add(doc_type);
                            }

                        }
                    }
                }
            } catch (Exception ex) {
                ex.printStackTrace();
            }

    
            String page = null;
            if (flow == 1) {
                page = "/pages/detail_update.jsp";
            } else {
                String column = null;
                switch (doc_type) {
                case "PHOTO":
                    column = "passport_photo_id";
                    break;
                case "FORM":
                    column = "app_form_id";
                    break;
                case "BIRTH":
                    column = "birth_cert_id";
                    break;
                    case "DOCUMENTS":
                        column = "app_form_id";
                        break;
                case "DATA":
                    column = "data_page_id";
                    break;
                    
                    
                    //---------injected to carter for NOTAP Documents------------------------------//
                    
                       case "Tax":  
                    column = "tax_id";
                    doc_type = "Tax Payer Identification Number (TIN)";
                    break;
                case "Evidence_Tax":
                    column = "tax_evence_id";
                    doc_type = "Evidence of Tax payments (Company tax) for the last 3 years";
                    break;
                case "Cert_inco":
                    column = "cert_id";
                    doc_type = "Certificate of incorporation (for new companies)";
                    break;
                case "Annual_audit":
                    column = "annual_aud_id";
                    doc_type = "Annual audited accounts for 3 years";
                    break;
                case "Transferor_Technical":
                    column = "com_prof_id";
                    doc_type = "Profile on Transferor/Technical Partner (Website, Brochure, etc)";
                    break;
                    
                      //-------------------------------------------//
                    
            }
                        
                        documentId = IdGenerator.generateId(column);
                        
             System.out.println("Document id is :"+documentId);
          String columns = "ref_id_detl, document_type, document_id";
          String values = "'"+applicationId +"','" + doc_type + "', '" + documentId + "'";
            String query = "insert into fas_int_documents(" + columns + ") values(" + values + ")";
            //String query = "insert into fas_int_documents set ref_id_detl = '" + applicationId + "', document_type = '" + doc_type + "', document_id = '" + documentId + "'";                    
            sb.persist(query);
            sb.persistImage(file, doc_type, applicationId, flow);
            page = "/pages/correct_detail.jsp";
            List<String> documentUpdate = (List<String>) session.getAttribute("documentUpdates");
                        documentUpdate.add(doc_type);
            }
            
            RequestDispatcher view = request.getRequestDispatcher(page);
            view.forward(request, response);
        }
    }
    
}
