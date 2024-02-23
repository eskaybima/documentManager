package com.fasyl.newjobBo;

import com.fasyl.util.IdGenerator;
import com.fasyl.vo.DocumentLoaderVo;
import com.fasyl.vo.LoaderVo;
import java.io.File;
import java.io.FileInputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
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
//import org.apache.log4j.Logger;

@WebServlet(name = "ImageUpload", urlPatterns = {"/ImageUpload"})
public class ImageUpload
        extends HttpServlet {

    String passportNumber = null;
    String surname = null;
    String firstname = null;
    String middlename = null;
    String dob = null;
    String state = null;
    String sex = null;
    String country = null;
    String category = null;
    String[] dir;
    String imagePath;
    String nextDocument;
    File f;
    List<String> paths;
    String delete = null;
    String skipDoc = null;
    String renewal;
    String mar_status;
    String enrolNo;
    String title;
    List<String[]> paramsList;
    HttpSession session;
    //static Logger log = Logger.getLogger(AfisJobSubmitConfirmNPS.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String delete = request.getParameter("delete");
        String submit = request.getParameter("done");
        String scan = request.getParameter("scan");
        String uploadType = request.getParameter("uploadType");
        passportNumber = request.getParameter("passportNumber");
        skipDoc = request.getParameter("skipdoc");
        renewal = request.getParameter("renewal");
        session = request.getSession(true);
        paramsList = (List<String[]>) session.getAttribute("paramsList");
        String fileView = request.getParameter("fileView");

        if (delete != null) {
            deleteJob(request, response);
        } else if (submit != null) {
            submit(request, response);
        } else if (uploadType != null) {
            selectUploadType(request, response);
        } else if (renewal != null) {
            doRenewal(request, response);
        } else if (fileView != null) {
            InputStream photo = null;
            if (fileView != null) {
                response.setContentType("application/pdf");
                //photo = getImageFromFile(fileView);
                PrintWriter out = response.getWriter();
                response.setContentType("application/pdf");
                try {
                    out.println("<!DOCTYPE pdf>");
                    out.println("<html>");
                    out.println("<head>");
                    out.println("<title>Servlet PDFLoader</title>");
                    out.println("</head>");
                    out.println("<body>");
                    // File imageArchive = new File(System.getProperty("user.home")+"/imageArchive"); // just added
                    String osname = System.getProperty("os.name", "").toLowerCase();
                    String imagepath = "";
                    File imageArchive = null;
                    if (osname.startsWith("windows")) {
                        String text = "Hello world Windows";
                        System.out.println(text);
                        try {

                            imageArchive = new File("C:/ImmArchive/");
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } else if (osname.startsWith("linux")) {
                        String text = "Hello world Linux";
                        System.out.println(text);
                        try {
                            imageArchive = new File("/home/notapuser/imageArchive");
                            imageArchive.mkdir();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                    // String imagepath ="C:/ImmArchive/" + fileView;
                    imagepath = imageArchive.getPath() + "/" + fileView;   // just added
                    photo = new FileInputStream(imagepath);
                    response.reset();
                    byte[] bytearray = new byte[31457280];
                    int size = 0;
                    while ((size = photo.read(bytearray)) != -1) {
                        response.getOutputStream().write(bytearray, 0, size);
                        response.getOutputStream().flush();
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                } finally {
                    out.close();
                }
            }
        } 
//        else {
//            uploadJob(request, response);
//        }
    }

    protected void uploadJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        SaveToDb sb = new SaveToDb();
        imagePath = "C://ImmArchive//";
        //HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");
        String docDesc = (String) session.getAttribute("docDesc");
        String currentImage = (String) session.getAttribute("currentImage");;

        String query = "";
        String documentId = (String) session.getAttribute("documentId");
        String applicationId = (String) session.getAttribute("applicationId");
        query = "insert into fas_int_documents (ref_id_detl, document_type, document_id)  values ('" + applicationId + "', '" + currentImage + "', '" + documentId + "')";
        sb.persist(query);
        session.setAttribute("currentImage", docDesc);
        int maxFileSize = 31457280;
        int maxMemSize = 31457280;
        String contentType = request.getContentType();
        if (skipDoc == null) {
            if (contentType.indexOf("multipart/form-data") >= 0) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(maxMemSize);
                factory.setRepository(new File("C://"));
                ServletFileUpload upload = new ServletFileUpload(factory);
                upload.setSizeMax(maxFileSize);
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
                            File file;
                            if (fileName.lastIndexOf("//") >= 0) {
                                file = new File(imagePath + documentId);
                            } else {
                                file = new File(imagePath + documentId);
                            }
                            System.out.println("this is it " + fi.getName());
                            fi.write(file);
                            sb.persistImage(file, currentImage, applicationId, 0);
                            sb.persist("update fas_int_documents set doc_path = '" + file.getPath() + "' where document_id = '" + documentId + "'");
                            if (docDesc == null) {
                                loadAndForward(request, response, "jspPage.jsp");
                            } else {
                                loadAndForward(request, response, "renewal.jsp");
                            }
                        }
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    // log.info(new Date().toString() + " : " + ex.getMessage());
                }
            }
        } else {
            sb.persist("update fas_int_documents set doc_path = 'NOT AVAILABLE' where document_id = '" + documentId + "'");
            loadAndForward(request, response, "scanner_new_job");
        }

    }

    private String[] loadValues(String applicationId) {
        String table = "fas_int_doc";
        String parameter = "ref_id";
        int k = paramsList.size();
        SaveToDb sb = new SaveToDb();
        String query = "select ";
        for (int i = 0; i < paramsList.size(); i++) {
            query = query + "\n" + paramsList.get(i)[1] + " ,";
        }
        query = query + "\nref_id from fas_int_document where ref_id ='" + applicationId + "'";
        List<String[]> ans = sb.getListss(query, k + 1);
        return ans.get(0);
    }

    public static String[] listDirectory(String path) {
        File file = new File(path);
        String[] directories = file.list(new FilenameFilter() {
            public boolean accept(File dir, String name) {
                return new File(dir, name).isDirectory();
            }
        });
        return directories;
    }

    protected void submit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        String applicationId = (String) session.getAttribute("applicationId");
        String user = (String) session.getAttribute("username");
        String template = request.getParameter("template");
        String query = "";
        LoaderVo lv = (LoaderVo) session.getAttribute("LoaderVo");
        if (lv != null) {
            if (lv.getControl().equalsIgnoreCase("NEW")) {
                String valuesString = "ref_id, ";
                for (int i = 0; i < paramsList.size(); i++) {
                    valuesString = valuesString + paramsList.get(i)[1] + ", ";
                }
                valuesString = valuesString + "status, uploaded_by, control";
                String columnsString = "'" + lv.getRef_id() + "', ";
                for (int i = 0; i < paramsList.size(); i++) {
                    columnsString = columnsString + "'" + paramsList.get(i)[0] + "', ";
                }
                columnsString = columnsString + "'N','" + user + "', 'control'";
                query = "insert into " + template.replace(" ", "_") + " (" + valuesString + ") values (" + columnsString + ")";

                List<DocumentLoaderVo> documentLoaderList = (List<DocumentLoaderVo>) session.getAttribute("documentLoaderList");
                sb.saveDocuments(documentLoaderList, lv.getRef_id());
                
                template =  template.replace(" ", "_");
                if (!sb.isAvailable("select * from " + template + " where ref_id = '" + lv.getRef_id() + "'")) {
                    sb.persist(query);
                    query = "insert into template_id(REF_ID, TEMPLATE, APPROVED_STATUS) values('" + lv.getRef_id() + "', '" + template + "', 'N')";
                    sb.persist(query);
                    String temp_auth_level = template+"tmpauthlv1";
                    String auth1 = sb.getValue2("select user_member from fas_work_flow_define where temp_auth_level = '" + temp_auth_level +  "'");
                    Timestamp ts = new Timestamp(System.currentTimeMillis());
                    query = "insert into fas_work_flow (ref_id, user_id, auth_level,  action_status, temp_auth_level, init_time_sys_mill) values('" + lv.getRef_id() + "', '" + auth1 +"', '1', 'pending', '" + temp_auth_level + "', '" + System.currentTimeMillis() + "')";
                    sb.persist(query);
                }
            } else {
                sb.persist(query);

                query = "insert into template_id values('" + lv.getRef_id() + "', '" + template.replace(" ", "_") + "')";
                sb.persist(query);
            }
        }
        session.setAttribute("applicationId", null);
        request.setAttribute("passportNumber", "");
        request.setAttribute("surname", "");
        request.setAttribute("firstname", "");
        request.setAttribute("middlename", "");
        request.setAttribute("state", "");
        request.setAttribute("dob", "");
        request.setAttribute("title", "");
        request.setAttribute("offset", "finish");
        session.setAttribute("LoaderVo", null);
        request.setAttribute("message", "Upload Successful");
        request.setAttribute("status", "Success");

        String page = "/pages/upload_type.jsp";
        if (request.getParameter("renewal") != null) {
            page = "/pages/homepage.jsp";
        }
        session.setAttribute("docDesc", null);
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    protected void selectUploadType(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        session.setAttribute("docDesc", null);
        String page = null;
        request.setAttribute("start", "start");
        String uploadType = request.getParameter("uploadType");
        String loc_code = (String) session.getAttribute("loc_code");
        Date cre_date = new Date(System.currentTimeMillis());
        String loc = (String) session.getAttribute("location");
        String applicationId = null;
        applicationId = loc_code;
        String id = IdGenerator.generateId("ref_id");
        applicationId = applicationId + id;
        System.out.println("......... " + applicationId);
        session.setAttribute("applicationId", applicationId);
        String user = (String) session.getAttribute("username");
        LoaderVo lv = new LoaderVo();

        List<DocumentLoaderVo> docList = new ArrayList<>();
        session.setAttribute("documentLoaderList", docList);

        List<String[]> paramsList = new ArrayList<>();
        lv.setRef_id(applicationId);
        lv.setControl("NEW");
        session.setAttribute("paramsList", paramsList);
        session.setAttribute("LoaderVo", lv);
        List<String> imageList = new ArrayList<>();
        session.setAttribute("imageList", imageList);
        request.setAttribute("nextDocument", "APPLICATION DOCUMENTS");
        if (uploadType.equalsIgnoreCase("folder")) {
            page = "/pages/folder_new_job.jsp";
        } else {
            String template = request.getParameter("template");
			System.out.println("template name is  :"+template); 
            int version = new SaveToDb().getId("select version_no from template_names where template_name ='" + template + "'");
            session.setAttribute("template", template);

            if (version > 1) {
                page = "/pages/" + template + "_" + version + ".jsp";
            } else {
                page = "/pages/" + template + ".jsp";
            }
			
			//System.out.println("path is  ;" +page)
        }
        ServletContext context = getServletContext();
        RequestDispatcher rd = context.getRequestDispatcher(page);
        rd.forward(request, response);
    }

    protected void deleteJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        HttpSession session = request.getSession(true);
        String document_type = request.getParameter("document_type");
        String document_description = null;
        String applicationId = (String) session.getAttribute("applicationId");
        String result = sb.persist("delete  from fas_int_documents where document_type = '" + document_type + "' and ref_id_detl = '" + applicationId + "'");
        if (result.equalsIgnoreCase("success")) {
            List<String> input = (List<String>) session.getAttribute("imageList");
            List<String> output = new ArrayList<>();

            List<String> list = sb.getList2("select document_type from fas_int_documents where ref_id_detl ='" + applicationId + "'");

            for (int i = 0; i < input.size(); i++) {
                if (!input.get(i).contains(document_type)) {
                    output.add(input.get(i));
                }
            }

            session.setAttribute("imageList", output);
        }
        loadAndForward(request, response, "jspPage.jsp");

    }

    private void delete(String path) {
        File file = new File(path);
        file.delete();
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

    protected void viewDocument(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public List<String> getUploadedImages(String applicationId) {
        SaveToDb sb = new SaveToDb();
        List<String> list = sb.getList("document_type", "fas_int_documents", "ref_id_detl", applicationId);
        return list;
    }

    public List<String> getUploadedImagesIds(List<String> docs, String applicationId) {
        List<String> list = new ArrayList<String>();
        SaveToDb sb = new SaveToDb();
        for (int i = 0; i < docs.size(); i++) {
            String docIds = sb.getValue2("select document_id from fas_int_documents where document_type = '" + docs.get(i) + "' and ref_id_detl = '" + applicationId + "'");
            //path = path.replace("C:ImmArchive", "C:/ImmArchive/");
            System.out.println("adding doc_ids " + docIds);
            list.add(docIds);
        }
        return list;
    }

    private void identifyAndGenerateNextDocId(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        String documentId = (String) session.getAttribute("documentId");
        SaveToDb sb = new SaveToDb();
        String jobType = null;
        String document_description = null;
        String query = null;
        int doc_ser = 0;
        int k = 0;
        String applicationId = (String) session.getAttribute("applicationId");
        jobType = (String) session.getAttribute("currentImage");
        String column = null;
        switch (jobType) {
            case "Tax":
                column = "tax_id";
                document_description = "Tax Payer Identification";
                break;
            case "Evidence_Tax":
                column = "tax_evence_id";
                document_description = "Evidence of Tax payments";
                break;
            case "Cert_inco":
                column = "cert_id";
                document_description = "Certificate of incorporation";
                break;
            case "Annual_audit":
                column = "annual_aud_id";
                document_description = "Annual audited accounts";
                break;
            case "Transferor_Technical":
                column = "com_prof_id";
                document_description = "Profile on Transferor/Technical Partner";
                break;

                      //-------------------------------------------//
        }

        System.out.println("voici les za column  " + column + "  jobtype is " + jobType);

        //sb.persist("insert into fas_int_documents set ref_id_detl = '" + applicationId + "', document_type = '" + jobType + "', document_id = '" + documentId + "'");
        query = "insert into fas_int_documents (ref_id_detl, document_type, document_id)  values ('" + applicationId + "', '" + document_description + "', '" + documentId + "')";
        sb.persist(query);
        ((List<String>) session.getAttribute("imageList")).add(jobType);

        for (int i = 0; i < ((List<String>) session.getAttribute("imageList")).size() - 1; i++) {

            System.out.println(" current images  " + ((List<String>) session.getAttribute("imageList")).get(i));
        }

        session.setAttribute("currentImage", jobType);
        session.setAttribute("documentId", documentId);
    }

    private void loadAndForward(HttpServletRequest request, HttpServletResponse response, String destination) {
        try {
            SaveToDb sb = new SaveToDb();
            HttpSession session = request.getSession(true);
            String applicationId = (String) session.getAttribute("applicationId");
            String newId = (String) session.getAttribute("newId");
            String docDesc = (String) session.getAttribute("docDesc");
            String newPass_no = null;
            paramsList = (List<String[]>) session.getAttribute("paramsList");
            for (int i = 0; i < paramsList.size(); i++) {
                request.setAttribute(paramsList.get(i)[1], paramsList.get(i)[0]);
                System.out.println(" request.setAttribute(" + paramsList.get(i)[1] + " " + paramsList.get(i)[0] + ")");
            }
            List<String> documents = getUploadedImages(applicationId);
            List<String> doc_ids = getUploadedImagesIds(documents, applicationId);
            request.setAttribute("documents", documents);
            request.setAttribute("doc_ids", doc_ids);
            List<String> delList = (List<String>) session.getAttribute("delList");
            if (delList.isEmpty()) {
                request.setAttribute("nextDocument", nextDocument);
            } else {
                String nextDoc = delList.get(0);
                request.setAttribute("nextDocument", nextDoc);
            }
            String offset = "offset";
            request.setAttribute("offset", offset);
            ServletContext context = getServletContext();
            System.out.println("/pages/" + (String) session.getAttribute("template") + ".jsp");
            RequestDispatcher rd = context.getRequestDispatcher("/pages/" + (String) session.getAttribute("template") + ".jsp");
            rd.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void doRenewal(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        LoaderVo lv = new LoaderVo();
        String user = (String) session.getAttribute("username");
        String old_pass_no = request.getParameter("passportNumber").toUpperCase();
        String new_ref_id = IdGenerator.generateId("ref_id");
        String decline = request.getParameter("decline");
        //session.setAttribute("application_id", new_ref_id);
        String query = null;
        if (decline == null) {
            query = "select ref_id from fas_int_doc where passport_no = '" + old_pass_no + "'  and approved_status = 'A'";
        } else {
            query = "select ref_id from fas_int_doc where passport_no = '" + old_pass_no + "'  and approved_status = 'D'";
        }
        String old_ref_id = sb.getValue2(query);
        if (old_ref_id != null) {
            session.setAttribute("applicationId", old_ref_id);
            session.setAttribute("newId", new_ref_id);

//      lv.setParam1(old_ref_id);
//      lv.setParam1(new_ref_id);
//      lv.setParam1(old_pass_no);
//      lv.setParam1(user);
//      lv.setParam1("N");
            lv.setControl("RENEWAL");

            //query = "insert into fas_int_renewal (old_ref_id, new_ref_id, old_passport_no, cre_user_id, approved_status)  values ('" + old_ref_id + "', '" + new_ref_id + "', '" + old_pass_no + "', '" + user + "', 'N')";
            session.setAttribute("LoaderVo", lv);
            sb.persist(query);
            loadAndForward(request, response, "renewal.jsp");
        } else {

            if (sb.isAvailable("select old_passport_no from fas_int_renewal where old_passport_no = '" + old_pass_no + "'")) {

                request.setAttribute("message", "This passport number has been previously renewed, please enter a more recent passport number");
                request.setAttribute("status", "error");
                loadAndForward(request, response, "homepage.jsp");
            } else {
                request.setAttribute("message", "No record was found , The Passport Number may still be waiiting for approval");
                request.setAttribute("status", "error");
                loadAndForward(request, response, "homepage.jsp");
            }

        }
    }

    private void dispatch(HttpServletRequest request, HttpServletResponse response, String destination) throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher(destination);
        view.forward(request, response);
    }

//   void loadJobMandate(String ref_id, String user_id){
//    
//   SaveToDb sb = new SaveToDb();    
//   String query = "select auth_id, operator from fas_mst_user_mandate where user_id = '" + user_id + "'";  
//   List<String[]> list = sb.getListss(query, 2);
//  
//   for (int i = 0; i < list.size(); i++) {
//     
//        System.out.println("lisstt " +  list.get(i)[0] + " operator is " +  list.get(i)[1]);
//       
//       query = "insert into fas_mst_user_authorization(ref_id, auth_id, operator, user_id, action) values('" + ref_id + "', '" + list.get(i)[0] +   "', '" + list.get(i)[1] +"', '" +user_id + "', 'W' )";
//       sb.persist(query);
//   }
//   
//   }
}
