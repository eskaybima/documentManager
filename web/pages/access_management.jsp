
<%@page import="com.fasyl.util.FormatAmount"%>
<%@page import="com.fasyl.newjobBo.Refinery"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.fasyl.newjobBo.PageUtil"%>

<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">

<html>
    <head>
        <title>Record Details</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>

        <%!
            String passportNumber = "";
            String surname = "";
            String firstname = "";
            String middlename = "";
            String state = "";
            String dob = "";
            String sex = "";
            String country = "";
            String offset = null;
            List<String> imageList;
            String[] values;
            String doc_type;
            String doc_path;
            String doc_id;
            String ref_id;
            String mar_status;
            String enrolNo;
            String category;
            String title;
            public SaveToDb sb = new SaveToDb();
            boolean isdocAvailable;
            String role_id;
            List<String> directors;
            String director;
            List<String[]> allUsers;
            List<String[]> role_id_group;
            List<String> users;
            List<String> user_group;
            String proc_officer;
            String user;
            boolean control;
            boolean control2;
            String control3 = "control";
            boolean control4;
            String def_taxType;
            String def_amount;
            String template;
            List<String> parameters;
            List<String> taxes;
            List<String[]> data;
            String formHeader;
        %>


        <%!
            String select(String param1, String param2) {
                if (param1.equalsIgnoreCase(param2)) {
                    return "selected";
                } else {
                    return "";
                }
            }
        %>     



        <%  user = (String) request.getAttribute("user");
            allUsers = sb.getListss("select user_id, role_description, last_name from fas_mst_users", 3);
            user_group = sb.getList2("select DISTINCT group_name from user_group");
            role_id = (String) request.getAttribute("role_id");
            role_id_group = sb.getListss("select role_id, role_desc from FAS_MST_ROLE", 2);
            template = (String) request.getAttribute("template");
            formHeader = sb.getValue2("select description from template_names where template_name ='" + template + "'");
            ref_id = (String) request.getAttribute("ref_id");
            data = Refinery.refineValue(ref_id);
            control3 = sb.getValue2("select control from " + template + " where ref_id = '" + ref_id + "'");
            control = sb.isAvailable("select * from " + template + " where ref_id = '" + ref_id + "' and  director_assigned is null");
        %>


        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
            <script type="text/javascript" src="js/accessControl.js"></script>
        </head>
        <body id="background"   onload = "control('<%= ref_id%>')">
        <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>
                    <!-- START BREADCRUMB -->
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                    <li><a href="#">Administrator</a></li>
                    <li class="active">Authorize Record</li>
                </ul>
                <!-- END BREADCRUMB -->
                <div id="bodyhold">
                    <div id="bodycon">  

                        <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <div class="panel panel-default tabs">  
                                    <div class="panel-body tab-content">
                                        <div class="tab-pane active" id="tab-first">
                                            <hr>
                                            <table align = "centered"  class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th width="50%"><strong><span><%=formHeader + " (" + ref_id + ")"%></span></strong></th>
                                                        <th width="50%"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% for (int i = 0; i < data.size(); i++) {%>
                                                    <% if ("SUBHEAD".equalsIgnoreCase(data.get(i)[1])) {%>
                                                    <tr><td colspan="2"><div class="modal-header"><span class="h5 text-info"><strong><%= data.get(i)[0].replace("_", " ").toUpperCase()%></strong></span></div></tr>
                                                                        <%} else {%>
                                                    <tr>
                                                        <td><span class="h10"><%= data.get(i)[0].replace("_", " ").toUpperCase()%>:</span></td>   
                                                        <td class="text-info h5"><%=data.get(i)[1]%></td>
                                                    </tr>
                                                    <%}
                                                        }%>

                                                    <tr><td colspan="2"> <h5><strong>DOCUMENTS</strong></h5></td></tr>
                                                    <%
                                                        List<LoaderVo> l = sb.getLoaderList(ref_id);
                                                        for (int k = 0; k < l.size(); k++) {
                                                            doc_type = l.get(k).getType().replace("_", " ").toUpperCase();
                                                            doc_id = l.get(k).getDoc_id();
                                                            isdocAvailable = PageUtil.isDocAvailable(doc_id);
                                                    %>
                                                    <tr>

                                                        <td><span class="h5"><%= doc_type%></span></td>
                                                        <td class="text-info">
                                                            <% if (isdocAvailable) {%>
                                                            <button  class="btn btn-primary" onclick="displayDocument('<%=doc_id%>');"><i class="fa fa-folder-open"></i> View Document</button>
                                                            <%} else {%>
                                                            <label style="color:orangered" for="NotAvailable">Not Available</label>
                                                            <%}%>
                                                        </td>
                                                    </tr>
                                                    <%}%>

                                                </tbody>
                                            </table>

                                            <div id="public_access_div">       
                                                <table align ="center" class="table table-bordered"  id="public_access_table">
                                                    <thead>
                                                        <tr>
                                                            <th width="50%"></th>
                                                            <th width="50%"></th>
                                                        </tr>
                                                    </thead>
                                                </table> 
                                            </div> 

                                            <input type ="hidden" name ="reference_id"  id="ref_id" value = "<%= ref_id%>" >
                                            <span class="h5"><strong>Choose Access Type:</strong></span>
                                            <div class="form-group">
                                                
                                                <div id="restrict_panel">
                                                <div class="thumbnail">
                                                    <table align = "centered" class="table table-bordered"  id="authorised_users">
                                                        <thead>
                                                            <tr>
                                                                <th width="50%">USER ID</th>
                                                                <th width="50%"></th>
                                                            </tr>
                                                        </thead>
                                                    </table> 
                                                </div>
                                                <div class="thumbnail">
                                                    <table align = "centered" class="table table-bordered"  id="role_id_group_table">
                                                        <thead>
                                                            <tr>
                                                                <th width="50%">ROLE ID</th>
                                                                <th width="50%"></th>
                                                            </tr>
                                                        </thead>
                                                    </table> 
                                                </div>
                                                <div class="thumbnail">
                                                    <table align = "centered" class="table table-bordered"  id="user_group_table">
                                                        <thead>
                                                            <tr>
                                                                <th width="50%">USER GROUP</th>
                                                                <th width="50%"></th>
                                                            </tr>
                                                        </thead>
                                                    </table>
                                                </div>
                                                </div>
                                                <div class="row" id="index_panel"> 
                                                    <div class="thumbnail">
                                                        <div class="col-md-4 col-xs-6">
                                                            <label class="check"><input type="radio" id="access_type_radio" name="access_type" value="PUBLIC" onclick="setAccesType('PUBLIC')" />Public</label>
                                                        </div>
                                                        <div class="col-md-4 col-xs-6">
                                                            <label class="check"><input type="radio"  id="res_access_type_radio" name="access_type" value="RESTRICTED" onclick="showResGroup()"/>Restricted</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div id="restrict_group">


                                                    <div class="thumbnail">
                                                        <table align = "centered" class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th width="50%">CRITERIA</th>
                                                                    <th width="50%">SELECT</th>
                                                                </tr>
                                                            </thead>


                                                            <tbody>
                                                                <tr>
                                                                    <td>
                                                                        <label class="check"><input type="radio" name="res_group" value="INDIVIDUAL USERS" onclick="showAllusers()"/>INDIVIDUAL USERS</label>   
                                                                    </td> 
                                                                    <td>
                                                                        <div  id="individual_users">
                                                                            <div class="row" id="individual_users_select"> 
                                                                                <div class="form-group"> 
                                                                                    <div class="col-md-8">
                                                                                    <select class="form-control" data-live-search="true"  value="" name="user_selected" id="user_selected"/>
                                                                                    <option value="">Nothing Selected</option>
                                                                                    <%   for (int i = 0; i < allUsers.size(); i++) {%>
                                                                                    <option value="<%=allUsers.get(i)[0]%>"><%=allUsers.get(i)[0]%></option>
                                                                                    <%}%>
                                                                                    </select>
                                                                                    </div>
                                                                                </div>
                                                                                <li><a href="#" onclick="addUserToTable()">Add</a></li>
                                                                            </div>
                                                                        </div>    
                                                                    </td>
                                                                </tr>

                                                                <tr><td>
                                                                        <label class="check"><input type="radio" name="res_group" value="ROLE ID" onclick="showAllRoles()"/>ROLE ID</label>
                                                                    </td>
                                                                    <td>
                                                                        <div id="role_id_group">
                                                                            <div class="row" id="role_id_group_select"> 
                                                                                <div class="form-group">  
                                                                                    <div class="col-md-8">
                                                                                        <select class="form-control" data-live-search="true"  value="" name="role_id_selected" id="role_id_selected"/>
                                                                                        <option value="">Nothing Selected</option>
                                                                                        <%   for (int i = 0; i < role_id_group.size(); i++) {%>
                                                                                        <option value="<%=role_id_group.get(i)[0]%>"><%=role_id_group.get(i)[0] + "                      " + role_id_group.get(i)[1]%></option>
                                                                                        <%}%>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <li><a href="#" onclick="addRoleToTable()">Add</a></li>
                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                </tr>

                                                                <tr><td>
                                                                        <label class="check"><input type="radio" name="res_group" value="USER GROUP"  onclick="showAllUserGroups()"/>USER GROUP</label>
                                                                    </td><td>
                                                                        <div id="user_group">
                                                                            <div class="row" id="user_group_select"> 
                                                                                <div class="form-group">  
                                                                                    <div class="col-md-8">
                                                                                        <select class="form-control" data-live-search="true"  value="" name="user_group_selected" id="user_group_selected"/>
                                                                                        <option value="">Nothing Selected</option>
                                                                                        <%   for (int i = 0; i < user_group.size(); i++) {%>
                                                                                        <option value="<%=user_group.get(i)%>"><%=user_group.get(i)%></option>
                                                                                        <%}%>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <li><a href="#" onclick="addUserGroupToTable()">Add</a></li>
                                                                            </div>
                                                                        </div>
                                                                    </td></tr>
                                                            </tbody>
                                                        </table>     
                                                    </div>


                                                    <!--div class="row"> 
                                                        
                                                         <div class="thumbnail">
                                                        <div class="col-md-4 col-xs-6">
                                                            <label class="check"><input type="radio" name="res_group" value="INDIVIDUAL USERS" onclick="showAllusers()"/>INDIVIDUAL USERS</label>
                                                        </div>
                                                        <div  id="individual_users">
                                                            <div class="row" id="individual_users_select"> 
                                                                <div class="form-group">  
                                                                    <div class="col-md-8">
                                                                        <select class="form-control" data-live-search="true"  value="" name="user_selected" id="user_selected"/>
                                                                        <option value="">Nothing Selected</option>
                                                    <%   for (int i = 0; i < allUsers.size(); i++) {%>
                                                    <option value="<%=allUsers.get(i)[0]%>"><%=allUsers.get(i)[0] + "                      " + allUsers.get(i)[2]%></option>
                                                    <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <li><a href="#" onclick="addUserToTable()">Add</a></li>
                                        </div>
                                    </div> 
                                    </div>               
                                                    

                                                    
                                     <div class="thumbnail">                
                                    <div class="col-md-4 col-xs-6">
                                        <label class="check"><input type="radio" name="res_group" value="ROLE ID" onclick="showAllRoles()"/>ROLE ID</label>
                                    </div>
                                    <div id="role_id_group">
                                        <div class="row" id="role_id_group_select"> 
                                            <div class="form-group">  
                                                <div class="col-md-8">
                                                    <select class="form-control" data-live-search="true"  value="" name="role_id_selected" id="role_id_selected"/>
                                                    <option value="">Nothing Selected</option>
                                                    <%   for (int i = 0; i < role_id_group.size(); i++) {%>
                                                    <option value="<%=role_id_group.get(i)[0]%>"><%=role_id_group.get(i)[0] + "                      " + role_id_group.get(i)[1]%></option>
                                                    <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <li><a href="#" onclick="addRoleToTable()">Add</a></li>
                                        </div>
                                    </div>
                                     </div>
                                                    
                                    <div class="thumbnail">                 
                                    <div class="col-md-4 col-xs-6">
                                        <label class="check"><input type="radio" name="res_group" value="USER GROUP"  onclick="showAllUserGroups()"/>USER GROUP</label>
                                    </div>
                                    <div id="user_group">
                                        <div class="row" id="user_group_select"> 
                                            <div class="form-group">  
                                                <div class="col-md-8">
                                                    <select class="form-control" data-live-search="true"  value="" name="user_group_selected" id="user_group_selected"/>
                                                    <option value="">Nothing Selected</option>
                                                    <%   for (int i = 0; i < user_group.size(); i++) {%>
                                                    <option value="<%=user_group.get(i)%>"><%=user_group.get(i)%></option>
                                                    <%}%>
                                                    </select>
                                                </div>
                                            </div>
                                            <li><a href="#" onclick="addUserGroupToTable()">Add</a></li>
                                        </div>
                                    </div>   
                                  </div-->  
                                                </div>
                                            </div>



                                            <div class="col-md-4 col-xs-12">
                                                <button type="submit" id="access_form" class="btn btn-success btn-block" onclick="submitAccessSetting()"><b class="fa fa-send-o"></b> Submit</button>
                                            </div>
                                        </div>

                                        <p id="loghc" style="height: 10px;"> </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> 
        </div>
    </div>
</body>
</html>
