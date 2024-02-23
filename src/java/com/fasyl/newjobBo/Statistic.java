/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.fasyl.newjobBo;

import au.com.bytecode.opencsv.CSVWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.sql.Date;
import java.util.ArrayList;
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
import org.apache.commons.io.FileUtils;

/**
 *
 * @author OYEWOLE MORUFF
 */
@WebServlet(name = "Statistic", urlPatterns = {"/Statistic"})
public class Statistic extends HttpServlet {
    Date cre_date;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String reportType = request.getParameter("reportType");
        String repType = request.getParameter("repType");
        cre_date = new Date(System.currentTimeMillis());
        
        if (reportType != null) {
            switch (reportType) {
                case "dailycountTotal":
                    dailycountTotal(request, response); break;
                case "dailyperLocation": 
                    dailyperLocation(request, response); break;
                case "dailyDetail": 
                    dailyDetail(request, response); break;
                case "dailyDetailperLocation":
                    dailyDetailbyLocation(request, response); break;
                case "generalCumulative":
                    cumulativebyLocation(request, response); break;
                case "filterByRange":
                    filterByRange(request, response); break;
                    
                     case "filterByUsers":
                    filterByUser(request, response); break;
            }
        } else {
            switch (repType) {
                case "dailyperLocation":
                    dailyperLocationDownLoad(request, response); break;
                case "dailyDetail":
                    dailyDetailDownload(request, response); break;
                case "dailyDetailLoc":
                    dailyDetailbyLocationDownload(request, response); break;//cumulativeperLocation
                case "cumulativeperLocation":
                    cumulativeperLocationDownload(request, response); break;
                case "rangeReport":
                    rangeDownload(request, response); break;
            }
        }
    }
    
    private void dailyperLocation(HttpServletRequest request, HttpServletResponse response) {
        String query = null;
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        SaveToDb sb = new SaveToDb();
        try {
            query = "select distinct loc_code from fas_mst_location";
            List<String> locs = sb.getList2(query);
            for (int i = 0; i < locs.size(); i++) {
                // query = "select count(*) from fas_int_doc where cre_date  >= '" + cre_date + "' and ref_id like '%"+ locs.get(i) +"%'";
                query = "select count(*) from fas_int_doc where trunc(cre_date)  = trunc(sysdate) and ref_id like '%" + locs.get(i) + "%'";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_update_request where trunc(cre_date) = trunc(sysdate) and ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_int_renewal where trunc(cre_dt) = trunc(sysdate) and old_ref_id like '%" + locs.get(i) + "%'";
                k =k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                String total = String.valueOf(k);
                String[] s = new String[2];
                
                query = "select loc_desc from fas_mst_location where loc_code = '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            String[] s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            RequestDispatcher view = request.getRequestDispatcher("/pages/totalDailyUploadbyLocation.jsp");
            view.forward(request, response);
            
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailyperLocationDownLoad(HttpServletRequest request, HttpServletResponse response) {
        String query = null;
        SaveToDb sb = new SaveToDb();
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        String[] s = new String[2];
        s[0] = "Location";
        s[1] = "Total";
        list.add(s);
        try {
            query = "select distinct loc_code from fas_mst_location";
            List<String> locs = sb.getList2(query);
            for (int i = 0; i < locs.size(); i++) {
                // query = "select count(*) from fas_int_doc where cre_date  >= '" + cre_date + "' and ref_id like '%"+ locs.get(i) +"%'";

                query = "select count(*) from fas_int_doc where  trunc(cre_date)  =  trunc(sysdate) and ref_id like '%" + locs.get(i) + "%' and approved_status is not null";
                int k = sb.getId(query);
                totalCount = totalCount + k;
               
                
                query = "select count(*) from fas_update_request where  trunc(cre_date)  = trunc(sysdate) and ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_int_renewal where trunc(cre_dt)  = trunc(sysdate) and old_ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
            
                 String total = String.valueOf(k);
                s = new String[2];
                
                query = "select loc_desc from fas_mst_location where loc_code = '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);

            //   String title = "locationReportFor" + cre_date + ".csv";
            String title = "locationReportFor" + cre_date + ".csv";
            File file = new File(title);
            Writer w = new FileWriter(file);
            CSVWriter writer = new CSVWriter(w);
            writer.writeAll(list);
            writer.close();
            
            byte[] bytearray = new byte[1048576];
            int size = 0;
            InputStream is = new FileInputStream(file);
            response.reset();
            response.setContentType("text/html");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("Content-Disposition", "attachment; filename= \"locationCount" + cre_date + ".csv" + "\"");
            response.setContentLength((int) file.length());
            while ((size = is.read(bytearray)) != -1) {
                response.getOutputStream().write(bytearray, 0, size);
                response.getOutputStream().flush();
            }
        } catch (Exception ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailycountTotal(HttpServletRequest request, HttpServletResponse response) {
        try {
            SaveToDb sb = new SaveToDb();
            String query = "select count(*) from fas_int_doc where trunc(cre_date)  >= trunc(sysdate)";
            int k = sb.getId(query);
            
            query = "select count(*) from fas_update_request where trunc(cre_date)  >= trunc(sysdate)";
            k = k + sb.getId(query);
            
            query = "select count(*) from fas_int_renewal where trunc(cre_dt)  >= trunc(sysdate)";
            k = k + sb.getId(query);
            
            String total = String.valueOf(k);
            request.setAttribute("total", total);
            RequestDispatcher view = request.getRequestDispatcher("/pages/totalDailyUpload.jsp");
            view.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailyDetailDownload(HttpServletRequest request, HttpServletResponse response) {
        List<String[]> list = new ArrayList<String[]>();
        SaveToDb sb = new SaveToDb();
        String[] header = new String[7];
        header[0] = "Passport_no";
        header[1] = "Surname";
        header[2] = "First_name";
        header[3] = "Middle_name";
        header[4] = "Date Of Birth";
        header[5] = "Sex";
        header[6] = "Ref_id";
        list.add(header);
        try {
            String query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where trunc(cre_date)  >= trunc(sysdate)";
            List<String[]> data = sb.getList5(query);
            for (int i = 0; i < data.size(); i++) {
                list.add(data.get(i));
            }
            
            query = "select ref_id from fas_update_request where trunc(cre_date) >= trunc(sysdate)";
            List<String> ref_ids = sb.getList2(query);
            
            for (int i = 0; i < ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + ref_ids.get(i) + "'";
                List<String[]> data1 = sb.getList5(query);
                list.add(data1.get(0));
            }
            
            query = "select old_ref_id from fas_int_renewal where trunc(cre_date)  >= trunc(sysdate)";
            List<String> old_ref_ids = sb.getList2(query);
            
            for (int i = 0; i < old_ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + old_ref_ids.get(i) + "'";
                List<String[]> data2 = sb.getList5(query);
                list.add(data2.get(0));
            }
            
            request.setAttribute("title", "General Detail of daily upload for :");
            
            String title = "detailReportFor" + cre_date + ".csv";
            File file = new File(title);
            Writer w = new FileWriter(file);
            CSVWriter writer = new CSVWriter(w);
            writer.writeAll(list);
            writer.close();
            
            byte[] bytearray = new byte[1048576];
            int size = 0;
            InputStream is = new FileInputStream(file);
            response.reset();
            response.setContentType("text/html");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("Content-Disposition", "attachment; filename= \"detailReportFor" + cre_date + ".csv" + "\"");
            response.setContentLength((int) file.length());
            while ((size = is.read(bytearray)) != -1) {
                response.getOutputStream().write(bytearray, 0, size);
                response.getOutputStream().flush();
            }
        } catch (Exception ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailyDetailbyLocationDownload(HttpServletRequest request, HttpServletResponse response) {
        List<String[]> list = new ArrayList<String[]>();
        String location = request.getParameter("location");
        String[] header = new String[7];
        header[0] = "Passport_no";
        header[1] = "Surname";
        header[2] = "First_name";
        header[3] = "Middle_name";
        header[4] = "Date Of Birth";
        header[5] = "Sex";
        header[6] = "Ref_id";
        SaveToDb sb = new SaveToDb();
        list.add(header);
        try {
            // String  query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where cre_date  >= '" + cre_date + "' and ref_id like '%" + location+ "%'";

            String query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where trunc(cre_date)  >= trunc(sysdate) and ref_id like '%" + location + "%'";
            List<String[]> data = sb.getList5(query);
            for (int i = 0; i < data.size(); i++) {
                list.add(data.get(i));
            }
            
            query = "select ref_id from fas_update_request where trunc(cre_date)  >= trunc(sysdate) and ref_id like '%" + location + "%'";
            List<String> ref_ids = sb.getList2(query);
            
            for (int i = 0; i < ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + ref_ids.get(i) + "'";
                List<String[]> data1 = sb.getList5(query);
                list.add(data1.get(0));
            }
            
            query = "select old_ref_id from fas_int_renewal where trunc(cre_dt)  >= trunc(sysdate) and old_ref_id like '%" + location + "%'";
            List<String> old_ref_ids = sb.getList2(query);
            
            for (int i = 0; i < old_ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + old_ref_ids.get(i) + "'";
                List<String[]> data2 = sb.getList5(query);
                list.add(data2.get(0));
            }
            
            request.setAttribute("title", "General Detail of daily upload for :");
            
            String title = "detailReportFor" + cre_date + ".csv";
            File file = new File(title);
            Writer w = new FileWriter(file);
            CSVWriter writer = new CSVWriter(w);
            writer.writeAll(list);
            writer.close();
            
            byte[] bytearray = new byte[1048576];
            int size = 0;
            InputStream is = new FileInputStream(file);
            response.reset();
            response.setContentType("text/html");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("Content-Disposition", "attachment; filename= \"DailyDetail" + cre_date + ".csv" + "\"");
            response.setContentLength((int) file.length());
            while ((size = is.read(bytearray)) != -1) {
                response.getOutputStream().write(bytearray, 0, size);
                response.getOutputStream().flush();
            }
        } catch (Exception ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailyDetail(HttpServletRequest request, HttpServletResponse response) {
        try {
            SaveToDb sb = new SaveToDb();
            String query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where trunc(cre_date)  >= trunc(sysdate)";
            List<String[]> data = sb.getList5(query);
            
            query = "select ref_id from fas_update_request where trunc(cre_date)  >= trunc(sysdate)";
            List<String> ref_ids = sb.getList2(query);
            
            for (int i = 0; i < ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + ref_ids.get(i) + "'";
                List<String[]> data1 = sb.getList5(query);
                data.add(data1.get(0));
            }
            
            query = "select old_ref_id from fas_int_renewal where trunc(cre_dt)  >= trunc(sysdate)";
            List<String> old_ref_ids = sb.getList2(query);
            
            for (int i = 0; i < old_ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + old_ref_ids.get(i) + "'";
                List<String[]> data2 = sb.getList5(query);
                data.add(data2.get(0));
            }
            
            request.setAttribute("title", "General Detail of daily upload for :");
            request.setAttribute("control", "general");
            request.setAttribute("data", data);
            RequestDispatcher view = request.getRequestDispatcher("/pages/detailDailyUpload.jsp");
            view.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void dailyDetailbyLocation(HttpServletRequest request, HttpServletResponse response) {
        String location = request.getParameter("location");
        String query = null;
        SaveToDb sb = new SaveToDb();
        try {
            query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where trunc(cre_date) >= trunc(sysdate) and ref_id like '%" + location + "%'";
            List<String[]> data = sb.getList5(query);
            
             query = "select ref_id from fas_update_request where trunc(cre_date)  >= trunc(sysdate) and ref_id like '%" + location + "%'";
            List<String> ref_ids = sb.getList2(query);
            
            for (int i = 0; i < ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + ref_ids.get(i) + "'";
                List<String[]> data1 = sb.getList5(query);
                data.add(data1.get(0));
            }
            
            query = "select old_ref_id from fas_int_renewal where trunc(cre_dt)  >= trunc(sysdate) and old_ref_id like '%" + location + "%'";
            List<String> old_ref_ids = sb.getList2(query);
            
            for (int i = 0; i < old_ref_ids.size(); i++) {
                query = "select passport_no, surname, first_name, middle_name, dob, sex, ref_id from fas_int_doc where ref_id  = '" + old_ref_ids.get(i) + "'";
                List<String[]> data2 = sb.getList5(query);
                data.add(data2.get(0));
            }
            
            query = "select loc_desc from fas_mst_location where loc_code = '" + location + "'";
            String loc = sb.getValue2(query);
            request.setAttribute("title", "Detail of daily upload for " + loc + " for ");
            request.setAttribute("data", data);
            request.setAttribute("location", location);
            RequestDispatcher view = request.getRequestDispatcher("/pages/detailDailyUpload.jsp");
            view.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void cumulativeperLocationDownload(HttpServletRequest request, HttpServletResponse response) {
        String query = null;
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        String[] s = new String[2];
        s[0] = "Location";
        s[1] = "Total";
        SaveToDb sb = new SaveToDb();
        list.add(s);
        try {
            query = "select distinct loc_code from fas_mst_location";
            List<String> locs = sb.getList2(query);
            for (int i = 0; i < locs.size(); i++) {
                query = "select count(*) from fas_int_doc where ref_id like '%" + locs.get(i) + "%'";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_int_renewal where old_ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_update_request where ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);;
                
                String total = String.valueOf(k);
                
                query = "select loc_desc from fas_mst_location where loc_code = '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                s = new String[2];
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            
            String title = "cumulativeRepAsAt" + cre_date + ".csv";
            File file = new File(title);
            Writer w = new FileWriter(file);
            CSVWriter writer = new CSVWriter(w);
            writer.writeAll(list);
            writer.close();
            
            byte[] bytearray = new byte[1048576];
            int size = 0;
            InputStream is = new FileInputStream(file);
            response.reset();
            response.setContentType("text/html");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("Content-Disposition", "attachment; filename= \"CumulativeRepAsAt" + cre_date + ".csv" + "\"");
            response.setContentLength((int) file.length());
            while ((size = is.read(bytearray)) != -1) {
                response.getOutputStream().write(bytearray, 0, size);
                response.getOutputStream().flush();
            }
        } catch (Exception ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void cumulativebyLocation(HttpServletRequest request, HttpServletResponse response) {
        String query = null;
        int totalCount = 0;
        SaveToDb sb = new SaveToDb();
        List<String[]> list = new ArrayList<String[]>();
        try {
            query = "select distinct loc_code from fas_mst_location";
            List<String> locs = sb.getList2(query);
            for (int i = 0; i < locs.size(); i++) {
                query = "select count(*) from fas_int_doc where  ref_id like '%" + locs.get(i) + "%'";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_update_request where  ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_int_renewal where  old_ref_id like '%" + locs.get(i) + "%'";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                String total = String.valueOf(k);
                String[] s = new String[2];
                
                query = "select loc_desc from fas_mst_location where loc_code= '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            String[] s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            RequestDispatcher view = request.getRequestDispatcher("/pages/cumulativeReportbyLocation.jsp");
            view.forward(request, response);
            
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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

    private void filterByRange(HttpServletRequest request, HttpServletResponse response) {
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");
        SaveToDb sb = new SaveToDb();
        String query = null;
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        
        System.out.println("voici les start_date et end_date " + startDate + "__" + endDate);
        
        try {
            if (location.equalsIgnoreCase("all")) {
                query = "select distinct loc_code from fas_mst_location";
            } else {
                query = "select loc_code from fas_mst_location where loc_id = '" + location + "'";
                
            }
            List<String> locs = sb.getList2(query);
            System.out.println("voici les de size du list " + locs.size());
            for (int i = 0; i < locs.size(); i++) {
                query = "select count(*) from fas_int_doc where ref_id like '" + locs.get(i) + "%' and trunc(cre_date)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd') ";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_update_request where ref_id like '%" + locs.get(i) + "%' and trunc(cre_date)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k+  sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_int_renewal where old_ref_id like '%" + locs.get(i) + "%' and trunc(cre_dt)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                String total = String.valueOf(k);
                String[] s = new String[2];
                query = "select loc_desc from fas_mst_location where loc_code= '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            String[] s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            request.setAttribute("start_date", startDate);
            request.setAttribute("end_date", endDate);
            RequestDispatcher view = request.getRequestDispatcher("/pages/rangeReportbyLocation.jsp");
            view.forward(request, response);
            
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void rangeDownload(HttpServletRequest request, HttpServletResponse response) {
        String query = null;
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        String[] s = new String[2];
        s[0] = "Location";
        s[1] = "Total";
        list.add(s);
        SaveToDb sb = new SaveToDb();
        try {
            query = "select distinct loc_code from fas_mst_location";
            List<String> locs = sb.getList2(query);
            for (int i = 0; i < locs.size(); i++) {
                query = "select count(*) from fas_int_doc where ref_id like '%" + locs.get(i) + "%' and trunc(cre_date)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_int_renewal where old_ref_id like '%" + locs.get(i) + "%' and trunc(cre_dt)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_update_request where ref_id like '%" + locs.get(i) + "%' and trunc(cre_date) between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                String total = String.valueOf(k);
                
                query = "select loc_desc from fas_mst_location where loc_code = '" + locs.get(i) + "'";
                String loc = sb.getValue2(query);
                
                s = new String[2];
                s[0] = loc;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            
            String title = "From" + startDate + "To" + endDate + ".csv";
            File file = new File(title);
            Writer w = new FileWriter(file);
            CSVWriter writer = new CSVWriter(w);
            writer.writeAll(list);
            writer.close();
            
            byte[] bytearray = new byte[1048576];
            int size = 0;
            InputStream is = new FileInputStream(file);
            response.reset();
            response.setContentType("text/html");
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setHeader("Content-Disposition", "attachment; filename= \"Range Report Between :" + startDate + " and " + endDate + ".csv" + "\"");
            response.setContentLength((int) file.length());
            while ((size = is.read(bytearray)) != -1) {
                response.getOutputStream().write(bytearray, 0, size);
                response.getOutputStream().flush();
            }
        } catch (Exception ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
    /** Addeded by Bayo for users Report **/
    
    private void filterByUser(HttpServletRequest request, HttpServletResponse response) {
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        //String location = request.getParameter("location");
        String users_id = request.getParameter("usersupload");
        SaveToDb sb = new SaveToDb();
        String query = null;
        int totalCount = 0;
        List<String[]> list = new ArrayList<String[]>();
        
        System.out.println("voici les start_date et end_date " + startDate + "__" + endDate);
        
        try {
            if (users_id.equalsIgnoreCase("USERSID")) {
                query = "select  distinct user_id , first_name ,last_name from fas_mst_users";
            } else {
                query = "select  distinct user_id , first_name ,last_name from fas_mst_users where user_id = '"+users_id+"'";
                
            }
            List<String> byusers = sb.getList2(query);
            System.out.println("voici les de size du list " + byusers.size());
            for (int i = 0; i < byusers.size(); i++) {
                query = "select count(*) from fas_int_doc where cre_user_id  = '"+byusers.get(i)+"' and trunc(cre_date)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd') ";
                int k = sb.getId(query);
                totalCount = totalCount + k;
                
                query = "select count(*) from fas_update_request where submitted_by = '"+byusers.get(i)+"' and trunc(cre_date)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k+  sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                query = "select count(*) from fas_int_renewal where cre_user_id = '"+byusers.get(i)+"' and trunc(cre_dt)  between  to_date('" + startDate + "','YYYY-mm-dd') and  to_date('" + endDate + "','YYYY-mm-dd')";
                k = k + sb.getId(query);
                totalCount = totalCount + sb.getId(query);
                
                String total = String.valueOf(k);
                String[] s = new String[2];
                //query = "select loc_desc from fas_mst_location where loc_code= '" + locs.get(i) + "'";
				  query =  "select   first_name  ||  '   ' || last_name from fas_mst_users where user_id = '"+byusers.get(i)+"'";
                String usersreturn = sb.getValue2(query);
                
                s[0] = usersreturn;
                s[1] = total;
                list.add(s);
            }
            String totalCounts = String.valueOf(totalCount);
            String[] s = new String[2];
            s[0] = "Total";
            s[1] = totalCounts;
            list.add(s);
            request.setAttribute("data", list);
            request.setAttribute("start_date", startDate);
            request.setAttribute("end_date", endDate);
            RequestDispatcher view = request.getRequestDispatcher("/pages/usersReportbyCount.jsp");
            view.forward(request, response);
            
        } catch (ServletException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Statistic.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
}
