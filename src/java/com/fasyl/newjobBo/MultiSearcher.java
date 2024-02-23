package com.fasyl.newjobBo;

import com.fasyl.vo.LoaderVo;
import java.io.IOException;
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

@WebServlet(name = "MultiSearcher", urlPatterns = {"/MultiSearcher"})
public class MultiSearcher extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Logger.getLogger(MultiSearcher.class.getName()).log(Level.INFO, null, " **** in multi searcher servlet ***** ");
        response.setContentType("text/html;charset=UTF-8");
        SaveToDb sb = new SaveToDb();
        String searchType = request.getParameter("SearchType");
        String responseDestination = request.getParameter("responseDestination");
        String update = request.getParameter("update");
        String begin = request.getParameter("begin");
        HttpSession session = request.getSession(true);
        session.setAttribute("banner", null);
        if (searchType != null) {
            if (searchType.equalsIgnoreCase("next")) {
                new MultiSearcherBo().getNext(request, response, responseDestination);
            } else if (searchType.equalsIgnoreCase("previous")) {
                new MultiSearcherBo().getPrevious(request, response, responseDestination);
            } else if ("searchAll".equalsIgnoreCase(searchType)) {
                List<String[]> templates = sb.getListss("select template_name, description from template_names", 2);
                String query = "";
                for (String[] template : templates) {
                    query = query + "  select ref_id, uploaded_by, '" + template[1] + "' from " + template[0] + "";
                    query = query + "  union all";
                }
                if (query.length() > 10) {
                    query = query.substring(0, query.length() - 10);
                }
                List<String[]> searchResult = sb.getListss(query, 3);
                session.setAttribute("searchResult", searchResult);
            } else {
                session.setAttribute("searchList", null);
                session.setAttribute("next", null);
                session.setAttribute("previous", null);
                if (request.getParameter("beg") != null) {
                    session.setAttribute("saach", null);
                    session.setAttribute("pageRange", null);
                }
                new MultiSearcherBo().multiSearcher(request, response, responseDestination);
            }
        } else if (update != null) {
            session = request.getSession(true);
            String passPortNumber = request.getParameter("passportNumber").toUpperCase();
            LoaderVo lv = new LoaderVo();
//            lv = LoadValues.initiateLoader(lv);
            session.setAttribute("valueHolder", lv);

            List<String> imageList = new ArrayList<String>();
            session.setAttribute("documents", imageList);

            List<String> imageUpdate = new ArrayList<String>();
            session.setAttribute("documentUpdates", imageUpdate);

            String ref_id = sb.getValue2("select ref_id from fas_int_doc where passport_no = '" + passPortNumber + "' and approved_status != 'N'");

            /**
             * Added by Bayo to make sure un approved document can not be
             * updated *
             */
            if (ref_id != null) {
                //String[] values = LoadValues.loadValues(ref_id);
                //session.setAttribute("values", values);
                // session.setAttribute("applicationId", values[9]);

                RequestDispatcher view = request.getRequestDispatcher("/pages/detail_update.jsp");
                view.forward(request, response);
            } else {
                request.setAttribute("message", " No record found ,this passport number may be waiting for authorization");
                request.setAttribute("status", "error");
                RequestDispatcher view = request.getRequestDispatcher("/pages/homepage.jsp");
                view.forward(request, response);
            }
        } else if (begin != null) {
            session = request.getSession(true);
            String user = (String) session.getAttribute("username");
            String query = "";
            String next = request.getParameter("next");
            String prev = request.getParameter("previous");

            System.out.println("voici les du next" + next);
            System.out.println("voici les du prev" + prev);

            String[] range = (String[]) session.getAttribute("pageRange2");

            if (request.getParameter("control") != null) {
                range = null;
            }

            if (prev != null) {
                range = GetRange.retRange2(range);
            } else {
                range = GetRange.retRange(range);
            }
            int kount = 0;
            String count = "0";

            int kk = Integer.parseInt(range[0]);
            int mm = kk + 2;
            range[1] = String.valueOf(mm);
            if (mm == 2) {
                range[1] = "3";
            }

            session.setAttribute("pageRange2", range);

            //query = "select * from ( select ref_id, row_number() over (order by ref_id) rn from fas_int_doc where cre_user_id = '" + user + "' and approved_status = 'D' ) where rn between " + range[0] + " and " + range[1] + " order by rn";
            List<String> templates = sb.getList2("select template_name from template_names");
            for (int i = 0; i < templates.size(); i++) {
                query = query + "  select ref_id, uploaded_by from " + templates.get(i) + " where uploaded_by ='" + user + "' and approved_status = 'D'";
                query = query + "  union all";
            }
            query = query.substring(0, query.length() - 10);
            List<String[]> list = sb.getList3(query);
            if (begin.equalsIgnoreCase("yes")) {
                int start = 0;
                int end = 10;
                session.setAttribute("beging", start);
                session.setAttribute("end", end);
                request.setAttribute("list", list);

                for (int i = 0; i < templates.size(); i++) {
                    kount = kount + sb.getId("select count(*) from " + templates.get(i) + " where uploaded_by ='" + user + "' and approved_status = 'D'");
                }

                //query = "select count(*) from fas_int_doc where cre_user_id = '" + user + "' and approved_status = 'D'";
                //query = "select count(*) from fas_int_doc where approved_status = 'N'";
                //kount = sb.getId(query);
                count = String.valueOf(kount);

                session.setAttribute("kount", count);
                request.setAttribute("count", count);
                request.setAttribute("upper", range[0]);
                request.setAttribute("lower", range[1]);
                RequestDispatcher view = request.getRequestDispatcher("/pages/to_correct_list.jsp");
                view.forward(request, response);
            } else if (searchType.equalsIgnoreCase("previous")) {
                new MultiSearcherBo().getPrevious(request, response, responseDestination);
            } else {
                session.setAttribute("searchList", null);
                session.setAttribute("next", null);
                session.setAttribute("previous", null);
                new MultiSearcherBo().multiSearcher(request, response, responseDestination);
            }

        }

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
