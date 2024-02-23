<%-- 
    Document   : showSummaryRev
    Created on : Aug 9, 2016, 4:57:24 PM
    Author     : Adebayo
--%>
<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="com.fasyl.newjobBo.PageUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <title>Summary Revenue</title>
   
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
    </head>
     <body id="background">
        <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
            <div class="page-content">
            <jsp:include page="header.jsp"></jsp:include>
            <!-- START BREADCRUMB -->
            <ul class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                <li><a href="#">Upload New Jobs</a></li>
                <li class="active">Unused Balance</li>
            </ul>
            <!-- END BREADCRUMB -->
            <div id="bodyhold">
       <div id="bodycon">  
           </div>
         
               <%

               SaveToDb sb =  new SaveToDb();
               String  query = "select location, sum(amount),year from  fas_int_revenue group by location ,year";
               List<String[]> list = sb.getList4(query);
              
            %> 
            <div class="row">
    <div class="col-md-12">

        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title-box">
                
                   
                     <a href="${pageContext.request.contextPath}/pages/homepage.jsp"><H3>Back to DashBoard</H3></a>
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
                   
                <!--- Data Table Starts Here -->  
                    
                    
                     <table class="table datatable">
                                        <thead>
                                        <tr>
                                           <th width="30%">location</th>
                                            <th width="30%">Amount</th>
                                            <th width="30%">Year</th>
                                         <th width="30%">Activity</th>
                                           
                                        </tr>
                                        </thead>
                                        <tbody>
                                              <% 

                                          for (int k = 0; k < list.size(); k++) {
                                          %>
                                      
                                        <tr>
                                              <form action ="${pageContext.request.contextPath}/pages/showDetilsrev.jsp">
                                              <td><b><%=  list.get(k)[0]%></b>
                                                 <td><b><%=  list.get(k)[1]%></b>
                                                      <td><b><%=  list.get(k)[2]%></b>
                                                       
                                                <input type ="hidden" name ="ref_id"  value = "<%= list.get(k)[0]%>" >
                                               <input type ="hidden" name ="new_upload"  value = "new" >
                                            
                                            </td>    
                                            <td>
                                             <button type="submit"class="btn btn-success"><span class="fa fa-cog"></span>Show Details </button>
                                           </td>  
                                           
                                           </form>
                                        </tr>
                                           
                                        
                                           <% } %>
                                           
                                           
                                        </tbody>
                                    </table>
                    
                    
                    
                    
                      
                
            </div>
           </div>
                        
       
        </body>
      </div>
</html>