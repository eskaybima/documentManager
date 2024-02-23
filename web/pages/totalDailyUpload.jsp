<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
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
                        <li class="active">Daily Upload by count</li>
                    </ul>
                    <!-- END BREADCRUMB -->
                    <div id="bodyhold">
                        <div id="bodycon">  
                        <%!      String total = null;
                        %>

                        <%
                            total = (String) request.getAttribute("total");
                        %>          
                        
     <div class="page-content-wrap">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
            <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><span class="fa fa-sort-amount-desc"></span> <strong>Daily Upload By Count</strong></h3>
                <ul class="panel-controls" style="margin-top: 2px;">
                    <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                    <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                </ul>
            </div>
            <div class="panel-body">
              <div class="thumbnail">
                  <div class="row">
                      <div class="col-md-8">
                          <h3>Total Upload For Today</h3>
                          <h4 class="text-danger"><%= new java.util.Date()%></h4>
                          <h5 class="text-success"><%= new java.util.Date()%></h5>
                      </div>
                      <div class="col-md-4">
                          <h4><strong class="text-danger">Upload Count</strong></h4>
                          <input class="knob" data-width="150" data-min="0" data-displayPrevious=true data-max="5000" data-step="1" value="<%=total%>" data-fgColor="#FD421C"/>
                      </div>
                  </div>
                 </div>
                  <p id="loghc" style="height: 10px;display: none;"> </p>    
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
