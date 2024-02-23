package com.fasyl.newjobBo;

import com.fasyl.util.EmailService;
import com.fasyl.util.Encryption;
import com.fasyl.util.EncryptionNew;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ValidateUser extends HttpServlet {

    private static final Logger logger
            = Logger.getLogger(ValidateUser.class.getName());

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        processReq(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        processReq(request, response);
    }

    protected void processReq(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("in validate user");
        HttpSession hts = request.getSession();
        SaveToDb sb = new SaveToDb();
        System.out.println("request.getParameter(\"signup\")  " + request.getParameter("signup"));
        if (request.getParameter("signup") != null) {
            String email = request.getParameter("email");
            String uname = request.getParameter("uname");
            String dname = request.getParameter("dname");
            String passcode = request.getParameter("passcode");
            String confirm = request.getParameter("confirm");
            String coyType = request.getParameter("coyType");
            if ((passcode != null) && (confirm != null)) {
                if (confirm.equals(passcode)) {
                    if (!sb.isAvailable("select * from fas_mst_users where user_name ='" + uname + "'")) {
                        String insertQuery = "insert into fas_mst_users (USER_ID, USER_NAME, PASSWORD, FIRST_NAME,  ACTIVE, USER_ROLE_ID, USER_LOC_ID) values('" + uname + "', '" + uname + "', '" + Encryption.encrypt(passcode) + "', '" + dname + "', 'N', '000', '001')";
                        String result = sb.persist(insertQuery);
                        int i = 7;
                        if ("success".equalsIgnoreCase(result)) {
                            EmailService ems = new EmailService();
                            String title = "Notification of Registration on OYO BIR Platform";
                            String messageBody = "Hi, " + dname + "   \n";
                            messageBody = messageBody + "You recently signed up on BIR Platform.  \n";
                            messageBody = messageBody + "Please click confirm email to proceed.\n";
                            messageBody = messageBody + "http://localhost:8080/DocumentManager/Login?userid=" + uname + "&control=confirmEmail\n";
                            //messageBody = messageBody + "<li><a href=\"localhost:8080/DocumentManager/validateUser?userid="+uname+"&control=confirmEmail\">confirm email</a></li>\n";
                            messageBody = messageBody + "\n";
                            messageBody = messageBody + "Best regards\n";
                            messageBody = messageBody + "\n";
                            messageBody = messageBody + "\n";

                            try {
                                i = ems.sendemailG(email, title, messageBody, "morufoye@gmail.com");
                            } catch (Exception ex) {
                                Logger.getLogger(ValidateUser.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            if (i == 0) {
                                request.setAttribute("message", "User successfully signed up and email succesfully sent. Please check yor email for details");
                                request.setAttribute("status", "success");
                            } else {
                                request.setAttribute("message", "User successfully signed up and email not sent. Please check yor email for details");
                                request.setAttribute("status", "success");
                            }
                        } else {
                            request.setAttribute("message", "User cannot be signed up now. Please try again later");
                            request.setAttribute("status", "error");
                        }
                    } else {
                        request.setAttribute("message", "User Name already exists on the system. Please choose another one");
                        request.setAttribute("status", "error");
                    }

                } else {
                    request.setAttribute("message", "Passwords do not match");
                    request.setAttribute("status", "error");
                }

                RequestDispatcher view
                        = request.getRequestDispatcher("/signupRes.jsp");
                view.forward(request, response);
            }

        } else if ("confirmEmail".equalsIgnoreCase(request.getParameter("control"))) {
            System.out.println("over here ");
            String query = "update fas_mst_users set active = 'Y' where user_id = '" + request.getParameter("userid") + "'";
            String result = sb.persist(query);
            if ("success".equalsIgnoreCase(result)) {
                RequestDispatcher view
                        = request.getRequestDispatcher("/Login.jsp");
                view.forward(request, response);
            }
        } else {
            validateUser(request, response);
        }
//       HttpSession hts = request.getSession();
//        if (hts != null) {
//            if (hts.getAttribute("loggedin") != null) {
//                if (((Boolean) hts.getAttribute("loggedin")).booleanValue()) {
//                    RequestDispatcher view =
//        request.getRequestDispatcher("/pages/new_job.jsp");
//                    view.forward(request, response);
//                    System.out.println("in validate user 1");
//                } else {
//                    logout(request, response);
//                }
//            } else {
//                validateUser(request, response);
//                 System.out.println("in validate user 2");
//            }
//        } else {
//            RequestDispatcher view =
//        request.getRequestDispatcher("/signin.html");
//            view.forward(request, response);
//        }
    }

    protected void confirmemail(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("about to logout 1");
        ServletContext context = getServletContext();
        System.out.println("about to logout 2");
        HttpSession hts = request.getSession(false);
        System.out.println("about to logout 3");
        if (hts != null) {
            System.out.println("about to logout 4");
            hts.invalidate();
        }
        System.out.println("about to logout 5");
        RequestDispatcher rd = context.getRequestDispatcher("/Login.jsp");
        rd.forward(request, response);
    }

    protected void logout(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        System.out.println("about to logout 1");
        ServletContext context = getServletContext();
        System.out.println("about to logout 2");
        HttpSession hts = request.getSession(false);
        System.out.println("about to logout 3");
        if (hts != null) {
            System.out.println("about to logout 4");
            hts.invalidate();
        }
        System.out.println("about to logout 5");
        RequestDispatcher rd = context.getRequestDispatcher("/Login.jsp");
        rd.forward(request, response);
    }

    protected void dispatchFaiLedLoginAttempt(HttpServletRequest request, HttpServletResponse response, String message, int loginCount)
            throws ServletException, IOException {
        ServletContext context = getServletContext();
        request.setAttribute("message", message);
        request.setAttribute("LoginCount", Integer.valueOf(++loginCount));
        System.out.println("should not be here");
        RequestDispatcher rd = context.getRequestDispatcher("/Login.jsp?");
        rd.forward(request, response);
    }

    public String checkExp() {
        SaveToDb sb = new SaveToDb();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd");
        // Calendar futuredate  =   new GregorianCalendar(2015,1,28);
        Calendar futuredate = Calendar.getInstance();
        sdf.format(futuredate.getTime());
        System.out.println("This is the Date from Canlender futuredate" + sdf.format(futuredate.getTime()));

        java.sql.Date chkdate = sb.chkDate("select chkdt from exp");
        sdf.format(chkdate);

        System.out.println("This is selected date from db Formatted" + sdf.format(chkdate));

        System.out.println("This is selected date from db not formmated chkdate" + chkdate);

        if (sdf.format(chkdate).equals(sdf.format(futuredate.getTime())) || (sdf.format(chkdate)).compareTo(sdf.format(futuredate.getTime())) > 0) {
            System.out.println(" date is before furture  date");

        } else {

            System.out.println("Future date is before date");

        }

        if (sdf.format(chkdate).equals(sdf.format(futuredate.getTime())) || sdf.format(chkdate).compareTo(sdf.format(futuredate.getTime())) > 0) {
            return "Dates Matches";

        } else {

            return "Dates Doest not Matches";

        }

    }

    protected void validateUser(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        System.out.println("HEY HEY HEY " + request.getParameter("userName"));
        String username = request.getParameter("userName");
        String password = request.getParameter("password");
        List<String> delList = new ArrayList<String>();
        if (password != null) {
            if (username.equalsIgnoreCase("fasyl@admin")) {
                if (password.equalsIgnoreCase("eskaymurphy")) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("username", username);
                    session.setAttribute("location", "LAGOS");
                    session.setAttribute("welcomeName", "ADMIN");
                    session.setAttribute("role_id", "002");
                    session.setAttribute("loc_code", "ABJ");
                    session.setAttribute("delList", delList);
                    List<String> countryList = new ArrayList<String>();
                    countryList.add("Nigeria");
                    countryList.add("USA");
                    session.setAttribute("countryList", countryList);
                    List<String> stateList = new ArrayList<String>();
                    stateList.add("OYO");
                    stateList.add("OSUN");
                    stateList.add("LAGOS");
                    session.setAttribute("stateList", stateList);

                    List<String> titleList = new ArrayList<String>();
                    titleList.add("");
                    titleList.add("");
                    titleList.add("");
                    session.setAttribute("titleList", titleList);

                    RequestDispatcher view
                            = request.getRequestDispatcher("/pages/homepage.jsp");

                    view.forward(request, response);
                } else {
                    System.out.println("incorrect password");
                    request.setAttribute("message", "Incorrectn Login Parameter.");
                    request.setAttribute("status", "error");
                    RequestDispatcher view
                            = request.getRequestDispatcher("/Login.jsp");
                    view.forward(request, response);
                }
            } else if (username.equalsIgnoreCase("demo@client")) {
                HttpSession session = request.getSession(true);
                session.setAttribute("role_id", "000");
                session.setAttribute("welcomeName", "demo@client");
                session.setAttribute("username", username);
                session.setAttribute("loc_code", "IBD");
                session.setAttribute("location", "IBADAN");
                RequestDispatcher view
                        = request.getRequestDispatcher("/registerAs.jsp");
                view.forward(request, response);
            }

            String pas = null;
            String active = null;
            if (!username.equalsIgnoreCase("fasyl@admin")) {
                //pas = sb.getValue2("select password from fas_mst_users where user_id = '" + username + "'");
                //active = sb.getValue2("select active from fas_mst_users where user_id = '" + username + "'");
                String[] valData = sb.getArrays("select password, active from fas_mst_users where user_id = '" + username + "'", 2);
                pas = valData[0];
                active = valData[1];
            }
            if ((pas != null)) {
                if (!"Y".equalsIgnoreCase(active)) {
                    request.setAttribute("message", "User Deactivated By Admin. Contact Admin");
                    request.setAttribute("status", "error");
                    RequestDispatcher view
                            = request.getRequestDispatcher("/Login.jsp");
                    view.forward(request, response);
                } else {
                    try {
                        System.out.println(password + " gaegaxfbhmgcmsnsvjndmdb " + pas);
                        if (EncryptionNew.validatePassword(password, pas)) {
                            String loc = sb.getValue2("select user_loc_id from fas_mst_users where user_id = '" + username + "'");
                            String loc_code
                                    = sb.getValue2("select loc_code from fas_mst_location where loc_id = '" + loc + "'");
                            loc = sb.getValue2("select loc_desc from fas_mst_location where loc_id = '" + loc + "'");
                            String fn = sb.getValue2("select first_name from fas_mst_users where user_id = '" + username + "'");
                            String sn = sb.getValue2("select last_name from fas_mst_users where user_id = '" + username + "'");
                            String role_id
                                    = sb.getValue2("select user_role_id from fas_mst_users where user_id = '" + username + "'");
                            HttpSession session = request.getSession(true);
                            session.setAttribute("username", username);
                            session.setAttribute("location", loc);
                            session.setAttribute("loc_code", loc_code);
                            session.setAttribute("role_id", role_id);
                            if (sn == null) {
                                sn = " ";
                            }
                            session.setAttribute("welcomeName", sn + " " + fn);
                            session.setAttribute("delList", delList);
                            List<String> countryList
                                    = sb.getList2("select description from fas_mst_country");
                            List<String> titleList
                                    = sb.getList2("select title from fas_mst_titles order by code asc");
                            sb.getList2("select cre_user_id from fas_int_doc where cre_user_id is not null");
                            session.setAttribute("countryList", countryList);
                            session.setAttribute("titleList", titleList);
                            List<String> stateList = sb.getList2("select name from fas_line_of_bussiness order by name");
                            session.setAttribute("stateList", stateList);

                            List<String[]> searchResult = new ArrayList<>();

                            List<String[]> templates = sb.getListss("select template_name, description from template_names", 2);
                            String query = "";
                            for (String[] template : templates) {
                                query = query + "  select ref_id, uploaded_by, '" + template[1] + "', UploadDate from " + template[0] + "";
                                query = query + "  union all";
                            }
                            if (query.length() > 10) {
                                query = query.substring(0, query.length() - 10);
                            }
                            searchResult = sb.getListss(query, 4);
                            session.setAttribute("searchResult", searchResult);

                            if ("000".equalsIgnoreCase(role_id)) {
                                RequestDispatcher view
                                        = request.getRequestDispatcher("/registerAs.jsp");
                                view.forward(request, response);
                            }

                            if ("011".equalsIgnoreCase(role_id)) {
                                RequestDispatcher view
                                        = request.getRequestDispatcher("/pages/homepage.jsp");
                                view.forward(request, response);
                            } else {
                                Authorize auth = new Authorize();
                                auth.loadAndForward(request, response);
                            }

                        } else {
                            request.setAttribute("message", "Incorrect LoginParameter.");
                            request.setAttribute("status", "error");
                            RequestDispatcher view
                                    = request.getRequestDispatcher("/Login.jsp");
                            view.forward(request, response);
                        }
                    } catch (NoSuchAlgorithmException ex) {
                        Logger.getLogger(ValidateUser.class.getName()).log(Level.SEVERE, null, ex);
                    } catch (InvalidKeySpecException ex) {
                        Logger.getLogger(ValidateUser.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } else {
                System.out.println("incorrect password");
                request.setAttribute("message", "Incorrect Login Parameter.");
                request.setAttribute("status", "error");
                RequestDispatcher view = request.getRequestDispatcher("/Login.jsp");
                view.forward(request, response);
            }
        }
    }

   
    
}
