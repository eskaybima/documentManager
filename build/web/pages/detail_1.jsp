
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
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>
                    <!-- START BREADCRUMB -->
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                    <li><a href="#">View Record</a></li>
                    <li class="active">Search Result</li>
                </ul>
                <!-- END BREADCRUMB -->
                <div id="bodyhold">
                    <div id="bodycon">  

                        <%!
                            String passportNumber = "";
                            String surname = "";
                            String firstname = "";
                            String middlename = "";
                            String state = "";
                            String dob = "";
                            String sex = "";
                            String country = "";
                            String offset = null;
                            List<String> imageList;
                            List<String[]> values;
                            String doc_type;
                            String doc_path;
                            String doc_id;
                            String ref_id;
                            int size;

                            String count;
                            String upper;
                            String lower;
                            int k;
                            int u;
                            int l;
                        %>

                        <%
                            count = (String) request.getAttribute("count");
                            upper = (String) request.getAttribute("upper");
                            lower = (String) request.getAttribute("lower");
                            k = Integer.parseInt(count);
                            u = Integer.parseInt(upper);
                            l = Integer.parseInt(lower);
                        %>


                        <%if (session.getAttribute("banner") != null) {%>
                        <script type="text/javascript">
                            $(document).ready(function () {
                                var elements = document.getElementsByClassName('pagebanner');
                                var pageLinks = document.getElementsByClassName('pagelinks');
                                var returnString;
                                var links;
                                var currentDisplay;
                                var next = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=next" style="width:70px;"  >Get More</a>';
                                var previous = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=previous" style="width:70px;" >Previous</a>';
                                for (var i = 0; i < elements.length; i++) {
                                    returnString = elements[i].innerHTML
                                    currentDisplay = returnString.substring(returnString.indexOf("displaying"), returnString.length);
                                    returnString = '<%=session.getAttribute("banner")%>';
                            <%if (session.getAttribute("next") != null) {%>
                                    returnString = returnString + ' ' + next;
                            <%}%>
                            <%if (session.getAttribute("previous") != null) {%>
                                    returnString = returnString + ' ' + previous;
                            <%}%>
                                    elements[i].innerHTML = '<b>Overall : </b>' + ' ' + returnString;
                                }
                                for (var i = 0; i < pageLinks.length; i++) {
                                    links = pageLinks[i].innerHTML
                                    links = 'Currently ' + currentDisplay + links;
                                    pageLinks[i].innerHTML = '<b>Current Display : </b>' + ' ' + links;
                                }
                            });
                        </script>
                        <%}%>

                        <table >  
                            <tr> 
                                <% if ((u - 3) >= 0) { %>
                                <td>
                                    <form action ="${pageContext.request.contextPath}/MultiSearcher">
                                        <input type ="hidden" name ="previous"  value = "prev" >
                                        <input type ="hidden" name ="SearchType"  value = "yes" >
                                        <input type ="hidden" name ="responseDestination"  value = "/pages/detail_1.jsp" >
                                        <input type ="submit" class="submitlink" style="padding: 10px;" value="Previous">
                                    </form>  
                                </td> 
                                <% }
                            if (k >= (l + 3)) { %>
                                <td>
                                    <form action ="${pageContext.request.contextPath}/MultiSearcher">
                                        <input type ="hidden" name ="next"  value = "next" >
                                        <input type ="hidden" name ="responseDestination"  value = "/pages/detail_1.jsp" >
                                        <input type ="hidden" name ="SearchType"  value = "yes" >
                                        <input type ="submit" class="submitlink" style="padding: 10px;" value="Next">

                                        <% } %>
                                    </form>
                                </td>
                            </tr>  
                        </table>

                        <%
                            values = (List<String[]>) request.getAttribute("searchList");
                            imageList = (List<String>) request.getAttribute("documents");
                            size = values.size();

                        %>
                        <!-- new list ui -->
                        <!-- PAGE CONTENT WRAPPER -->
                        <div class="page-content-wrap">
                            <div class="row">
                                <div class="col-md-offset-1 col-md-10">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <div class="panel-title-box">
                                              <!--  <h3>Number of Record found : <%=count%></h3>  -->
                                                <span>Lists of all records found for your search</span>
                                            </div>
                                            <ul class="panel-controls" style="margin-top: 2px;">
                                                <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                                                <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                                            </ul>
                                        </div>
                                        <div class="panel-body panel-body-table">

                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th><span class="fa fa-money"></span>Reference Id</th>

                                                        </tr>
                                                    </thead>
                                                    <tbody>


                                                        <%
                                                            for (int i = 0; i < size; i++) {
                                                                ref_id = values.get(i)[8];
                                                        %>
                                                        <tr>
                                                            <td><span class="h3 text-info"><span class="fa fa-arrow-circle-right"></span> <a href="${pageContext.request.contextPath}/pages/detail_2.jsp?ref_id=<%=ref_id%>" id="a"><%=ref_id%></a></span></td>

                                                        </tr> 
                                                        <%}%>   
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- END PAGE CONTENT WRAPPER -->
                        <!-- end of new list -->
                        <p id="loghc" style="height: 10px;"> </p>
                    </div>
                </div>     
            </div>
        </div>                
    </body>
</html>
