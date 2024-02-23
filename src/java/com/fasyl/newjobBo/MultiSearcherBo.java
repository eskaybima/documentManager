/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import com.fasyl.vo.MultiSearcherVo;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Mr Jaid
 */
public class MultiSearcherBo {

   public String[] generalSearchQueryFormater(HttpServletRequest request, HttpServletResponse response, String queryTable, MultiSearcherVo multi, String[] range)
            throws ServletException, IOException{
       SaveToDb sb = new SaveToDb();
       HttpSession session = request.getSession(true);
       List<String> parameters = sb.getList2("select param_names from params_table where type != 'DOCUMENT'");
      
        String searchType = trimmer(request.getParameter("SearchType"));
        String search = "";
        String query = "";
        int k = 0;
        String[] resp = new String[2];
        String checkQuery = "select count(*) as total_records from " + "fas_int_document" + " where ";
        int countChange = 0;
        int totalRec = 0;
        if (searchType.equalsIgnoreCase("Search_by_param_group")) {
       
            for (int i = 0; i < parameters.size(); i++) {
            if (checker(request.getParameter(parameters.get(i)))) {
                countChange++;
                search = search + parameters.get(i) +" like '%" + request.getParameter(parameters.get(i)) + "%' and ";
            }
            }
            
            if(checker(request.getParameter("refNumber"))) {
                countChange++;
                search =search +"ref_id like '%" + request.getParameter("refNumber") + "%' and ";
            } 
            
              if(checker(request.getParameter("uploaded_by"))) {
                countChange++;
                search =search +"uploaded_by like '%" + request.getParameter("uploaded_by") + "%' and ";
            } 
              
               
               search =search +"uploaded_by like '%" + (String)session.getAttribute("username") + "%' and ";
             
            if (countChange == 0) {
                return null;
            }
            search = search.substring(0, search.length() - 4);
            Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, "  xxxxxxxxxxxxxxxx done formating query xxxxxxxxxxxxxxxxxxxsearch is.. " + search + " xxxxxxxxxxx and change count is " + countChange + " xxxxxxxxxxx total record count " + multi.totalCount);
        } 
        
        else if (searchType.equalsIgnoreCase("General_search")) {
            String name = request.getParameter("name").trim();
            search = "(FIRST_NAME like'%" + name + "%' or MIDDLE_NAME like'%" + name + "%' or SURNAME like '%" + name + "%')";
        }
       
        
        if (session.getAttribute("saach") == null) {
        session.setAttribute("saach", search);
        }
        search = (String)session.getAttribute("saach");
        
        if ("yes".equalsIgnoreCase(request.getParameter("approved"))) {
            search = search + " and approved_status = 'A'";  
        }
        
