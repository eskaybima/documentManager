<%--
    Document   : homepage
    Created on : Sep 5, 2013, 12:46:52 PM
    Author     : admin
--%>




<%--
    Document   : homepage
    Created on : Sep 5, 2013, 12:46:52 PM
    Author     : admin
--%>


<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.List"%>
<%@page import="com.fasyl.vo.UserVo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Edit User</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" +
request.getContextPath() + "/Login.jsp");
        %>
        <jsp:include page="pagesimport.jsp"></jsp:include>
        </head>

        <body id="background">
        <jsp:include page="header.jsp"></jsp:include>
        <jsp:include page="leftMenu.jsp"></jsp:include>


            <div id="bodyhold">
                <div id="bodycon">

                <%!
                    String roleId = null;
                    String roleName = null;
                    SaveToDb sb = new SaveToDb();
                %>

                <% UserVo uv = null;

                    if (request.getAttribute("UserVo") != null) {
                        uv = (UserVo) request.getAttribute("UserVo");
                       // roleId = uv.getRoleId();

                    }
                %>

                <%
    List<String[]> locss = sb.getList3("select loc_id, loc_desc from fas_mst_location");
                %>

                <form action="${pageContext.request.contextPath}/CreateUser" method="post">
                   <div style="padding-left: 30px;">
                        <table class="table">
                            <input type ="hidden" name="submitUserUpdate"  value = "update" >

                            <tr>
                                <td>User Id:</td>
                                <td><%= uv.getUserName()%></td>
                            </tr>

                            <tr>
                                <td><input type="hidden"class="inputtext" id="userNameCd" name="userName" value="<%=uv.getUserName()%>" required onChange="toUppercase('userNameCd')"style="color: red;"/></td>
                            </tr>
                            <tr>
                                <td>First Name:</td>
                                <td><input type="text"class="inputtext" id="firstNameCd" name="firstName" value="<%=uv.getFirstName()%>" requiredonChange="toUppercase('firstNameCd')"/></td>
                            </tr>
                            <tr>
                                <td>SurName:</td>
                                <td><input type="text"class="inputtext" id="lastNameCd" name="lastName" value="<%=uv.getLastName()%>"onChange="toUppercase('lastNameCd')"required/></td>
                            </tr>

                            <tr>
                                <td>Middle Name:</td>
                                <td><input type="text"class="inputtext" id="lastNameCd" name="middleName" value="<%=uv.getMiddleName()%>" onChange="toUppercase('lastNameCd')"/></td>
                            </tr>
                         <!--
                            <tr>
                                <td>Change Password:
                                <td><input  id="password"
type="password" name="password" minlength="3" class="inputtext" value
= "password"><td>
                            </tr>
                         -->
                             <td>Status:</td>
                                <td>
                                    <select type="text"class="inputtext" name="status" value = "<%= uv.getActive()%>">
                                        <option value="<%=uv.getActive()%>"><%= uv.getActive()%></option>
                                        <option value="Y">Y</option>
                                        <option value="N">N</option>
                                        <select/>
                                </td>
                            <tr>
                                <td> </td>
                                <td> Note: select Y to activate, N to inactivate </td>
                            <tr>
                                <td>Location:</td>
                    <td>
                        <select type="text" class="inputtext"name="location" value = "<%= uv.getLocation()%>" >
                            <option value="<%= uv.getLocation()%>"><%=uv.getLocation()%></option>
                            <%
                                for (int i = 0; i < locss.size(); i++) {
                            %>
                            <option value="<%= locss.get(i)[1]%>"><%=locss.get(i)[1]%></option>
                            <%}%>
                            <select/>
                    </td>
                            </tr>

                            <tr>
                                <td>Gender:</td>
                                <td>
                                    <select type="text"class="inputtext" name="gender" value = "<%= uv.getGender()%>">
                                        <option value="<%=uv.getGender()%>"><%= uv.getGender()%></option>
                                        <option value="M">Male</option>
                                        <option value="F">Female</option>
                                        <select/>
                                </td>
                            </tr>

                            <tr>
                                <td>User Role:</td>
                                <td>  <select type="text"class="inputtext" name ="role" value = "<%= uv.getRole()%>">
                                        <option value="<%=uv.getRole()%>"><%= uv.getRole()%></option>
                                        <%
                                            List<String[]> rol =sb.getList3("select role_id, role_desc from fas_mst_role");
                                            for (int i = 0; i <rol.size(); i++) {
                                        %>
                                        <option value="<%=rol.get(i)[1]%>"><%= rol.get(i)[1]%></option>
                                        <%}%>
                                        <select/>
                                </td>

                                </td>
                            </tr>

                       <tr>
                    <td>Authorizer:</td>
                    <td>
                        <select type="text" class="inputtext"name="authorizer"  value ="<%= uv.getAuthorizer()%>" required>
                            <option value="<%=uv.getAuthorizer()%>"><%= uv.getAuthorizer()%></option>
                            <%  List<String> authorizer =sb.getList2("select user_id from fas_mst_users where user_role_id ='002'");
                                for (int i = 0; i < authorizer.size(); i++) {
                            %>
                            <option value="<%=authorizer.get(i)%>"><%= authorizer.get(i)%></option>
                            <%}%>
                            <select/>
                    </td>
                </tr>

                            <tr>
                                <td>&nbsp;</td>
                                <td>NB: The user's password automatically resets to 'password' if the submit button is clicked</td>
                                <td>
                                   <input type ="submit"class="submitlink"  style="padding: 10px;" value="Submit">
                                </td>
                            </tr>
                        </table>
                    </div>
                </form>
            </div>
        </div>

    </body>

</html>