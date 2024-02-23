/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.LoaderVo;
import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
@WebServlet(name = "Authorize", urlPatterns = {"/Authorize"})
public class Authorize extends HttpServlet {

    String role_id;
    String user;
    String update_id;

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

        HttpSession hts = request.getSession(true);

        String assigment = request.getParameter("Assignment");
        String type = request.getParameter("AuthorizeType");
        String renewal = request.getParameter("renewal");
        String trans_no = request.getParameter("trans_no");
        String authorize = request.getParameter("authorizeUpdate");
        String authorizeNew = request.getParameter("authorizeNew");
        String authorizeRenewal = request.getParameter("authorizeRenewal");
        String new_upload = request.getParameter("new_upload");
        String reference_id = request.getParameter("reference_id");
        String next = request.getParameter("next");
        String prev = request.getParameter("previous");
        String print_receipt = request.getParameter("print_receipt");
        String refresh = request.getParameter("refresh");
        String accessControl = request.getParameter("accessControl");
        String manage_access = request.getParameter("manage_access");
        String view =  request.getParameter("view");

        role_id = (String) hts.getAttribute("role_id");
        user = (String) hts.getAttribute("username");
        
        String workflowConfig = request.getParameter("workflowDefine");

        if (assigment != null) {
            assignJob(request, response);
        } else if (type != null) {
            loadRequestList(request, response);
        } else if (type != null) {
            loadRequestList(request, response);
        } else if (renewal != null) {
            loadAuthorizePageRenewal(request, response);
        } else if (trans_no != null) {
            loadAuthorizePage(request, response);
        } else if (authorize != null) {
            authorizeDecline(request, response);
        } else if (new_upload != null) {
            System.out.println(" RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR " + request.getParameter("ref_id"));
            loadAuthorizePageNew(request, response);
        } else if (authorizeNew != null) {
            authorizeDeclineNew(request, response);
        } else if (authorizeRenewal != null) {
            authorizeDeclineRenewal(request, response);
        } else if (print_receipt != null) {
            loadCertificate(request, response);
        } else if (refresh != null) {
            loadAndForward(request, response);
        } else if (accessControl != null) {
            accessControl(request, response);
        } else if (manage_access != null) {
            accessManagement(request, response);
        } else if ( workflowConfig != null) {
            defineWorkFlow(request, response);
        } 
        else if (request.getParameter("view") != null) {
            PDFLoader ploader = new PDFLoader();
            ploader.processRequest(request, response);
        }
    }
    
    
    protected void authorizeDeclineNew(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        SaveToDb sb = new SaveToDb();
        String ref_id = request.getParameter("reference_id");
        String authorize = request.getParameter("authorizeNew");
        String comment = request.getParameter("comment");
        String template = request.getParameter("template");
        String tax_type = request.getParameter("tax_type");
        String amount = request.getParameter("amount");
        String user_member = (String)session.getAttribute("username");
        Date date = new Date(System.currentTimeMillis());
        String trans_date = date.toString();
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        
        List<String[]> temp_auth_level = sb.getListss("select temp_auth_level, auth_level from fas_work_flow where ref_id = '" + ref_id + "' and action_status = 'pending'", 2);
        String query = "update fas_work_flow  set action_status  = 'done', decision = '" + authorize + "', trans_date ='" + ts + "', user_comment = ' " + comment + " ' where ref_id = '" + ref_id + "' and temp_auth_level  ='" + temp_auth_level.get(0)[0] + "'";
        sb.persist(query);
        
        String nextAuthLevel = getNextAuthLevel(template, temp_auth_level.get(0)[0]);
        //String authLevel = sb.getValue2("select temp_auth_level from fas_work_flow_define where template_name ='" +template + "' and user_member ='" + user_member + "'");
        //int newAuthLevel = Integer.parseInt(authLevel) + 1;
        
        String nextAuth = sb.getValue2("select user_member  from fas_work_flow_define where temp_auth_level ='" + nextAuthLevel +"'");
       
        if (nextAuth != null) {
            int nextAuthNum = Integer.parseInt(temp_auth_level.get(0)[1]) + 1;
          query = "insert into fas_work_flow (ref_id, user_id, temp_auth_level, action_status, auth_level, init_time_sys_mill) values ('" + ref_id + "', '" + nextAuth + "', '" + 
                  nextAuthLevel + "', 'pending', '" +  nextAuthNum + "', '" + System.currentTimeMillis() +"')";  
         }
        
        String result = sb.persist(query);
        switch (result) {
            case "success":
                request.setAttribute("message", "Authorization Succesfull");
                request.setAttribute("status", "Success");
                query = "update " + template + " set user_init = 'initiated' where ref_id = '" + ref_id + "'";
                sb.persist(query);
                break;
            case "failure":
                request.setAttribute("message", "Authorization Failed. Please retry");
                request.setAttribute("status", "error");
                break;
        }
         loadAndForward(request, response);

        
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void loadRequestList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");
        String query = "";
        String query2 = "";
        String[] range = (String[]) session.getAttribute("pageRange");
        String next = request.getParameter("next");
        String prev = request.getParameter("previous");

        System.out.println("voici les du next" + next);
        System.out.println("voici les du prev" + prev);

        if (request.getParameter("update") != null) {
            range = null;
        }

        if (prev != null) {
            range = GetRange.retRange2(range);
        } else {
            range = GetRange.retRange(range);
        }
        int kk = Integer.parseInt(range[0]);
        int mm = kk + 2;
        range[1] = String.valueOf(mm);
        if (mm == 2) {
            range[1] = "3";
        }
        int kount = 0;
        String count = "0";
        session.setAttribute("pageRange", range);
        if ("new".equalsIgnoreCase(request.getParameter("AuthorizeType"))) {
            loadAndForward(request, response);
        }
    }

    protected void loadAuthorizePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        String trans_no = request.getParameter("trans_no");
        String ref_id = request.getParameter("ref_id");
        String[] values = LoadValues.loadValues(ref_id);
        LoaderVo lv = LoadValues.loadUpdateValues(trans_no);
        String query = "select document_type from fas_int_documents where ref_id_detl = '" + ref_id + "' and document_update is not null";
        List<String> imageUpdate = sb.getList2(query);
        request.setAttribute("imageUpdate", imageUpdate);
        request.setAttribute("values", values);
        request.setAttribute("valueHolder", lv);

        RequestDispatcher view = request.getRequestDispatcher("/pages/authorize_update.jsp");
        view.forward(request, response);
    }

    protected void loadAuthorizePageNew(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SaveToDb sb = new SaveToDb();
        String ref_id = request.getParameter("ref_id");
        String template = sb.getValue2("select template from template_id where ref_id ='" + ref_id + "'");
        String query = "select document_type from fas_int_documents where ref_id_detl = '" + ref_id + "'";
        List<String> imageList = sb.getList2(query);
        request.setAttribute("documents", imageList);
        request.setAttribute("role_id", role_id);
        request.setAttribute("user", user);
        request.setAttribute("template", template);
        request.setAttribute("ref_id", ref_id);
        String authPanelDisplay = request.getParameter("auth_panel_display");
        request.setAttribute("auth_panel_display", authPanelDisplay);
        
        RequestDispatcher view = request.getRequestDispatcher("/pages/authorize_new.jsp");
        view.forward(request, response);
    }
    
    
    protected void accessManagement(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SaveToDb sb = new SaveToDb();
        String ref_id = request.getParameter("ref_id");
        String template = sb.getValue2("select template from template_id where ref_id ='" + ref_id + "'");
        String query = "select document_type from fas_int_documents where ref_id_detl = '" + ref_id + "'";
        List<String> imageList = sb.getList2(query);
        request.setAttribute("documents", imageList);
        request.setAttribute("role_id", role_id);
        request.setAttribute("user", user);
        request.setAttribute("template", template);
        request.setAttribute("ref_id", ref_id);
        
        RequestDispatcher view = request.getRequestDispatcher("/pages/access_management.jsp");
        view.forward(request, response);
    }

    
    
        protected void accessControl(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("/pages/access_control.jsp");
        view.forward(request, response);
    }

    protected void loadAuthorizePageRenewal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        String query = "";
        String new_ref_id = request.getParameter("ref_id");
        String ref_id = "";
        query = "select old_ref_id from fas_int_renewal where new_ref_id = '" + new_ref_id + "'";
        ref_id = sb.getValue2(query);
        query = "select new_passport_no from fas_int_renewal where new_ref_id = '" + new_ref_id + "'";
        String newPassportNumber = sb.getValue2(query);
        String[] values = LoadValues.loadValues(ref_id);
        query = "select document_type from fas_int_documents where ref_id_detl = '" + ref_id + "'";
        List<String> imageList = sb.getList2(query);
        request.setAttribute("documents", imageList);
        request.setAttribute("values", values);
        request.setAttribute("newPassportNumber", newPassportNumber);
        RequestDispatcher view = request.getRequestDispatcher("/pages/authorize_renewal.jsp");
        view.forward(request, response);
    }

    protected void authorizeDecline(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        String trans_no = request.getParameter("transactionNumber");
        String authorize = request.getParameter("authorizeUpdate");

        if (authorize.equalsIgnoreCase("authorize")) {
            LoaderVo lv = LoadValues.loadUpdateValues(trans_no);
            sb.persist("update fas_update_request set approved_status = 'A' where trans_no = '" + trans_no + "'");
            sb.persist("update fas_int_documents set approved_status = 'A' where ref_id_detl = '" + lv.getRef_id() + "'");
        } else {
            sb.persist("update fas_update_request set approved_status = 'D' where trans_no = '" + trans_no + "'");
        }
        request.setAttribute("message", "Update Request Authorized");
        request.setAttribute("status", "Success");

        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");

        String query = "select count(*) from fas_update_request where approved_status = 'N' and submitted_by in (select user_id from FAS_MST_USERS where user_auth_id = '" + user + "') ";
        query = "select * from ( select trans_no, row_number() over (order by ref_id DESC) rn from fas_update_request where approved_status = 'N' and submitted_by in (select user_id from FAS_MST_USERS where user_auth_id = '" + user + "') ) where rn between 0 and 3 order by rn";
        List<String[]> list = sb.getList3(query);
        request.setAttribute("list", list);
        query = "select count(*) from fas_update_request where approved_status = 'N' and submitted_by in (select user_id from FAS_MST_USERS where user_auth_id = '" + user + "') ";
        request.setAttribute("list", list);

        session.setAttribute("upper", "0");
        session.setAttribute("lower", "3");
        int kount = sb.getId(query);
        String count = String.valueOf(kount);
        request.setAttribute("count", count);
        request.setAttribute("upper", "0");
        request.setAttribute("lower", "3");
        RequestDispatcher view = request.getRequestDispatcher("/pages/update_request_list.jsp");
        view.forward(request, response);
    }

    protected void authorizeDeclineRenewal(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");
        SaveToDb sb = new SaveToDb();
        String ref_id = request.getParameter("reference_id");
        String authorize = request.getParameter("authorizeRenewal");
        String comment = request.getParameter("comment");
        if (authorize.equalsIgnoreCase("authorize")) {
            String query = "update fas_int_renewal set approved_status = 'A', auth_user_id = '" + user + "',  comments = 'Authorized' where old_ref_id = '" + ref_id + "'";
            String result = sb.persist(query);

            query = "select new_passport_no from fas_int_renewal where old_ref_id = '" + ref_id + "' and  rownum = 1 order by cre_dt desc";
            String id = sb.getValue2(query);

            query = "update fas_int_doc set passport_no = '" + id + "' where ref_id = '" + ref_id + "'";
            sb.persist(query);

            switch (result) {
                case "success":
                    request.setAttribute("message", "Authorization Succesfull");
                    request.setAttribute("status", "Success");
                    break;
                case "failure":
                    request.setAttribute("message", "Authorization Failed. Please retry");
                    request.setAttribute("status", "error");
                    break;
            }

        } else if (authorize.equalsIgnoreCase("decline")) {
            String query = "update fas_int_renewal set approved_status = 'D', auth_user_id = '" + user + "', comments = '" + comment + "' where old_ref_id = '" + ref_id + "'";
            String result = sb.persist(query);
            switch (result) {
                case "success":
                    request.setAttribute("message", "Authorization Succesfull");
                    request.setAttribute("status", "Success");
                    break;
                case "failure":
                    request.setAttribute("message", "Authorization Failed. Please retry");
                    request.setAttribute("status", "error");
                    break;
            }
        }
        String query = "";// and cre_user_id in (select users from supervisor_user where supervisor = '"+user+"')
        String upper = (String) session.getAttribute("upper");
        String lower = (String) session.getAttribute("lower");
        String count = "";
        int kount = 0;
        query = "select * from ( select new_ref_id, row_number() over (order by new_ref_id DESC) rn from fas_int_renewal where approved_status = 'N' and cre_user_id in (select user_id from FAS_MST_USERS where user_auth_id = '" + user + "') ) where rn between " + upper + " and " + lower + " order by rn";

        request.setAttribute("upper", upper);
        request.setAttribute("lower", lower);
        List<String[]> list = sb.getList3(query);
        query = "select count(*) from fas_int_renewal where approved_status = 'N' and cre_user_id in (select user_id from FAS_MST_USERS where user_auth_id = '" + user + "') ";
        kount = sb.getId(query);
        count = String.valueOf(kount);
        request.setAttribute("count", count);
        request.setAttribute("list", list);
        RequestDispatcher view = request.getRequestDispatcher("/pages/new_upload_list.jsp");
        view.forward(request, response);
    }

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

    private void doNext(HttpServletRequest request, HttpServletResponse response) {
        try {
            loadRequestList(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(Authorize.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Authorize.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    void updateJobStatus(String ref_id) {
        SaveToDb sb = new SaveToDb();
        String query = "select  operator, action from fas_mst_user_authorization where ref_id ='" + ref_id + "'";
        String operators = "";
        String actions = "";

        List<String[]> mandates = sb.getListss(query, 2);
        for (String[] mandate : mandates) {
            operators = operators + mandate[0];
            actions = actions + mandate[1];
        }

        if (operators.contains("OR")) {
            if (actions.contains("A")) {
                query = "update fas_int_doc set approved_status = 'A' where ref_id = '" + ref_id + "'";
                sb.persist(query);
            }
            //fas_int_doc where approved_status = 'N' 
        }

        if (operators.contains("AND")) {
            if (actions.contains("W")) {
                query = "update fas_int_doc set approved_status = 'N' where ref_id = '" + ref_id + "'";
                sb.persist(query);
            } else if (actions.contains("D")) {
                query = "update fas_int_doc set approved_status = 'D' where ref_id = '" + ref_id + "'";
                sb.persist(query);
            } else {
                query = "update fas_int_doc set approved_status = 'A' where ref_id = '" + ref_id + "'";
                sb.persist(query);
            }
        }
    }

    protected void assignJob(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String director = request.getParameter("director");
        String proc_officer = request.getParameter("proc_officer");
        String assignment_level = request.getParameter("Assignment");
        String ref_id = request.getParameter("reference_id");
        String template = request.getParameter("template");

        SaveToDb sb = new SaveToDb();
        String query = "";
        if (assignment_level.equalsIgnoreCase("one")) {
            query = "update " + template + " set director_assigned = '" + director + "', control = 'dir_to_assign' where ref_id = '" + ref_id + "'";
        } else if (assignment_level.equalsIgnoreCase("two")) {
            query = "update " + template + " set user_assigned = '" + proc_officer + "', control = 'done' where ref_id = '" + ref_id + "'";
        }
        sb.persist(query);
        loadRequestList(request, response);
    }

    
    public void loadAndForward(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        HttpSession session = request.getSession(true);
        String user = (String) session.getAttribute("username");
        String query = "";
        String query2 = "";
        String[] range = (String[]) session.getAttribute("pageRange");
        String next = request.getParameter("next");
        String prev = request.getParameter("previous");

        String role_id = (String) session.getAttribute("role_id");
        if (request.getParameter("update") != null) {
            range = null;
        }
        if (prev != null) {
            range = GetRange.retRange2(range);
        } else {
            range = GetRange.retRange(range);
        }
        int kk = Integer.parseInt(range[0]);
        int mm = kk + 2;
        range[1] = String.valueOf(mm);
        if (mm == 2) {
            range[1] = "3";
        }
        int kount = 0;
        String count = "0";
        session.setAttribute("pageRange", range);
        List<String[]> templates = sb.getListss("select template_name, description from template_names", 2);
        for (String[] template : templates) {
            //query = query + "  select ref_id, uploaded_by, '" + template[1] + "', UploadDate from " + template[0] + " where user_init is null and uploaded_by in (select user_id from fas_mst_users where user_auth_id = '" + user + "')";
            query = query + "  select ref_id, uploaded_by, '" + template[1] + "', UploadDate from " + template[0] + " where ref_id in (select ref_id from fas_work_flow where user_id = '" + user + "' and action_status ='pending')";
            query = query + "  union all";
        }
        if (query.length() > 10) {
            query = query.substring(0, query.length() - 10);
        }
        List<String[]> list = sb.getListss(query, 4);

        String addendum = "select ref_id, user_id, 'TEMPLATE DESCRIPTION', TRANS_DATE from fas_action_flow where user_id in (select user_id from fas_mst_users where user_auth_id = '" + user + "') and superior_action is null";
        List<String[]> l = sb.getListss(addendum, 4);

        for (String[] l1 : l) {
            list.add(l1);
        }
        int k = 0;
        for (String[] template : templates) {
            k = k + sb.getId("select count(*) from " + template[0] + " where user_init is null and uploaded_by in (select user_id from fas_mst_users where user_auth_id = '" + user + "')");
        }

        kount = k;
        count = String.valueOf(kount);
        session.setAttribute("kount", count);
        request.setAttribute("count", count);
        request.setAttribute("list", list);
        request.setAttribute("upper", range[0]);
        request.setAttribute("lower", range[1]);
        request.setAttribute("role_id", role_id);
        RequestDispatcher view = request.getRequestDispatcher("/pages/new_upload_list.jsp");
        view.forward(request, response);
    }

    
    public void defineWorkFlow(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         String template = request.getParameter("template");
         HttpSession session = request.getSession(true);
         SaveToDb sb = new SaveToDb();
            List<String> authorizers = sb.getList2("select user_member, auth_level from fas_work_flow_define  where template_name = '" + template + "' order by auth_level asc");
            request.setAttribute("authorizers", authorizers);
            session.setAttribute("template", template);
            RequestDispatcher view = request.getRequestDispatcher("/pages/defineWorkflow.jsp");
        view.forward(request, response);
    }
    
    
    protected void loadCertificate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ref_id = request.getParameter("reference_id");
        SaveToDb sb = new SaveToDb();
        String template = (String)request.getParameter("template");
        String name_of_company = sb.getValue2("select name_of_company from " + template + " where ref_id ='" + ref_id + "'");
        request.setAttribute("name_of_company", name_of_company);
        RequestDispatcher view = request.getRequestDispatcher("/pages/receipt.jsp");
        view.forward(request, response);
    }

    public String getTaxTransNo() {
        SaveToDb sb = new SaveToDb();
        int num = sb.getId("select trans_id from fas_int_counter");
        System.out.println("TRANS_ID SELECTED ID " + num);
        int j = num + 1;
        System.out.println("TRANS_ID after update" + j);
        sb.persist("update fas_int_counter set trans_id ='" + j + "'");
        return "trans_" + num;
    }
    
    public String getNextAuthLevel(String template, String tempAuthLevel){
        int k =  0;
         String nameNumber = tempAuthLevel;
        String toFilter = template+"tmpauthlv";
        int f = toFilter.length();
        int l = nameNumber.length();
        k = Integer.parseInt(nameNumber.substring(f, l));
        k++;
        String nextTempAuthLevel = toFilter+k;
        return nextTempAuthLevel;
    }

}
