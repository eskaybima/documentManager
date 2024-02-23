package com.fasyl.newjobBo;

import com.fasyl.util.IdGenerator;
import com.fasyl.vo.LoaderVo;
import com.fasyl.vo.ParameterValues;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Initiator", urlPatterns = {"/Initiator"})
public class Initiator extends HttpServlet {
    

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        
        System.out.println("Inside  Initiator  ............") ;
        System.out.println("Ayam here");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);

        ServletOutputStream out = response.getOutputStream();
        String passportNumber = request.getParameter("passportNumber");
         
        System.out.println("Passpoert number sent to initialtor is :"+passportNumber);
        String newPass_no = request.getParameter("newPass_no");
        String surname = request.getParameter("surname");
        String title = request.getParameter("title");
        String firstname = request.getParameter("firstname");
        String middlename = request.getParameter("middlename");
        String state = request.getParameter("state");
        String dob = request.getParameter("dob");
        String enrolNo = request.getParameter("enrolNo");
        String sex = request.getParameter("sex");
        String country = request.getParameter("country");
        String category = request.getParameter("category");
        String onset = request.getParameter("onset");
        String imagecontrol = request.getParameter("imagecontrol");
        String update = request.getParameter("control");
        String jobType = request.getParameter("jobType");
        String startNew = request.getParameter("startNew");
        String renewal = request.getParameter("renewal");
        String docDesc = request.getParameter("docDesc");
        String mar_status = request.getParameter("mar_status");
        //String documentParameter = request.getParameter("documentParameter");
        String params = request.getParameter("params"); 
        String paramterValue = request.getParameter("paramterValue");
        
        
        String paramValue = request.getParameter("paramValue"); 
        String applicationId = null;
        String documentId = null;
        String user = (String) session.getAttribute("username");
        String loc = (String) session.getAttribute("location");
        String loc_code = (String) session.getAttribute("loc_code");
        
        
        
        applicationId = (String) session.getAttribute("applicationId");
        LoaderVo lv =  (LoaderVo) session.getAttribute("LoaderVo");
        List<String[]> paramsList = (List<String[]>)session.getAttribute("paramsList");
        List<String> values = (List<String>)session.getAttribute("values");
        

        
      System.out.println("The value for startNew is : "+ startNew);
      System.out.println("The value for update is : "+ update);
      System.out.println("The value for onset is : "+ onset);

//  System.out.println("The value for passport number is : "+ lv.getPassNo() );
        if (dob != null) {
            dob = dob.substring(8, 10) + "-" + getMonth(dob.substring(5, 7)) + "-" + dob.substring(0, 4);
        }


        if (sex != null) {
            sex = sex.substring(8, 10) + "-" + getMonth(sex.substring(5, 7)) + "-" + sex.substring(0, 4);
        }

        if (mar_status != null) {
            mar_status = mar_status.substring(8, 10) + "-" + getMonth(mar_status.substring(5, 7)) + "-" + mar_status.substring(0, 4);
        }
