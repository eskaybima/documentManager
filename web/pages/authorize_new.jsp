
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
                            String displayAuthPanel;
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



                        <%
                            taxes = sb.getList2("select tax_name from tax_type");
                            user = (String) request.getAttribute("user");
                            directors = sb.getList2("select user_id from fas_mst_users where user_role_id = '009'");
                            allUsers = sb.getListss("select user_id, role_description from fas_mst_users where user_role_id not in ('009', '010')", 2);
                            role_id = (String) request.getAttribute("role_id");
                            values = (String[]) request.getAttribute("values");
                            imageList = (List<String>) request.getAttribute("documents");
                            template = (String) request.getAttribute("template");
                            formHeader = sb.getValue2("select description from template_names where template_name ='" + template + "'");
                            ref_id = (String) request.getAttribute("ref_id");
                            data = Refinery.refineValue(ref_id);
                            control3 = sb.getValue2("select control from " + template + " where ref_id = '" + ref_id + "'");
                            control = sb.isAvailable("select * from " + template + " where ref_id = '" + ref_id + "' and  director_assigned is null");
                            control2 = sb.isAvailable("select * from fas_action_flow where ref_id = '" + ref_id + "' and action = 'RECOMMENDED'  and role_id = '009'");
                            displayAuthPanel = (String)request.getAttribute("auth_panel_display");
                        %>
        
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
        </head>
        <body id="background" <% if(displayAuthPanel == null){%> onload = displayAuthPanel('template')<% } %>  >
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
                                                    
                                                    

                                            <table class="table datatable">
                                                <thead>
                                                <th width="20%"><span class="h4">Comment</span></th>
                                                <th width="20%"><span class="h4">Officer</span></th>
                                                <th width="20%"><span class="h4">Action</span></th>
                                                <th width="20%"><span class="h4">Date</span></th>
                                                <th width="20%"><span class="h4">Time Assigned</span></th>
                                                </thead>

                                                <%
                                                    List<String[]> history = sb.getListss("select user_comment, user_id, decision, trans_date, cre_dt from fas_work_flow where ref_id = '" + ref_id + "' order by auth_level asc", 5);
                                                    if (!history.isEmpty()) {
                                                        if ( displayAuthPanel != null) {;
                                                        for (int his = 0; his < history.size() - 1; his++) {
                                                            if (history.get(his)[0] == null) {
                                                                history.get(his)[0] = "";
                                                            }
                                                            if (history.get(his)[1] == null) {
                                                                history.get(his)[1] = "";
                                                            }
                                                            if (history.get(his)[2] == null) {
                                                                history.get(his)[2] = "";
                                                            }
                                                            if (history.get(his)[3] == null) {
                                                                history.get(his)[3] = "";
                                                            }
                                                            if (history.get(his)[4] == null) {
                                                                history.get(his)[4] = "";
                                                            }
                                                %>
                                                <tbody>
                                                    <tr>
                                                        <td><%= history.get(his)[0]%></td>
                                                        <td><%= history.get(his)[1]%></td>
                                                        <td><%= history.get(his)[2]%></td>
                                                        <td><%= history.get(his)[3]%></td>
                                                        <td><%= history.get(his)[4]%></td>
                                                    </tr>
                                                    <%}
                                                           }  else {
                                                            for (int his = 0; his < history.size(); his++) {
                                                            if (history.get(his)[0] == null) {
                                                                history.get(his)[0] = "";
                                                            }
                                                            if (history.get(his)[1] == null) {
                                                                history.get(his)[1] = "";
                                                            }
                                                            if (history.get(his)[2] == null) {
                                                                history.get(his)[2] = "";
                                                            }
                                                            if (history.get(his)[3] == null) {
                                                                history.get(his)[3] = "";
                                                            }
                                                            if (history.get(his)[4] == null) {
                                                                history.get(his)[4] = "";
                                                            }
                                                    %>      
                                                       
                                                    <tr>
                                                        <td><%= history.get(his)[0]%></td>
                                                        <td><%= history.get(his)[1]%></td>
                                                        <td><%= history.get(his)[2]%></td>
                                                        <td><%= history.get(his)[3]%></td>
                                                        <td><%= history.get(his)[4]%></td>
                                                    
                                                    <% } }  }%>        
                                                </tbody>
                                            </table>    

                                                
                                         <div id="auth_panel">
                                            <table>
                                                <tr>
                                                    <td colspan="2"></td>
                                                </tr>
                                                <form class="form-horizontal" action ="${pageContext.request.contextPath}/Authorize">
                                                    <input type ="hidden" name ="reference_id"  value = "<%= ref_id%>" >
                                                    <input type ="hidden" name ="template"  value = "<%= template%>">
                                                    <tr>
                                                        <td><span class="h5">Comment:</span></td>
                                                        <td><textarea class="form-control" rows="3" name="comment" placeholder="Add comment for document"></textarea></td>
                                                    </tr>
                                                    <tr>
                                                        <td><span class="h5"><strong>Choose Authorization Option:</strong></span></td>
                                                        <td>
                                                            <div class="form-group">
                                                                <div class="thumbnail">
                                                                    <div class="row"> 
                                                                        <div class="col-md-4 col-xs-6">
                                                                            <label class="check"><input type="radio" name="authorizeNew" value="RECOMMENDED" required="true"/> Recommended for Approval</label>
                                                                        </div>
                                                                        <div class="col-md-4 col-xs-6">
                                                                            <label class="check"><input type="radio" name="authorizeNew" value="NOT RECOMMENDED" required="true"/>Not Recommended for Approval</label>
                                                                        </div>

                                                                        <div class="col-md-4 col-xs-6">
                                                                            <label class="check"><input type="radio" name="authorizeNew" value="PENDING" required="true"/>Pending</label>
                                                                        </div> 
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-xs-12">
                                                                    <button type="submit" class="btn btn-success btn-block"><b class="fa fa-send-o"></b> Submit</button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                      </form>
                                            </table>
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
                                                    
                                                    <script>
                                                        function displayAuthPanel(tem){
                                                        $('#auth_panel').hide();
                                                        }
                                                    </script>
    </body>
</html>
