<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://displaytag.sf.net" prefix="display" %>

<!DOCTYPE htmlz
<html>
    <head>
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

                <%!                        List<String[]> list;
                    String count;
                    String upper;
                    String lower;
                    int k;
                    int u;
                    int l;
                    SaveToDb sb = new SaveToDb();
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

<div class="row">
<div class="col-md-12">
    <!-- START PROJECTS BLOCK -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="panel-title-box">
                <h3> Number of Pending Jobs is : <%=count%></h3>
                
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


                <table class="table" >  
                    <tr> 
                        <% if ((u - 3) >= 0) {%>
                        <td>
                            <form action ="${pageContext.request.contextPath}/Authorize">
                                <input type ="hidden" name ="previous"  value = "prev" >
                                <input type ="hidden" name ="AuthorizeType"  value = "update" >
                              
                                  <button type="submit" class="btn btn-info"><b class="fa fa-arrow-left"></b> Previous</button>
                            </form>  
                        </td> 
                        <% }
                            if (k >= (l + 3)) {%>
                        <td>
                            <form action ="${pageContext.request.contextPath}/Authorize">
                                <input type ="hidden" name ="next"  value = "next" >
                                <input type ="hidden" name ="AuthorizeType"  value = "update" >
                               
                                 <button type="submit" class="btn btn-info"><b class="fa fa-arrow-right"></b> Next</button>
                                <% }%>
                            </form>
                        </td>
                    </tr>  
                </table>

                     <div class="table-responsive">
                <form action ="${pageContext.request.contextPath}/Authorize">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th width="10%">ID</th>
                        <th width="40%">Reference ID</th>
                        <th width="30%">Activity</th>
                    </tr>
                    </thead>
                    <tbody>
                <%

                    for (int i = 0; i < list.size(); i++) {
                        String trans_no = list.get(i)[0];
                        String ref_id = sb.getValue("ref_id", "fas_update_request", "trans_no", trans_no);
                %>
                <div class="table-responsive">
                <form action ="${pageContext.request.contextPath}/Authorize">
                    <table class="table">
                        <tr>
                            <td><%= trans_no%>
                            <td><%= ref_id%>   
                                <input type ="hidden" name ="trans_no"  value = "<%= trans_no%>" >
                                <input type ="hidden" name ="ref_id"  value = "<%= ref_id%>" >
                           
                                   <button type="submit"class="btn btn-success" ><span class="fa fa-cog"></span> Process</button>
                        </tr>
                    </table>
                    <p id="loghc" style="height: 10px;"> </p>
                </form>
                </div>               
                <% }%>
                   </tbody>
                </table>  
                   <p id="loghc" style="height: 10px;"> </p>
                     </div>
      </div>
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
