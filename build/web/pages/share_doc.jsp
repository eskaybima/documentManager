
<%@page import="com.fasyl.newjobBo.PageUtil"%>
<%@page import="com.fasyl.newjobBo.LoadValues"%>
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
                    <li><a href="#">Share Document</a></li>
                    <li class="active">Share Document</li>
                </ul>
                <%!
                    String id = "";
                    SaveToDb sb = new SaveToDb();
                %>


                <%
                    id = request.getParameter("id");
                %>
                <!-- new detail table-->
                <div class="page-content-wrap">
                    <div class="row">
                        <div class="col-md-offset-2 col-md-8">
                          <form class="form-horizontal" action ="${pageContext.request.contextPath}/ConfigureJobController">
                                <table>        
                                    <tr>
                                        <td></td><td><img src="${pageContext.request.contextPath}/PDFLoader?view=<%=id%>" align="top" border="0" style="width:250px;height:400px;"></td>
                                    </tr> 
                                    <input type ="hidden" name ="id"  value = "<%=id%>" >
                                    <input type ="hidden" name ="control"  value = "share_doc" >
                                    <tr>
                                    <td>Share With:</td>
                                    <td>
                                        <select type="text" class="inputtext"name="user"  value ="" required>
                                            <%  List<String> users = sb.getList2("select user_id from fas_mst_users");
                                                for (int i = 0; i < users.size(); i++) {
                                            %>
                                            <option value="<%=users.get(i)%>"><%= users.get(i)%></option>
                                            <%}%>
                                            <select/>
                                    </td>
                                    </tr>
                                    <tr>
                                     <td><button class="btn btn-primary" type="submit"><i class="fa fa-folder-open"></i>Share</button></td>
                                    </tr>
                                </table> 
                          </form> 
                        </div>
                    </div>
                    <!-- end of new detail table-->


                    <p id="loghc" style="height: 10px;"> </p>
                </div>
            </div>
    </body>
</div>  
</html>
