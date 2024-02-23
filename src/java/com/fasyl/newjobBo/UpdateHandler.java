package com.fasyl.newjobBo;

import com.fasyl.util.IdGenerator;
import com.fasyl.vo.LoaderVo;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
@WebServlet(name = "UpdateHandler", urlPatterns = {"/UpdateHandler"})
public class UpdateHandler extends HttpServlet {
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
        String confirm = request.getParameter("confirm");
        String update = request.getParameter("update");
        String correct_upload = request.getParameter("correct_upload");
        String correct_confrim = request.getParameter("correct_confirm");
        String submitCorrect = request.getParameter("correct");
        if (confirm != null) {
            confirm(request, response);
        } else if (update != null) {
            update(request, response);
        } else if (correct_upload != null) {
            correct(request, response);
        } else if (correct_confrim != null) {
            correct_confirm(request, response);
        } else if (submitCorrect != null) {
            submitCorrect(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        HttpSession session = request.getSession(true);
        String applicationId = (String) session.getAttribute("applicationId");
        String user = (String) session.getAttribute("username");
        LoaderVo lv = (LoaderVo) session.getAttribute("valueHolder");
        lv = LoadValues.processValues(lv);
        int transNo = IdGenerator.generateNumber("fas_update_id");
        String no = String.valueOf(transNo);
        
        List<String> imageUpdate = (List<String>) session.getAttribute("documentUpdates");
        
        String columns = "trans_no, ref_id, passport_no, surname, first_name, middle_name, sex, dob, state, local_govt, country, approved_status, submitted_by, passport_category, Marital_status, enrol_no, title";
//        String values = "'" + transNo + "', '" + applicationId + "', '" + lv.getParam1() + "', '" + lv.getParam1() + "', '"
//                + lv.getParam1() + "', '" + lv.getParam1() + "', '" + lv.getParam1() + "', '" + lv.getParam1() + "', '" + lv.getParam1()
//                + "', '" + lv.getParam1() + "', '" + lv.getParam1() + "', 'N', '" + user + "', '" + lv.getParam1() + "', '" +lv.getParam1()+ "', '" +lv.getParam1()+ "', '" +lv.getParam1()+ "'";
//        String query = "insert into fas_update_request (" + columns + ")  values (" + values + ")";
//        String result = sb.persist(query);

//        System.out.println("this is the result " + result);
//        
//        if (result.equalsIgnoreCase("success")) {
//        request.setAttribute("message", "Update Request Submitted Succesfully");
//        request.setAttribute("status", "Success");
//        } else {  
//        request.setAttribute("message", "Update Request Failed, Please retry");
//        request.setAttribute("status", "error");
//        }
        RequestDispatcher view = request.getRequestDispatcher("/pages/homepage.jsp");
        view.forward(request, response);
    }       
      
           
     protected void correct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         
        String passPortNumber = request.getParameter("passPortNumber");
        HttpSession session = request.getSession(false);
        session = request.getSession(true);
        String ref_id= request.getParameter("ref_id");
            LoaderVo lv = new LoaderVo();
            lv = LoadValues.initiateLoader(lv);
            session.setAttribute("valueHolder", lv);
            List<String> imageList = new ArrayList<String>();
            session.setAttribute("documents", imageList);
            List<String> imageUpdate = new ArrayList<String>();
            session.setAttribute("documentUpdates", imageUpdate);
            
            String[] values = LoadValues.loadValues(ref_id);
            session.setAttribute("values", values);
            session.setAttribute("applicationId", values[9]);
            
            RequestDispatcher view = request.getRequestDispatcher("/pages/correct_detail.jsp");
            view.forward(request, response);
    }
     
     
     private void submitCorrect(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        HttpSession session = request.getSession(true);
        String applicationId = (String) session.getAttribute("applicationId");
        String user = (String) session.getAttribute("username");
        LoaderVo lv = (LoaderVo) session.getAttribute("valueHolder");
        //System.out.println("......ayam country " + lv.getCountry() );
        lv = LoadValues.processValues(lv);
        
//         if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set passport_no = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set surname = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set first_name = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set middle_name = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1()!= null)) {
//            sb.persist("update fas_int_doc set state = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1()!= null)) {
//            sb.persist("update fas_int_doc set dob = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set sex = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set country = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        
//        if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set Marital_status = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        
//         if ((lv.getParam1() != null)) {
//            sb.persist("update fas_int_doc set passport_catgory = '" + lv.getParam1() + "' where ref_id = '" + applicationId + "'");
//        }
//        
         //sb.persist("update fas_int_doc set approved_status = 'N' where ref_id = '" + applicationId + "'");
          sb.persist("update fas_int_doc set approved_status = 'N' , director_assigned = null , user_assigned = null , user_init = null , control = 'control' where ref_id = '" + applicationId + "'");
 
        request.setAttribute("message", "Correction Submitted");
        request.setAttribute("status", "Success");
       
        
        
        RequestDispatcher view = request.getRequestDispatcher("/pages/homepage.jsp");//MultiSearcher?begin=yes&control=one
        view.forward(request, response);
    }
     
    
    private void confirm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("/pages/update_confirm.jsp");
        view.forward(request, response);
    }

    
    private void correct_confirm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("/pages/correct_confirm.jsp");
        view.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
