
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create/Modify User Group</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>
        </head>
        <body id="background">
            <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>

                    <div class="page-content-wrap">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                

                                            <%!
                                                List<String> allUsers;
                                                SaveToDb sb = new SaveToDb();
                                                List<String> curr_members;
                                                String groupName;
                                                String taskType;
                                            %>                      

                                            <%
                                                taskType = (String)session.getAttribute("taskType");
                                                groupName = (String) session.getAttribute("groupName");
                                                allUsers = sb.getList2("select user_id from fas_mst_users");
                                                curr_members = (List<String>) session.getAttribute("curr_members");
                                                if (!"Modify".equalsIgnoreCase(taskType)) {
                                                    taskType = "Create";
                                                  }
                                            %>
                                             
                                  <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title text-primary"><%=taskType%> User Group </h4>
                                  </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well well-lg">
                                            
                                            <table align = "centered"  class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <% if (!"".equalsIgnoreCase(groupName)) {%>
                                                        <th width="90%"><Strong><%="GROUP NAME:                        " + groupName.toUpperCase()%></strong></th>
                                                        <% } else {%>
                                                        <th width="90%"></th>
                                                        <% } %>
                                                        <th width="10%"></th>
                                                    </tr>
                                                </thead>
                                                <tbody>

                                                <%
                                                    for (int i = 0; i < curr_members.size(); i++) {
                                                %>
                                                <tr>  
                                                    <td> <%= curr_members.get(i)%></td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="delete_group_member"/> 
                                                            <input type="hidden" name ="member_for_delete" value ="<%= curr_members.get(i)%>"/> 
                                                            <button class="btn btn-danger btn-block" type="submit">Delete</button></form>
                                                    </td>
                                                </tr>
                                                <% }%>
                                                </tbody>
                                            </table>
                                            
                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                <input type="hidden" name ="control" value ="add_group_member"/> 
                                                <% if (!"Modify".equalsIgnoreCase(taskType)){ %>
                                                <label class="col-md-4 col-xs-12 control-label">Enter Group Name:</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                        <input type="text" class="form-control" placeholder="Group Name" id="groupName" autocomplete="off" name="groupName" value="<%= groupName%>" onchange="createGroupName('groupName', 'loghc')" />
                                                    </div>
                                                </div>
                                                <% } %>
                                                    <table align = "centered"  class="table table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th width="90%"><strong><span>Select User Name</span></strong></th>
                                                        <th width="10%"><strong><span>ADD</span></strong></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr><td>
                                                    <select class="form-control select" data-live-search="true" name="username" value="" id="username" onchange="addNameToGroup('username', 'loghc')" />
                                                    <option value=""></option>
                                                    <% for (int i = 0; i < allUsers.size(); i++) {
                                                            if (!curr_members.contains(allUsers.get(i))) {
                                                    %>
                                                    <option value="<%= allUsers.get(i)%>"><%= allUsers.get(i)%></option>
                                                    <%   }
                                                        }%>
                                                    </select>
                                                    </td>
                                                    <td>
                                                <input type="hidden" name ="control" value ="addParameterFromEdit"/> 
                                                <% if ("Modify".equalsIgnoreCase(taskType)){ %>
                                                <input type="hidden" name ="taskType" value ="modify"/> 
                                                <% } %>
                                                <button class="btn btn-success btn-block" type="submit">Add</button>
                                                   </td>
                                                   </tr>
                                                </tbody>
                                                    </table>
                                            </form>
                                            <br><br><br>
                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-offset-9 col-md-3">
                                                         <% if (!"Modify".equalsIgnoreCase(taskType)){ %>
                                                        <input type="hidden" name ="control" value ="submitCreateUserGroup"/> 
                                                         <% } else { %>
                                                         <input type="hidden" name ="control" value ="editUserGroup"/> 
                                                         <% } %>
                                                        <button class="btn btn-success btn-block"  type="submit"><b class="fa fa-send-o"></b>Submit</button>
                                                    </div>
                                                </div>
                                            </form>       


                                        </div>
                                    </div>
                                </div> --
                            </div>
                        </div>
                    </div>
                </div>
                <p id="loghc" style="height: 10px; display: none;"> </p>   

                <script>
                    function addNameToGroup(id, loc) {
                        var username = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?memberName=' + username + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>                          

                <script>
                    function createGroupName(id, loc) {
                        var groupName = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?groupName=' + groupName + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>        

                </body>
                </html>
