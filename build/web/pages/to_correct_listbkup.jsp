<%@page import="com.fasyl.vo.NewUpload"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="listforpros" scope="page" class="com.fasyl.newjobBo.LoadList">
</jsp:useBean>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authorize Update</title>
        <link rel="stylesheet" href="resources\css\displaytag.css" type="text/css">
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
                    <li><a href="#">Upload Operations</a></li>
                    <li><a href="#">Unapproved Uploads</a></li>
                   
                </ul>
                   
                <!-- END BREADCRUMB -->
        <%!
                         //List<String[]> list;
                             String count;
                             String upper;
                             String lower;
                             int k;
                             int u;
                             int l;
                     %>

                     <%
                         List<NewUpload> list = listforpros.loadNewUpload((String)session.getAttribute("username"));
                         List<NewUpload> listRenewal = listforpros.loadNewRenewal((String)session.getAttribute("username"));
                         List<NewUpload> loadDeclinedUpdate = listforpros.loadNewRenewal((String)session.getAttribute("username"));
                         session.setAttribute("theList", list);
                         session.setAttribute("renewal", listRenewal);
                         session.setAttribute("update", loadDeclinedUpdate);
                   
                     %>   
             <% 
             //for (int i = 0; i < list.size(); i++) {
             //    String ref_id = list.get(i)[0];
             //  out.println(list.get(i).getRef_id());
             %>
       <div class="page-content-wrap">
        <div class="thumbnail">
        <div class="row">
            <div class="col-md-offset-2 col-md-8">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="panel-title-box">
                                <h3>Unapproved Uploads</h3>
                                <span>Lists of all newly created records or updates pending approval</span>
                            </div>
                            <ul class="panel-controls" style="margin-top: 2px;">
                                <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                                <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                            </ul>
                        </div>
                        <div class="panel-body panel-body-table">
                            <h5> Declined New</h5>
                            <div class="table-responsive">
                                 <display:table  class="table table-striped" name="sessionScope.theList" pagesize="5" id="row" sort="list">
                                    <display:column property="ref_id" title="Ref Id" sortable="true"  />
                                    <display:column title="Action">
                                        <a href="${pageContext.request.contextPath}/UpdateHandler?correct_upload='correct'&ref_id=<c:out value="${row.ref_id}" />">process</a>
                                    </display:column>
                                </display:table>
                                        <h5> Declined Updates</h5> 
                                <display:table class="table table-striped" name="sessionScope.update" pagesize="5" id="row" sort="list" >
                                    <display:column property="ref_id" title="Passport Number" sortable="true"/>
                                    <display:column title="Action">
                                        <a href="${pageContext.request.contextPath}/MultiSearcher?update='yes'&passportNumber=<c:out value="${row.ref_id}" />">process</a>
                                    </display:column>
                                </display:table>    

                                        <h5>Declined Renewals</h5> 
                                <display:table class="table table-striped" name="sessionScope.renewal" pagesize="5" id="row" sort="list">
                                    <display:column property="ref_id" title="Passport Number" sortable="true"  />
                                    <display:column title="Action">
                                        <a href="${pageContext.request.contextPath}/ImageUpload?decline='yes'&renewal='yes'&passportNumber=<c:out value="${row.ref_id}" />">process</a>
                                    </display:column>
                                </display:table> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
              
             
              

            
                 
                     
                    <!--    <input type ="hidden" name ="ref_id"  value = 'c' >  
                        <input type ="hidden" name ="correct_upload"  value = "correct" >
                        <input type ="submit" class="submitlink" style="padding: 10px;" value="Process">
		-->
                    <%--<table class="table">
                       <tr>
                            <td><%= ref_id%>   
                             <input type ="hidden" name ="ref_id"  value = "<%= ref_id%>" >  
                             <input type ="hidden" name ="correct_upload"  value = "correct" >
                             <input type ="submit" class="submitlink" style="padding: 10px;" value="Process">
                        </tr>
                    </table>--%>
                    <p id="loghc" style="height: 5px;"> </p>
            
    <% 
    //} 
    %>

                <script>
                    function renderElseWhere(id, loc) {
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?startNew=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                </table><br/>
                </div>
          </div>         
            </div>
        </div>  
    </body>
</html>
