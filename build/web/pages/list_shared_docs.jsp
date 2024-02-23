
<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="listforpros" scope="page" class="com.fasyl.vo.LoadList">
</jsp:useBean>
<!DOCTYPE html> 
<html>
    <head>
        <title>Details</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
            <script>
                $(function () {
                    $("#accord").accordion();
                });
            </script>
        </head>
        <body id="background">
            <div class="page-container">

            <jsp:include page="leftMenu.jsp"></jsp:include>
                <!-- START BREADCRUMB -->
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                    <li><a href="#">View Shared Documents</a></li>
                    <li class="active">View Shared Documents</li>
                </ul>
                <%!
                    
                    List<LoaderVo> list;
                %>


                <%
                     list = listforpros.loadSharedList((String)session.getAttribute("username"));
                     session.setAttribute("theList", list);
                %>
                <!-- new detail table-->
                <div class="page-content-wrap">
                    <div class="thumbnail">
                        <div class="row">
                            <div class="col-md-offset-2 col-md-8">

                                <div class="panel panel-default">
                                    <div class="panel-heading">

                                        <ul class="panel-controls" style="margin-top: 2px;">
                                            <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                                            <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                                        </ul>
                                    </div>
                                    <div class="panel-body panel-body-table">
                                        <div class="table-responsive">
                                            <display:table  class="table table-striped" name="sessionScope.theList" pagesize="5" id="row" sort="list">
                                                <display:column property="doc_id" title="DOCUMENT ID" sortable="true"/>
                                                <display:column property="shared_by" title="SHARED BY" sortable="true"/>
                                                <display:column property="date_shared" title="DATE SHARED" sortable="true"/>
                                                <display:column title="View">
                                                 <a href="${pageContext.request.contextPath}/PDFLoader?view=<c:out value="${row.doc_id}"/>">View</a>
                                                </display:column>
                                                
                                            </display:table>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- end of new detail table-->


                <p id="loghc" style="height: 10px;"> </p>
            </div>
        </div>
    </body>
</html>
