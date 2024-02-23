package com.fasyl.newjobBo;

//import com.fasyl.Dao.UserDao;
import com.fasyl.util.Encryption;
import com.fasyl.vo.UserRoleVo;
import com.fasyl.vo.UserVo;
import java.io.IOException;
import java.io.PrintStream;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
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

@WebServlet(name = "CreateUser", urlPatterns = {"/CreateUser"})
public class CreateUser
        extends HttpServlet {

    protected void processRequest(HttpServletRequest request,
HttpServletResponse response)
            throws ServletException, IOException {
SaveToDb sb = new SaveToDb();
        if ((request.getParameter("changePassword")) != null) {
            changePassword(request, response);
        } else if ((request.getParameter("editUser")) != null) {
            getUserInfo(request, response);
        } else if ((request.getParameter("submitUserUpdate")) != null) {
            updateUser(request, response);
        } else {
            boolean saveUser = true;
        HttpSession session = request.getSession(true);
        String userId = (String) session.getAttribute("userid");
        ServletContext context = getServletContext();
       // UserDao ud = new UserDao();
        UserVo uv = loadRequest(request);
        /**   Added by Bayo   **/

        List<String> usernames = sb.getList2("select user_id from fas_mst_users");
        System.out.print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" + usernames);
        for (int i = 0; i < usernames.size(); i++) {
           if (usernames.get(i).equalsIgnoreCase(userId)) {
               request.setAttribute("message", "Username Exists");
                request.setAttribute("status", "error");
                request.setAttribute("UserVo", uv);
                saveUser = false;
                RequestDispatcher rd =
context.getRequestDispatcher("/pages/createdUser.jsp");
                rd.forward(request, response);
           }

        }
        if (saveUser) {
        String columns = "user_id, user_name, password, first_name,middle_name, last_name, user_loc_id, user_role_id, user_cre_id,user_auth_id, active";
        String values = "'"+uv.getId() +"','" + uv.getId() + "', '" +Encryption.encrypt(uv.getPassword()) + "','" + uv.getFirstName() +"','" + uv.getMiddleName() + "','" + uv.getLastName()+ "','" + uv.getLocationId() + "', '" + uv.getRoleId() + "', '" +session.getAttribute("username") + "', '" +uv.getAuthorizer() + "', 'Y'";
            String query = "insert into fas_mst_users(" + columns + ")values(" + values + ")";
            String result = sb.persist(query);

            if (result == "success") {
                request.setAttribute("message", "User created Succesfully");
                request.setAttribute("status", "Success");
            } else {
                request.setAttribute("message", "User creation Unsuccesful");
                request.setAttribute("status", "error");
            }
            RequestDispatcher rd =
             context.getRequestDispatcher("/pages/homepage.jsp");
            rd.forward(request, response);
        }
        }
    }

    protected void changePassword(HttpServletRequest request,
HttpServletResponse response) throws ServletException, IOException {
        SaveToDb sb = new SaveToDb();
        HttpSession session = request.getSession(true);
        String old_pass = request.getParameter("old password");
        String password = request.getParameter("new password");
        String password_confirm = request.getParameter("new password confirm");
        String username = (String) session.getAttribute("username");
        String pas = sb.getValue2("select password from fas_mst_users where user_id = '" + username + "'");
        old_pass = Encryption.encrypt(old_pass);
        if (password.equalsIgnoreCase(password_confirm)) {
        if (old_pass.equalsIgnoreCase(pas)) {
            password = Encryption.encrypt(password);
            String query = "update fas_mst_users set password = '" +
password + "' where user_id = '" + username + "'";
            String result = sb.persist(query);

            if (result == "success") {
                request.setAttribute("message", "Password Change Succesful");
                request.setAttribute("status", "Success");
            } else {
                request.setAttribute("message", "Password Change Unsuccesful");
                request.setAttribute("status", "error");
            }
            RequestDispatcher view =
request.getRequestDispatcher("/pages/homepage.jsp");
            view.forward(request, response);
        } else {
            request.setAttribute("message", "Old Password Incorrect");
            request.setAttribute("status", "error");
            RequestDispatcher view =
request.getRequestDispatcher("/pages/homepage.jsp");
            view.forward(request, response);
        }
        } else {
             request.setAttribute("message", "new passwords do not match");
            request.setAttribute("status", "error");
            RequestDispatcher view =
request.getRequestDispatcher("/pages/homepage.jsp");
            view.forward(request, response);
        }
    }

    public UserVo loadRequest(HttpServletRequest request) {
        UserVo uv = new UserVo();
        uv.setUserName(request.getParameter("userName"));
        uv.setFirstName(request.getParameter("firstName"));
        uv.setPassword(request.getParameter("password"));
        System.out.println(request.getParameter("firstName"));
        uv.setId(request.getParameter("id"));
        uv.setLastName(request.getParameter("lastName"));
        uv.setRoleId(request.getParameter("roleId"));
        uv.setGender(request.getParameter("gender"));
        uv.setLocationId(request.getParameter("location"));
        uv.setMiddleName(request.getParameter("middleName"));
        uv.setAuthorizer(request.getParameter("authorizer"));
        return uv;
    }
  //user_id, user_name, password, first_name, middle_name, last_name,user_loc_id, user_role_id, user_cre_id, user_auth_id, active
    public void getUserInfo(HttpServletRequest request,
HttpServletResponse response) {
    try {
        SaveToDb sb = new SaveToDb();
        ServletContext context = getServletContext();
        String userId = request.getParameter("userId");
        UserVo uv = new UserVo();
        
        
        List<String[]> res = sb.getListss("select user_name, first_name, last_name, middle_name, user_role_id, user_loc_id, user_auth_id, active from fas_mst_users where user_id ='" + userId + "'", 8);
        if (!res.isEmpty()) {
            uv.setUserName(res.get(0)[0]);
            uv.setFirstName(res.get(0)[1]);
            uv.setLastName(res.get(0)[2]);
            uv.setMiddleName(res.get(0)[3]);
            uv.setRoleId(res.get(0)[4]);
            uv.setLocationId(res.get(0)[5]);
            uv.setAuthorizer(res.get(0)[6]);
            uv.setActive(res.get(0)[7]);
        }

        uv.setRole(sb.getValue("role_desc", "fas_mst_role","role_id", uv.getRoleId()));
        uv.setLocation(sb.getValue("loc_desc","fas_mst_location", "loc_id", uv.getLocationId()));
        request.setAttribute("UserVo", uv);

         RequestDispatcher view =
context.getRequestDispatcher("/pages/createdUser.jsp");
         view.forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE,
null, ex);
        }
    }

    private void createLocation(HttpServletRequest request,
HttpServletResponse response){
        SaveToDb sb = new SaveToDb();
        String loc_code = request.getParameter("loc_code");
        String loc_desc = request.getParameter("loc_desc");
        boolean saveLocation = true;
        int k = 0;
        ServletContext context = getServletContext();
         List<String> codes = sb.getList2("select loc_code from fas_mst_location");
         List<String> desc = sb.getList2("select loc_desc from fas_mst_location");
         List<String> loc_id = sb.getList2("select loc_id from fas_mst_location");
        for (int i = 0; i < codes.size(); i++) {
           if (codes.get(i).equalsIgnoreCase(loc_code)) {
               try {
                   request.setAttribute("message", "Code Already Used,Location Creation Failed");
                   request.setAttribute("status", "error");
                   saveLocation = false;
                   RequestDispatcher rd =
context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {

Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE, null,
ex);
               }
           }

           if (desc.get(i).equalsIgnoreCase(loc_desc)) {
               try {
                   request.setAttribute("message", "Description Exists, Location Creation Failed");
                   request.setAttribute("status", "error");
                   saveLocation = false;
                   RequestDispatcher rd =
context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {

Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE, null,
ex);
               }
           }
            String  idd = loc_id.get(i);
            int idc = Integer.parseInt(idd);
            if (idc > k){ k = idc; }
    }
        if (saveLocation) {
         k++;
         String new_id = String.valueOf(k);
         String zeros = "";
         for(int i = 0; i < (3-new_id.length()); i++ ){
         zeros = zeros + "0";
         }
         new_id = zeros + k;

            String columns = "loc_id, loc_code, loc_desc";
            String values = "'"+new_id +"','" + loc_code + "', '" +
loc_desc + "'";
            String query = "insert into fas_mst_location(" + columns +
") values(" + values + ")";
            String result = sb.persist(query);
         try {
                   request.setAttribute("message", "Location Creation Successful");
                   request.setAttribute("status", "success");
                   RequestDispatcher rd =
context.getRequestDispatcher("/pages/homepage.jsp");
                   rd.forward(request, response);
               } catch (Exception ex) {

Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE, null,
ex);
               }
        }
    }

    private void updateUser(HttpServletRequest request,
HttpServletResponse response){
        try {
            SaveToDb sb = new SaveToDb();
            String columns = "user_id, user_name, password,first_name, middle_name, last_name, user_loc_id, user_role_id,user_auth_id, active";

            String user_id = request.getParameter("userName");
            String first_name = request.getParameter("firstName");
            String middle_name = request.getParameter("middleName");
            String last_name = request.getParameter("lastName");
            String user_loc = request.getParameter("location");
            String user_loc_id = sb.getValue("loc_id","fas_mst_location", "loc_desc", user_loc);
            String user_role = request.getParameter("role");
            String user_role_id = sb.getValue("role_id","fas_mst_role", "role_desc", user_role);
            String user_auth_id = request.getParameter("authorizer");
            String active = request.getParameter("status");
            System.out.println("AYAM PASSWORD ......." +
            request.getParameter("password"));
            String password = Encryption.encrypt("password");

            String query = "update fas_mst_users set first_name = '" +first_name + "', middle_name ='" + middle_name + "', last_name = '" +last_name + "', ";
            query = query + "user_loc_id = '" + user_loc_id +"',user_role_id = '" + user_role_id + "', user_auth_id = '" +user_auth_id + "', active = '" + active + "', ";
            query = query + "password = '" +password+ "' where user_id = '" + user_id + "'";

            String result = sb.persist(query);
            ServletContext context = getServletContext();
            if (result == "success") {
                request.setAttribute("message", "User Updated Succesfully");
                request.setAttribute("status", "Success");
            } else {
                request.setAttribute("message", "User Update Unsuccesful");
                request.setAttribute("status", "error");
            }
            RequestDispatcher rd = context.getRequestDispatcher("/pages/homepage.jsp");
            rd.forward(request, response);
        } catch (ServletException ex) {
            Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE,null, ex);
        } catch (IOException ex) {
            Logger.getLogger(CreateUser.class.getName()).log(Level.SEVERE,null, ex);
        }
    }

    protected void doGet(HttpServletRequest request,
HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request,
HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    public String getServletInfo() {
        return "Short description";
    }
}