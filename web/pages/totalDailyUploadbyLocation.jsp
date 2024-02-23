<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">

<html>
    <head>
        <title>Details</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
            <script>
                $(function() {
                    $("#accord").accordion();
                });
            </script>
        </head>
        <body id="background">
        <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
            <div class="page-content">
            <jsp:include page="header.jsp"></jsp:include>
            <!-- START BREADCRUMB -->
                <ul class="breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Statistics</a></li>
                    <li><a href="#">Reports</a></li>
                    <li class="active">Daily Upload Per Location</li>
                </ul>
              <!-- END BREADCRUMB -->
            <div id="bodyhold">
                <div id="bodycon">  
                <%!
                List<String[]> data = null;
                %>

                <%
                 data = (List<String[]>)request.getAttribute("data");
                %>          
  
     
                 <div class="page-content-wrap">
            <div class="row">
                <div class="col-md-offset-2 col-md-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title"><span class="fa fa-map-marker"></span> <strong>Daily Upload Per Location</strong></h3>
                            <ul class="panel-controls" style="margin-top: 2px;">
                                <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                                <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                            </ul>
                        </div>
                        <div class="panel-body">
                            <div class="thumbnail">
                                <div class="row">
                                    <div class="col-md-4">
                                        <form action="${pageContext.request.contextPath}/Statistic" method="get">    
                                            <input type="hidden" name="repType" value="dailyperLocation"/>
                                            <button class="btn btn-success btn-block" type="submit"><b class="fa  fa-cloud-download"></b> Download</button>
                                         </form>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="well well-sm h5"><strong>Break Down of Upload by location for : <%= new java.util.Date()%></strong></div>
                                </div>
                            </div>
                            <div class="thumbnail">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table">
                                            <thead>
                                            <tr>
                                                <th width="50%"><span class="fa fa-map-marker"></span> Location</th>
                                                <th width="50%"><span class="fa fa-dashboard"></span> Total</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                                <% for(int i = 0; i < data.size(); i++) { %>
                                            <tr>
                                                <td><span class="h4"><%=data.get(i)[0]%></span></td>
                                                <td class="h4"><strong><%=data.get(i)[1]%> </strong></td>
                                            </tr>
                                             <%}%>
                                            </tbody>
                                        </table>
                                        <p id="loghc" style="height: 10px;display: none;"> </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- PAGE CONTENT WRAPPER -->

            <!-- END PAGE CONTENT WRAPPER -->
        </div>
               
                
            </div>
        </div>  
       </div>
     </div>                     
    </body>
</html>
