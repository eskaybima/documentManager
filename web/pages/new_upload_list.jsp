<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authorize Update</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>

        </head>

        <body id="background">
            <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>
                    <!-- START BREADCRUMB -->
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                    <li><a href="#">Administrator </a></li>
                    <li class="active">Authorize Update  </li>
                </ul>
                <!-- END BREADCRUMB -->
                <div id="bodyhold">
                    <div id="bodycon"> 


                        <!-- PAGE CONTENT WRAPPER -->
                        <div class="page-content-wrap" id="main-loader">                      

                            <!-- START WIDGETS -->                    
                            <div class="row">
                                <div class="col-md-3">
                                    <!-- START WIDGET MESSAGES -->
                                    <div class="widget widget-default widget-item-icon">
                                        <div class="widget-item-left">
                                            <span class="fa fa-balance-scale"></span>
                                        </div>   


                                        <div class="widget-data">
                                            <div class="widget-int num-count"> <%=(String) request.getAttribute("count")%></div>
                                            <div class="widget-title">Pending Request</div>
                                            <div class="widget-subtitle">No of Pending Request for Your Attention</div>
                                        </div>   
                                    </div>                            
                                    <!-- END WIDGET MESSAGES -->

                                </div>
                                <div class="col-md-3">

                                    <!-- START WIDGET MESSAGES -->
                                    <div class="widget widget-success widget-item-icon">
                                        <div class="widget-item-left">
                                            <span class="fa fa-line-chart"></span>
                                        </div>                             
                                        <div class="widget-data">
                                            <div class="widget-int num-count">5</div>
                                            <div class="widget-title">Completed</div>
                                            <div class="widget-subtitle">No of Completed Request</div>
                                        </div> 
                                    </div>                            
                                    <!-- END WIDGET MESSAGES -->

                                </div>
                                <div class="col-md-3">

                                    <!-- START WIDGET REGISTRED -->
                                    <div class="widget widget-danger widget-item-icon" >
                                        <div class="widget-item-left">
                                            <span class="fa fa-bar-chart"></span>
                                        </div>
                                        <div class="widget-data">
                                            <div class="widget-int num-count">3</div>
                                            <div class="widget-title">Declined</div>
                                            <div class="widget-subtitle">No of Declined Request</div>
                                        </div>                           
                                    </div>                            
                                    <!-- END WIDGET REGISTRED -->

                                </div>
                                <div class="col-md-3">

                                    <!-- START WIDGET REGISTRED -->
                                    <div class="widget widget-warning widget-item-icon">
                                        <div class="widget-item-left">
                                            <span class="fa fa-bar-chart"></span>
                                        </div>
                                        <div class="widget-data">
                                            <div class="widget-int num-count">1</div>
                                            <div class="widget-title">Pending</div>
                                            <div class="widget-subtitle">No of Pending Request</div>
                                        </div>
                                    </div>
                                    <!-- END WIDGET REGISTRED -->

                                </div>
                            </div>
                            <!-- END WIDGETS -->                    


                            <div class="row">
                                <div class="col-md-12">
                                    <!-- START SALES & EVENTS BLOCK -->
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="panel-title-box">
                                                <h3>Statistics of Activities</h3>
                                                <span>Pending/Declined/Approved/Completed</span>
                                            </div>
                                            <ul class="panel-controls" style="margin-top: 2px;">
                                                <li><a href="#" class="panel-fullscreen"><span class="fa fa-expand"></span></a></li>
                                                <li><a href="#" class="panel-refresh"><span class="fa fa-refresh"></span></a></li>                                      
                                            </ul>
                                        </div>
                                        <div class="panel-body padding-0">
                                            <div class="chart-holder" id="dashboard-donut-1" style="height: 220px;"></div>
                                        </div>
                                    </div>
                                    <!-- END SALES & EVENTS BLOCK -->

                                </div>
                            </div>

                        </div>
                        <!-- END PAGE CONTENT WRAPPER --> 

                        <%!
                            List<String[]> list;
                            List<String[]> list2;
                            String count;
                            String upper;
                            String lower;
                            int k;
                            int u;
                            int l;
                            String role_id;
                        %>

                        <%
                            list = (List<String[]>) request.getAttribute("list");
                            list2 = (List<String[]>) request.getAttribute("list2");
                            count = (String) request.getAttribute("count");
                            upper = (String) request.getAttribute("upper");
                            lower = (String) request.getAttribute("lower");
                            role_id = (String) request.getAttribute("role_id");

                            k = Integer.parseInt(count);
                            u = Integer.parseInt(upper);
                            l = Integer.parseInt(lower);
                        %>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="panel-title-box">
                                         <!--  <h3> Number of Pending Jobs is : <%=count%></h3>
                                           <h3>New Request Submitted by Transferee</h3>
                                            -->
                                        </div>
                                        <ul class="panel-controls" style="margin-top: 2px;">
                                            <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                                            <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                                            <li class="dropdown">
                                                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span></a>
                                                <ul class="dropdown-menu">
                                                    <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span> Collapse</a></li>
                                                    <li><a href="#" class="panel-remove"><span class="fa fa-times"></span> Remove</a></li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="panel-body panel-body-table">
                                        <table class="table datatable">
                                            <thead>
                                                <tr>
                                                    <th width="20%">Reference ID</th>
                                                    <th width="20%">Uploaded by</th>
                                                    <th width="20%">Form Description</th>
                                                    <th width="20%">Date Uploaded</th>
                                                    <th width="20%"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (int k = 0; k < list.size(); k++) {
                                                %>
                                            <tr>
                                            <form action ="${pageContext.request.contextPath}/Authorize">
                                                <td><b><%=  list.get(k)[0]%></b></td>
                                                <td><b><%=  list.get(k)[1]%></b></td>
                                                <td> 
                                                    <b><%=  list.get(k)[2]%></b>
                                                    <input type ="hidden" name ="ref_id"  value = "<%= list.get(k)[0]%>" >
                                                    <input type ="hidden" name ="new_upload"  value = "new" >
                                                    <input type ="hidden" name ="auth_panel_display"  value = "display" >
                                                </td>  
                                                <td><%=  list.get(k)[3].substring(0, 10) %></td>
                                                <td>
                                                    <button type="submit"class="btn btn-success"><span class="fa fa-cog"></span> Process</button>
                                                </td>  
                                            </form>
                                            </tr>


                                            <% }%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>


                                <p id="loghc" style="height: 10px;"> </p>

                            </div>
                        </div>
                        <!-- END PROJECTS BLOCK -->
                    </div>
                </div>
                <!--end of new addition from process list -->
                <script>
                    function renderElseWhere(id, loc) {
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?startNew=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>
            </div>
        </div>         
    </div>
</div>    
<script>
    Morris.Donut({
        element: 'dashboard-donut-1',
        data: [
            {label: "Approved Requests", value: 60},
            {label: "Declined Requests", value: 30},
            {label: "Pending Requests", value: 10}
        ],
        formatter: function (y) {
            return y + "%"
        },
        colors: ['#7ac218', '#471b1b', '#ff7e00'],
        resize: true
    });
</script>    

</body>
</html>
