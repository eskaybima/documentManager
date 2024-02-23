<%-- 
    Document   : access_control
    Created on : 16-Nov-2018, 09:45:48
    Author     : OYEWOLE
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Access Control</title>
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
                    <li><a href="#">Administrator</a></li>
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
                                    List<String[]> searchResult = (List<String[]>) session.getAttribute("searchResult");
                                    if (!searchResult.isEmpty()) {
                                        for (int k = 0; k < searchResult.size(); k++) {
                                %>
                                <tr>
                                    <form class="form-horizontal" action="${pageContext.request.contextPath}/Authorize">
                                    <td><b><%=searchResult.get(k)[0]%></b></td>
                                    <td><b><%=searchResult.get(k)[1]%></b></td>
                                    <td> 
                                     <b><%=searchResult.get(k)[2]%></b>
                                     
                                        <input type ="hidden" name ="ref_id"  value = "<%=searchResult.get(k)[0]%>" >
                                        <input type ="hidden" name ="manage_access"  value = "new" >
                                    </td>
                                    <td><%=searchResult.get(k)[3].substring(0, 10)%></td>
                                    <td>
                                        <button type="submit" class="btn btn-success btn-block"></b>Control Access</button>
                                    </td>  
                                     </form>
                                </tr>
                            <% }
                            }%>
                           </tbody>
                        </table>

                    </div>
            </div> </div>
    </body>
</html>