//DateFormat dateFormat = new SimpleDateFormat("DD-Mon-YYYY");
//        
//       dob = dateFormat.format(dob).toString();
 // lv.setPassNo(passportNumber);
        if (startNew != null) {
            startNew(request, response);
        }
        
        if (paramterValue != null) {
            values.add(paramterValue);
        }
        
    
        if (paramValue != null) {
            
            List<String[]> in_paramList = new ArrayList<>();
            String[] in_data = null;
            for (int i = 0; i < paramsList.size(); i++) {
                if (request.getParameter("paramName") != null) {
                 if (!request.getParameter("paramName").equalsIgnoreCase(paramsList.get(i)[1])) {
                      in_data = new String[2];
                      in_data[0] = paramsList.get(i)[0];
                      in_data[1] = paramsList.get(i)[1];
                      in_paramList.add(in_data);
                 }  
                }
            }
            session.setAttribute("paramsList", in_paramList);
            String[] data = new String[2];
            data[0] = request.getParameter("paramValue");
            data[1] = request.getParameter("paramName");
            paramsList = (List<String[]>)session.getAttribute("paramsList");
            paramsList.add(data);
            System.out.println("Ayam addding " + data[0] +" "+ data[1]);
         }
        
        if (params != null) {
            
          if (request.getParameter("templateName") != null) {
             session.setAttribute("templateName", request.getParameter("templateName"));
        }  
      /////////    
          if (request.getParameter("description") != null) {
            session.setAttribute("description", request.getParameter("description"));
            session.setAttribute("formHeader", request.getParameter("description"));
        }
          
         
     ////////////     

        if (request.getParameter("documentParameter") != null) {
            ParameterValues pv = new ParameterValues();
            String pp = request.getParameter("documentParameter").replace("-", "");
            pp = pp.replace(".", "");
            pp = pp.replace("!", "");
            pp = pp.replace("@", "");
            pp = pp.replace("%", "");
            pp = pp.replace("^", "");
            pp = pp.replace("*", "");
            pp = pp.replace("*", "");
            pp = pp.replace(")", "");
            pp = pp.replace(")", "");
            pp = pp.replace("-", "");
            pv.setParameterName(pp.toUpperCase());
            pv.setDatatype("String");
            session.setAttribute("cur_object", pv);
        }
        if (request.getParameter("dataType") != null) {
            ParameterValues pv = (ParameterValues)session.getAttribute("cur_object");
            pv.setDatatype(request.getParameter("dataType"));
            ((List<ParameterValues>)session.getAttribute("parameters")).add(pv);
        }
        
        if (request.getParameter("groupName") != null) {
            session.setAttribute("groupName", request.getParameter("groupName"));
        }
        
        if (request.getParameter("memberName") != null) {
             ((List<String>)session.getAttribute("curr_members")).add(request.getParameter("memberName"));
        }
        
        
        }
        
        
        
        if ((update != null)) {
            if (update.equalsIgnoreCase("two")) {
                doUpdate(request, response);
            }
        }
        if (onset != null) {
            if (applicationId == null) {
//        List<String> imageList = new ArrayList<>();
//        session.setAttribute("imageList", imageList);
                Date cre_date = new Date(System.currentTimeMillis());
                applicationId = loc_code;
                String id = IdGenerator.generateId("ref_id");
                applicationId = applicationId + id;
                session.setAttribute("applicationId", applicationId);
                String query = "insert into fas_int_doc (passport_no, ref_id, cre_user_id, approved_status)  values ('" + passportNumber + "', '" + applicationId + "', '" + user + "', 'N')";
                sb.persist(query);
                // sb.persist("insert into fas_int_doc set passport_no = '" + passportNumber + "', ref_id = '" + applicationId + "'");
            } else {
                if (!sb.isAvailable("select passport_no from fas_int_doc where passport_no = '" + passportNumber + "' and approved_status = 'N'")) {
                    //sb.persist("update fas_int_doc set passport_no = '" + passportNumber + "' where ref_id = '" + applicationId + "'");
//                    lv.setParam1(passportNumber.toUpperCase());
                } else {
                }
            }
        }
         if (imagecontrol != null) {
            System.out.println("adding document " + jobType);
            documentId = IdGenerator.generateId("app_form_id");
            ((List<String>) session.getAttribute("imageList")).add(jobType);
            session.setAttribute("currentImage", jobType);
            session.setAttribute("documentId", documentId);
            
          
            
        }
        
        
        
        
        
        if (update != null) {
            if (update.equalsIgnoreCase("one")) {
                if (country != null) {
                }
            }
        }
        if (renewal != null) {
            String newId = (String) session.getAttribute("newId");
            System.out.println("...........doc desc.... " + docDesc);
            if (docDesc != null) {
                documentId = "REN" + IdGenerator.generateId("app_form_id");
                session.setAttribute("documentId", documentId);
                session.setAttribute("docDesc", docDesc);
                List<String> imageUpdate = (List<String>) session.getAttribute("documentUpdates");
                imageUpdate.add(docDesc);
            }
        }
    }

    private String getMonth(String in) {
        String month = null;
        switch (in) {
            case "01":
                month = "JAN";
                break;
            case "02":
                month = "FEB";
                break;
            case "03":
                month = "MAR";
                break;
            case "04":
                month = "APR";
                break;
            case "05":
                month = "MAY";
                break;
            case "06":
                month = "JUN";
                break;
            case "07":
                month = "JUL";
                break;
            case "08":
                month = "AUG";
                break;
            case "09":
                month = "SEP";
                break;
            case "10":
                month = "OCT";
                break;
            case "11":
                month = "NOV";
                break;
            case "12":
                month = "DEC";
                break;
        }
        return month;
    }

    private void startNew(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        String loc = (String) session.getAttribute("location");
        String applicationId = null;
        applicationId = loc.substring(0, 2);
        String id = IdGenerator.generateId("ref_id");
        applicationId = applicationId + id;
        System.out.println("......... " + applicationId);
        session.setAttribute("applicationId", applicationId);
        String user = (String) session.getAttribute("username");
        String query = "insert into fas_int_doc (ref_id, cre_user_id)  values ('" + applicationId + "', '" + user + "')";
        //sb.persist("insert into fas_int_doc (passport_no, ref_id, cre_user_id, approved_status)  values ('" + passportNumber + "', '" + applicationId + "', '" + user + "', 'N')");
        sb.persist(query);
        List<String> imageList = new ArrayList<>();
        session.setAttribute("imageList", imageList);

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

    private void doUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        LoaderVo lv = (LoaderVo) session.getAttribute("valueHolder");
        List<String> imageList = (List<String>) session.getAttribute("documents");

        String passportNumber = request.getParameter("passportNumber");
        String surname = request.getParameter("surname");
        String firstname = request.getParameter("firstname");
        String middlename = request.getParameter("middlename");
        String state = request.getParameter("state");
        String dob = request.getParameter("dob");
        String sex = request.getParameter("sex");
        String country = request.getParameter("country");
        String onset = request.getParameter("onset");
        String imagecontrol = request.getParameter("imageupdate");
        String update = request.getParameter("control");
        String jobType = request.getParameter("jobType");
        String category = request.getParameter("category");
        String mar_status = request.getParameter("mar_status");
        String enrolNo = request.getParameter("enrolNo");
        String title = request.getParameter("title");
        String applicationId = null;
        String documentId = null;
        String column = null;

        String loc = (String) session.getAttribute("location");
        applicationId = (String) session.getAttribute("applicationId");

//        if (passportNumber != null) {
//            lv.setParam1(passportNumber);
//        }
//
//        if (enrolNo != null) {
//            lv.setParam1(enrolNo);
//        }
//
//        if (surname != null) {
//            lv.setParam1(surname);
//        }
//        if (firstname != null) {
//            lv.setParam1(firstname);
//        }
//        if (middlename != null) {
//            lv.setParam1(middlename);
//        }
//        if (state != null) {
//            lv.setParam1(state);
//        }
//        if (dob != null) {
//            lv.setParam1(dob);
//        }
//        if (sex != null) {
//            lv.setParam1(sex);
//        }
//        if (country != null) {
//            lv.setParam1(country);
//        }
//
//        if (category != null) {
//            lv.setParam1(category);
//        }
//
//        if (mar_status != null) {
//            lv.setParam1(mar_status);
//        }
//
//        if (title != null) {
//            lv.setParam1(title);
//        }

//        if (imagecontrol != null) {
//            switch (jobType) {
//                case "PHOTO":
//                    imageList.add("PHOTO");
//                    column = "passport_photo_id";
//                    break;
//                case "FORM":
//                    imageList.add("FORM");
//                    column = "app_form_id";
//                    break;
//                case "BIRTH":
//                    imageList.add("BIRTH");
//                    column = "birth_cert_id";
//                    break;
//                case "STATE":
//                    imageList.add("STATE");
//                    column = "state_origin_id";
//                    break;
//                case "DATA":
//                    imageList.add("DATA");
//                    column = "data_page_id";
//                    break;
//
//                 case "Tax":  
//                    column = "tax_id";
//                    break;
//                case "Evidence_Tax":
//                    column = "tax_evence_id";
//                    break;
//                case "Cert_inco":
//                    column = "cert_id";
//                    break;
//                case "Annual_audit":
//                    column = "annual_aud_id";
//                    break;
//                case "Transferor_Technical":
//                    column = "com_prof_id";
//                    break;
//         documentId = jobType + generateId(column) + "U";
//         String query = "insert into fas_int_documents (ref_id_detl, document_type, document_id)  values ('" + applicationId + "', '" + jobType + "', '" + documentId + "')";
//         sb.persist(query);
//         session.setAttribute("documentId", documentId);
//
//        } 
//            session.setAttribute("currentImage", jobType);
//            System.out.println("current image set to  " + jobType);
//            //PHOTO000000050U
//    }
}
}