        List<String> templates = sb.getList2("select template_name from template_names");
        String queryStatement = "";
        for (int i = 0; i < templates.size(); i++ ) {
            queryStatement = queryStatement + "  select ref_id from "+templates.get(i) +" where " + search ;
            queryStatement = queryStatement + "  union all";
        }
        queryStatement = queryStatement.substring(0, queryStatement.length() - 10);
       
        
        //query = "select ref_id from ( select ref_id, row_number() over (order by ref_id DESC) rn from fas_int_document where " + search + " ) where rn between " + range[0] + " and " + range[1] + " order by rn";
        //query = "select ref_id from ( select row_number() over () as rn, ref_id from fas_int_doc where approved_status is not null and " + search + ")as tmp where rn between " + range[0] + " and " + range[1] + " order by rn";
         query = queryStatement;   
        multi.query = query;
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, "*************** debuger 1 ********** next is ********" + multi.next);
        if (totalRec > multi.fetchSize) {
            query = query + multi.queryRange;
        } else {
            //query = query.substring(0, query.length() - 7);
        }
        multi.setTotalCount(totalRec);
        
        System.out.println("This is the quert : " + query  + "thus is is it look here ");
        
        resp[0] = query;
        
        
        
        String kount = "select count(*) from fas_int_document where " + search;
            
        k = sb.getId(kount);
        resp[1] = String.valueOf(k);
        return resp;
    }
   
    public void getNext(HttpServletRequest request, HttpServletResponse response, String respdestination) throws ServletException, IOException {
       SaveToDb sb = new SaveToDb();
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, " in next getter ***** ");
        HttpSession session = request.getSession();
        MultiSearcherVo searcher = (MultiSearcherVo) session.getAttribute("multiSearchervo");
        List<String> returnList = null;
        searcher.setNextRange();
        String query = searcher.query + searcher.getRange();
        if (query != null) {
            Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, query);
            returnList = sb.getList2(query);
        } else {
            returnList = null;
        }
        //session.setAttribute("searchList", returnList);
        session.setAttribute("totalcount", Integer.valueOf(searcher.totalCount));
        
        
        List<String[]> valuesList = loadValues(returnList);
        request.setAttribute("searchList", valuesList);
        
        
        if ((searcher.next) || (searcher.previous)) {
            String banner = preparePageBanner(searcher);
            session.setAttribute("banner", banner);
            if (searcher.next) {
                session.setAttribute("next", "next");
            } else {
                session.setAttribute("next", null);
            }
            if (searcher.previous) {
                session.setAttribute("previous", "previous");
            } else {
                session.setAttribute("previous", null);
            }
            session.setAttribute("multiSearchervo", searcher);
        } else {
            session.setAttribute("banner", null);
            session.setAttribute("multiSearchervo", null);
        }
        RequestDispatcher view = request.getRequestDispatcher(respdestination);
            view.forward(request, response);
    }

    public void getPrevious(HttpServletRequest request, HttpServletResponse response, String respdestination)
            throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, " in next getter ***** ");
        HttpSession session = request.getSession(false);
        MultiSearcherVo searcher = (MultiSearcherVo) session.getAttribute("multiSearchervo");
        List<String> returnList = null;
        searcher.setPreviousRange();
        String query = searcher.query + searcher.getRange();
        if (query != null) {
            Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, query);
            returnList = sb.getList2(query);
        } else {
            returnList = null;
        }
        List<String[]> valueList = loadValues(returnList);
        //session.setAttribute("searchList", valueList);
        request.setAttribute("searchList", valueList);
        session.setAttribute("totalcount", Integer.valueOf(searcher.totalCount));
        if ((searcher.next) || (searcher.previous)) {
            String banner = preparePageBanner(searcher);
            session.setAttribute("banner", banner);
            if (searcher.next) {
                session.setAttribute("next", "next");
            } else {
                session.setAttribute("next", null);
            }
            if (searcher.previous) {
                session.setAttribute("previous", "previous");
            } else {
                session.setAttribute("previous", null);
            }
            session.setAttribute("multiSearchervo", searcher);
        } else {
            session.setAttribute("banner", null);
            session.setAttribute("multiSearchervo", null);
        }
        RequestDispatcher view = request.getRequestDispatcher("/pages/detail.jsp");
            view.forward(request, response);
    }

    public void multiSearcher(HttpServletRequest request, HttpServletResponse response, String respdestination) throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        MultiSearcherVo mutlvo = new MultiSearcherVo();
        String queryTable = "fas_int_document";
        HttpSession session = request.getSession(true);
        String[] range = (String[]) session.getAttribute("pageRange");
         String next = request.getParameter("next");
        String prev = request.getParameter("previous");
        
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
        
       session.setAttribute("pageRange", range); 
        
        boolean enrollmentSearch = false;
        List<String> returnList = null;
        //  System.out.println("this is the query :  jkkkkkkkkkkkkkkkkkkkkk");
        String[] resp = generalSearchQueryFormater(request, response, queryTable, mutlvo, range);
        // System.out.println("this is the query :  lllllllllllllllllllllllllll");
        if (resp[0] != null) {
            Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, resp[0]);
            returnList = sb.getList2(resp[0]);
            if ((returnList.size() == 0) && ((request.getParameter("passportNumber")) != "") ) {
             String query = "select old_ref_id from fas_int_renewal where new_passport_no like '%" + request.getParameter("passportNumber") + "%'";  
              returnList = sb.getList2(query);
               String kount = "select count(*) from fas_int_renewal where new_passport_no like '%" + request.getParameter("passportNumber") + "%'";
            int k = sb.getId(kount);
            resp[1] = String.valueOf(k);
            }
            
            if ((returnList.size() == 0) && ((request.getParameter("passportNumber")) != "")) {
              String query = "select old_ref_id from fas_int_renewal where old_passport_no like '%" + request.getParameter("passportNumber") + "%'";  
              returnList = sb.getList2(query);
              String kount = "select count(*) from fas_int_renewal where old_passport_no like '%" + request.getParameter("passportNumber") + "%'";
              int k = sb.getId(kount);
              resp[1] = String.valueOf(k);
           }
            
        } else {
            returnList = null;
        }
        
        List<String[]> valuesList = loadValues(returnList);
               request.setAttribute("count", resp[1]);
               request.setAttribute("upper", range[0]);
               request.setAttribute("lower", range[1]);
        //HttpSession session = request.getSession(false);
        //session.setAttribute("searchList", returnList);
               request.setAttribute("searchList", valuesList);
               session.setAttribute("totalcount", Integer.valueOf(mutlvo.totalCount));
        if (mutlvo.next) {
        String banner = preparePageBanner(mutlvo);
               session.setAttribute("banner", banner);
               session.setAttribute("ner", banner);
               session.setAttribute("next", "next");
               session.setAttribute("multiSearchervo", mutlvo);
        } else {   //
               session.setAttribute("banner", null);
               session.setAttribute("ner", null);
               session.setAttribute("multiSearchervo", null);
        }
               RequestDispatcher view = request.getRequestDispatcher(respdestination);
               view.forward(request, response);
    }
    public String preparePageBanner(MultiSearcherVo multisearcher) {
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, " about to set banner ***** ");
        String pageBanner = multisearcher.totalCount + " items found, Showing " + multisearcher.currentStart + " to " + multisearcher.currentStop + " of " + multisearcher.totalCount;
        if (multisearcher.nextStop > multisearcher.totalCount) {
            multisearcher.nextStop = multisearcher.totalCount;
        }
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, " after setting banner, banner is ***** " + pageBanner);
        return pageBanner;
    }

    void dispatchRequest(String responseLocation, HttpServletRequest request, HttpServletResponse response) {
        try {
            RequestDispatcher view = request.getRequestDispatcher(responseLocation);
            view.forward(request, response);
        } catch (ServletException | IOException ex) {
            Logger.getLogger(MultiSearcher.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    String trimmer(String value) {
        if (value != null) {
            return value.trim();
        }
        return null;
    }

    boolean checker(String value) {
        if ((value != null) && (!value.trim().isEmpty())) {
            return true;
        }
        return false;
    }
    
    
    private List<String[]> loadValues(List<String> applicationId){
        SaveToDb sb = new SaveToDb();
        String table = "fas_int_document";
        String parameter = "ref_id";
        List<String[]> list = new ArrayList<String[]>();
        if(applicationId != null)
        for (int i = 0; i < applicationId.size(); i++) {
        String[] values = new String[9]; //ctpv
         //values[0] = sb.getValue("passport_no", table, parameter, applicationId.get(i));
//        values[1] = sb.getValue("surname", table, parameter, applicationId.get(i));
//        values[2] = sb.getValue("first_name", table, parameter, applicationId.get(i));
//        values[3] = sb.getValue("middle_name", table, parameter, applicationId.get(i));
//        values[4] = sb.getValue("state", table, parameter, applicationId.get(i));
//        values[5] = sb.getValue("dob", table, parameter, applicationId.get(i));
//        values[6] = sb.getValue("sex", table, parameter, applicationId.get(i));
//        values[7] = sb.getValue("country", table, parameter, applicationId.get(i));
        values[8] = applicationId.get(i);
        list.add(values);
        }
                return list;
    }
    
     public List<String> getUploadedImagesPaths(List<String> docs, String applicationId){
        SaveToDb sb = new SaveToDb();
         List<String> list = new ArrayList<String>();
        for (int i = 0; i < docs.size(); i++) {
            String path = sb.getValue2("select doc_path from fas_int_documents where document_type = '" + docs.get(i) + "' and ref_id_detl = '" + applicationId + "'");
            path = path.replace("C:ImmArchive", "C:/ImmArchive/");
            System.out.println("adding paths " + path);
            list.add(path);
        }
     return list;
    }
     
     private String getMonth(String in) {
        String month = null;
        switch (in) {
            case "01":
                month = "Jan";
                break;
            case "02":
                month = "Feb";
                break;
            case "03":
                month = "Mar";
                break;
            case "04":
                month = "Apr";
                break;
            case "05":
                month = "May";
                break;
            case "06":
                month = "Jun";
                break;
            case "07":
                month = "Jul";
                break;
            case "08":
                month = "Aug";
                break;
            case "09":
                month = "Sep";
                break;
            case "10":
                month = "Oct";
                break;
            case "11":
                month = "Nov";
                break;
            case "12":
                month = "Dec";
                break;
        }
        return month;
    }
    
}
