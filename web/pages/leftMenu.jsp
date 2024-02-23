
<%@page import="com.fasyl.newjobBo.ValidateUser"%>
<div class="page-sidebar">
    <ul class="x-navigation">
        <li class="xn-logo">
            <a href="${pageContext.request.contextPath}/Authorize?refresh=yes"></a>
            <a href="#" class="x-navigation-control"></a>
        </li>
    
        <li class="xn-profile">
            <a href="#" class="profile-mini">
                <img src="${pageContext.request.contextPath}/assets/images/users/rsz_office.png" alt="admin"/>
            </a>
            <div class="profile">
                <div class="profile-image">
                    <img src="${pageContext.request.contextPath}/assets/images/users/no-image.jpg" alt="admin"/>
                </div>
                <div class="profile-data">
                    <div class="profile-data-name"><%= session.getAttribute("welcomeName")%></div>
                    <% if (!session.getAttribute("role_id").equals("000")) { %>
                    <div class="profile-data-title">Administrative Officer</div>
                    <%} else {%>
                     <div class="profile-data-title">CLIENT</div>
                    <% } %>
                </div>
                <div class="profile-controls">
                    <a href="#" onclick="displayDialog('ChangePassword');" class="profile-control-left" data-toggle="tooltip" title="Change Password"><span class="fa fa-pencil"></span></a>
                    <a href="#" onclick="location.reload();" class="profile-control-right" data-toggle="tooltip" title="Reload Page"><span class="fa fa-refresh"></span></a>
                </div>
            </div>                                                                        
        </li>
       
        <li class="fa-text">
               <% if (session.getAttribute("role_id").equals("000")) {%>
             <a href="${pageContext.request.contextPath}/registerAs.jsp"><span class="fa fa-desktop"></span> <span class="fa-text">Dashboard</span></a>
              <%} else if (session.getAttribute("role_id").equals("011")) {%>
               <a href="${pageContext.request.contextPath}/Authorize?refresh=yes"><span class="fa fa-desktop"></span> <span class="fa-text">Dashboard</span></a>
              <%} else {%>
               <a href="${pageContext.request.contextPath}/Authorize?refresh=yes"><span class="fa fa-desktop"></span> <span class="fa-text">Dashboard</span></a>
              <%}%>
        </li>

          <% if (!session.getAttribute("role_id").equals("000") && !session.getAttribute("role_id").equals("011")) {%>
        <li class="xn-openable">
            <a href="#"><span class="fa fa-wrench"></span> <span class="fa-text">Key Setup</span></a>
            <ul>                
                <li class="xn-openable">
                    <a href="#"><span class="fa fa-cogs"></span><span class="fa-text">Template Config.</span></a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/ConfigureJobController?control=addParameter&createList=yes" id="a"><span class="fa fa-sort-amount-desc"></span>Create Template</a></li>
                        <li><a href="#" onclick="displayDialog('editTemplate')" id="a"><span class="fa fa-refresh"></span>Edit Template</a></li>
                       
                    </ul>
                </li>
              <!--  <li><a href="${pageContext.request.contextPath}/ConfigureJobController?control=editUserGroup" id="a"><span class="fa fa-sort-amount-desc"></span>Edit Group</a></li>  
                <li><a href="#" id="a" onclick="displayDialog('ceate_depart')"><span class="fa fa-map-marker"></span> Create Department</a></li>
                <li><a href="#" id="a" onclick="displayDialog('CreateLocation')"><span class="fa fa-map-marker"></span> Create Location</a></li>
                  <li><a href="${pageContext.request.contextPath}/ConfigureJobController?control=editPaymentType" id="a"><span class="fa fa-map-marker"></span> Edit Payment Types</a></li>  
                     -->
                <%}%>
            </ul>
        </li>
        
        
          <% if (!session.getAttribute("role_id").equals("000") && !session.getAttribute("role_id").equals("011")) {%>

        <li class="xn-openable">
            <a href="#"><span class="fa fa-wrench"></span> <span class="fa-text">User Profile</span></a>
            <ul>                <li class="xn-openable">
                    <a href="#"><span class="fa fa-user"></span><span class="fa-text">User Config.</span></a>
                    <ul>
                      
                        <li><a href="#" onclick="displayDialog('user_creation')">Create user</a></li>
                        <li><a href="#" id="a" onclick="displayDialog('EditUser')">Edit user</a></li>
                        <li><a href="#" id="a" onclick="displayDialog('CreateModifyUserGroup')"></span>Create/Modify User Group</a></li>
                        <!--li><a href="${pageContext.request.contextPath}/ConfigureJobController?control=createUserGroup" id="a"><span class="fa fa-sort-amount-desc"></span>Create/Modify User Group</a></li-->
                    </ul>
                </li>
                <li><a href="#" id="a" onclick="displayDialog('ChangePassword')"><span class="fa fa-pencil-square"></span> Change Password</a></li>
            </ul>
        </li>
         <%}%>
         
         
           <% if (session.getAttribute("role_id").equals("011")) {%>
                <li><a href="#" id="a" onclick="displayDialog('ChangePassword')"><span class="fa fa-pencil-square"></span> Change Password</a></li>
                
          <%}%>
         
         
         <% if (!session.getAttribute("role_id").equals("000") && session.getAttribute("role_id").equals("011")) {%>    
         
        <li class="xn-openable">
            <a href="#"><span class="fa fa-wrench"></span> <span class="fa-text">Authorizations</span></a>
            <ul> 
                 <li class="xn-openable">
                    <a href="#"><span class="fa fa-cogs"></span><span class="fa-text">Authorize</span></a>
                    <ul>
                       
                <li><a href="#" id="a" onclick="displayDialog('Authorize')"><span class="fa fa-check-square-o"></span>Data Upload</a></li>
                 <li><a href="#" id="a" onclick="displayDialog('auth_temp_create')"><span class="fa fa-check-square-o"></span>Template Create</a></li>
                 <li><a href="#" id="a" onclick="displayDialog('auth_user_create')"><span class="fa fa-check-square-o"></span>User Create</a></li>
                 <li><a href="#" id="a" onclick="displayDialog('auth_client_reg')"><span class="fa fa-check-square-o"></span>Client Regis</a></li>
                 </ul>
                </li>
            </ul>
        </li>
           <%}%>
    
            <% if (!session.getAttribute("role_id").equals("000") && !session.getAttribute("role_id").equals("011")) {%>    
        <li class="xn-openable">
            <a href="#"><span class="fa fa-upload"></span> <span class="fa-text">Published Forms</span></a>
            <ul>
             <!--   <li><a href="${pageContext.request.contextPath}/ImageUpload?uploadType=scanner" id="a"><span class="fa fa-print"></span> Upload New Job</a></li>   -->
                <li><a href="#" onclick="displayDialog('chooseTemplate')" id="a"><span class="fa fa-refresh"></span>Upload New Job</a></li>
              <!--    <li><a href="#" onclick="displayDialog('doRenewal')" id="a"><span class="fa fa-refresh"></span> Renewal</a></li>     -->
                <li><a href="#" onclick="displayDialog('update')" id="a"><span class="fa fa-cloud-upload"></span> Update Record</a></li>
               <!-- <li><a href="${pageContext.request.contextPath}/MultiSearcher?begin=yes&control=one" id="a"><span class="fa fa-ban"></span> Unapproved Uploads</a></li> -->
            </ul>
        </li>
        
        <li class="xn-openable">
            <a href="#"><span class="fa fa-book"></span> <span class="fa-text">View Records</span></a>
            <ul>
                <li>
                    <a href="#" onclick="displayAllRecords('searchAll')" id="a"><span class="fa fa-search"></span> Search Records</a>
                    <!--a href="${pageContext.request.contextPath}/pages/list_shared_docs.jsp" id="a"><span class="fa fa-ban"></span>View Shared Documents</a-->
                </li>
            </ul>
        </li>
         <%}%>  
         
            <% if ("010".equalsIgnoreCase((String)session.getAttribute("role_id"))) {%> 
          <li class="xn-openable">
            <a href="#"><span class="fa fa-book"></span> <span class="fa-text">Administration</span></a>
            <ul>
                <li>
                    <% if ("010".equalsIgnoreCase((String)session.getAttribute("role_id"))) {%> 
                    <a href="${pageContext.request.contextPath}/Authorize?accessControl=yes"><span class="fa fa-desktop"></span> <span class="fa-text">Access Control</span></a>
                    <% } %>
                    <!--a href="${pageContext.request.contextPath}/pages/list_shared_docs.jsp" id="a"><span class="fa fa-ban"></span>View Shared Documents</a-->
                </li>
                <li><a href="#" onclick="displayDialog('workflowConfig')" id="a"><span class="fa fa-desktop"></span> <span class="fa-text">Define Workflow</span></a></li>
            </ul>
        </li>
           <% } %>
         
        <% if (!session.getAttribute("role_id").equals("000") && !session.getAttribute("role_id").equals("011")) {%>   
         <!--
        <li class="xn-openable">
            <a href="#"><span class="fa fa-bar-chart-o"></span> <span class="fa-text">Reports</span></a>
            <ul>
                <li><a href="${pageContext.request.contextPath}/Statistic?reportType=dailycountTotal" id="a"><span class="fa fa-sort-amount-desc"></span> Daily Upload By Count</a></li>
                <li><a href="${pageContext.request.contextPath}/Statistic?reportType=dailyperLocation" id="a"><span class="fa fa-map-marker"></span> Daily Per Location</a></li>
                <li><a href="${pageContext.request.contextPath}/Statistic?reportType=dailyDetail" id="a"><span class="fa fa-list-alt"></span> Daily Upload Details</a></li>
                <li><a href="#" onclick="displayDialog('dailyDetailPerLocation')" id="a"><span class="fa fa fa-sitemap"></span> Upload Detail By Location</a></li>
                <li><a href="#" onclick="displayDialog('filteReportByUser')" id="a"><span class="fa fa-reorder"></span> User Report by count</a></li>
                <li><a href="${pageContext.request.contextPath}/Statistic?reportType=generalCumulative" id="a"><span class="fa fa-share-square-o"></span> Cumulative Report</a></li>
                <li><a href="#" onclick="displayDialog('filteReport')" id="a"><span class="fa fa-filter"></span> Filter Report</a></li>
            </ul>
        </li>
         -->
        <%}%>

    </ul>
    <!-- END X-NAVIGATION -->
</div>
<!-- END PAGE SIDEBAR -->

<jsp:include page="dialogs.jsp"></jsp:include>