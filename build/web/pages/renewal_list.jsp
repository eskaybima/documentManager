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
                <li><a href="#">Administrator</a></li>
                <li class="active">Authorize Renewal Record</li>
            </ul>
            <!-- END BREADCRUMB -->
            <div id="bodyhold">
                <div id="bodycon"> 


                <%!
                    List<String[]> list;
                    String count;
                    String upper;
                    String lower;
                    int k;
                    int u;
                    int l;
                %>

                <%
                    list = (List<String[]>) request.getAttribute("list");
                    count = (String) request.getAttribute("count");
                    upper = (String) request.getAttribute("upper");
                    lower = (String) request.getAttribute("lower");
                    k = Integer.parseInt(count);
                    u = Integer.parseInt(upper);
                    l = Integer.parseInt(lower);
                %>
                
    <!--new addition from process list -->
<div class="row">
<div class="col-md-12">
    <!-- START PROJECTS BLOCK -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="panel-title-box">
                <h3> Number of Pending Jobs is : <%=count%></h3>
                <span>Based on authorization type selected</span>
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
          <div class="thumbnail">
                <form class="form-horizontal" action ="${pageContext.request.contextPath}/Authorize">
                <div class="form-group">
                    <label class="col-md-2 col-xs-12 control-label"><strong> Search by Refrence Id :</strong></label>
                    <div class="col-md-4 col-xs-12">
                         <input type="search" class="form-control input-lg"  placeholder="Enter Refrence Id" name="refidqueryvalue"  id="refidqueryvalue" required/>
                    </div>
                    <div class="col-md-2 col-xs-12">
                         <input type ="hidden" name ="SearchType"  value = "Search" >
                         <input type ="hidden" name ="AuthorizeType"  value = "renewal" >
                        <button type="submit" class="btn btn-default"><b class="fa fa-search"></b> Search</button>
                    </div>
                </div>
            </form>
          </div>
        <table class="table">  
        <tr> 
            <% if ( (u-3) >= 0) { %>
            <td>
                <form action ="${pageContext.request.contextPath}/Authorize">
                    <input type ="hidden" name ="previous"  value = "prev" >
                    <input type ="hidden" name ="AuthorizeType"  value = "renewal" >
                    <button type="submit" class="btn btn-info"><b class="fa fa-arrow-left"></b> Previous</button>
                 </form>  
            </td> 
            <% }
                        if (k >= (l + 3)) { %>
            <td>
                <form action ="${pageContext.request.contextPath}/Authorize">
                    <input type ="hidden" name ="next"  value = "next" >
                    <input type ="hidden" name ="AuthorizeType"  value = "renewal" >
                    <button type="submit" class="btn btn-info"><b class="fa fa-arrow-right"></b> Next</button>
                    <% } %>
                </form>
            </td>
        </tr>  
      </table>
            <div class="table-responsive">
                <form action ="${pageContext.request.contextPath}/Authorize">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th width="30%">Reference ID</th>
                        <th width="30%">Activity</th>
                    </tr>
                    </thead>
                    <tbody>
                         <% 

                        for (int i = 0; i < list.size(); i++) {
                            String ref_id = list.get(i)[0];
                        %>
                    <tr>
                        <td><span class="h3 text-primary"><%= ref_id%> </span>
                          <input type ="hidden" name ="ref_id"  value = "<%= ref_id%>" >
                          <input type ="hidden" name ="renewal"  value = "new" >
                        </td>
                        <td>
                            <button type="submit"class="btn btn-success"><span class="fa fa-cog"></span> Process</button>
                        </td>
                    </tr>
                     <% } %>
                    </tbody>
                </table>
                <p id="loghc" style="height: 10px;"> </p>
                </form>
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
    </body>
</html>
