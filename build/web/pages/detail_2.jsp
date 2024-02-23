
<%@page import="com.fasyl.util.FormatAmount"%>
<%@page import="com.fasyl.newjobBo.Refinery"%>
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
                    <li><a href="#">View Record</a></li>
                    <li class="active">Search Result Details</li>
                </ul>
                <%!
                    List<String> imageList;
                    List<String[]> values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                    String ref_id;
                    String cre_user_id;
                    String mar_status;
                    String title;
                    String template;
                    List<String> parameters;
                    List<String> crude_parameters;
                    List<String[]> data;
                    String formHeader;
                    String cre_dated;
                    SaveToDb sb = new SaveToDb();
                    boolean isdocAvailable;
                %>


                <%
                    values = (List<String[]>) request.getAttribute("searchList");
                    imageList = (List<String>) request.getAttribute("documents");
                    ref_id = request.getParameter("ref_id");
                    template = sb.getValue2("select template from template_id where ref_id ='" + ref_id + "'");
                    crude_parameters = sb.getList2("select param_names from params_table_"+template+" where type not in ('DOCUMENT')");
                    parameters = sb.getList2("select param_names from params_table_"+template+" where type not in ('DOCUMENT', 'SUBHEAD')");
                    formHeader = sb.getValue2("select description from template_names where template_name ='" + template + "'");
                   
                    /*
                    String selectQuery = "select ";
                    for (int i = 0; i < parameters.size(); i++) {
                        selectQuery = selectQuery + parameters.get(i) + ", ";
                    }
                    selectQuery = selectQuery + " uploaded_by from "+ template +" where ref_id = '" + ref_id + "'";
                    data = sb.getListss(selectQuery, parameters.size() + 1);
                    */        
                    data = Refinery.refineValue(ref_id);
                %>
                 
                <div class="page-content-wrap">
                    <div class="row">
                        <div class="col-md-offset-2 col-md-8">
                            <div class="thumbnail">
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th width="30%"><%=formHeader %></th>
                                            <th width="70%"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        
                                        <% for (int i = 0; i < data.size(); i++) {%>
                                        <% if ("SUBHEAD".equalsIgnoreCase(data.get(i)[1])) { %>
                                        <tr><td colspan="2"><div class="modal-header"><span class="h5 text-info"><%= data.get(i)[0].replace("_", " ").toUpperCase() %></strong></span></div><td></tr>
                                        <%} else{%>
                                        <tr>
                                       <td><span class="h5"><%= data.get(i)[0].replace("_", " ").toUpperCase() %>:</span></td>   
                                            <td class="text-info h5"><%=data.get(i)[1]%></td>
                                        </tr>
                                        <%}
                                        }%>
                                        <tr>
                                            <td colspan="2"><span class="h3 text-primary"><i class="fa fa-file-archive-o"></i> List of Uploaded Documents</span></td>
                                        </tr>
                                        <%
                                            List<LoaderVo> l = sb.getLoaderList(ref_id);
                                            for (int k = 0; k < l.size(); k++) {
                                                doc_type = l.get(k).getType().replace("_", " ").toUpperCase();
                                                doc_id = l.get(k).getDoc_id();
                                                isdocAvailable = PageUtil.isDocAvailable(doc_id);
                                        %>
                                        <tr>
                                            <td><span class="h5"><%= doc_type%></span></td>
                                            <td class="text-info">
                                                <div class="row">
                                                    <div class="col-md-6">
                                                         <% if (isdocAvailable) {%>
                                                <form class="form-horizontal" action ="${pageContext.request.contextPath}/PDFLoader" target="_blank">
                                                    <input type ="hidden" name ="view"  value = "<%=doc_id%>" >
                                                    <button class="btn btn-primary" type="submit"><i class="fa fa-folder-open"></i> View Document</button>
                                                </form>
                                                <%} else {%>
                                                <label style="color:orangered" for="Not Available">Not Available</label>
                                                <%}%>
                                                    </div>
                                                    <div class="col-md-6">
                                                         <% if (isdocAvailable) {%>
                                                <form class="form-horizontal" action ="./share_doc.jsp">
                                                    <input type ="hidden" name ="id"  value = "<%=doc_id%>" >
                                                    <button class="btn btn-primary" type="submit"><i class="fa fa-external-link-square"></i>Share</button>
                                                </form>
                                                    </div>
                                                </div>
                                         </td>   
                                            
                                        <%}}%>
                                         </tr>
                                    </tbody>
                                </table>
                                Authorization History   

                                <div class="well well-sm">  
                                    <table class="table table-bordered table-striped">
                                        
                                        <tr>
                                                            <td colspan="2">
                                                                <div class="row">
                                                                    <div class="col-md-2"><span class="h4">Comment</span></div> 
                                                             <!--   <div class="col-md-3"> <span class="h4"></span></div>   --> 
                                                                    <div class="col-md-2"> <span class="h4">Evaluating Officer</span></div>
                                                                    <div class="col-md-3"> <span class="h4">Tax Type</span></div>
                                                                    <div class="col-md-2"> <span class="h4">Amount Due</span></div>
                                                                    <div class="col-md-3"> <span class="h4">Date</span></div>
                                                                </div>

                                                            </td>
                                                        </tr>
                                        <%

                                                            List<String[]> history = sb.getListss("select comments, action, user_id, tax_type, amount_recommended,  to_char(trans_date ,'DD-MON-YYYY HH:MI:SS') from fas_action_flow where ref_id = '" + ref_id + "' order by trans_date asc ", 6);
                                                            if (!history.isEmpty()) {
                                                                for (int his = 0; his < history.size(); his++) {
                                                                 String taxType = history.get(his)[3]; 
                                                                 String amount = history.get(his)[4];
                                                                 amount = FormatAmount.formatAmount(amount);
                                                                 if ("null".equalsIgnoreCase(taxType) | (taxType == null)) {
                                                                   taxType = "";  
                                                                 }
                                                                 if ("n,ull".equalsIgnoreCase(amount) | (amount ==null)) {
                                                                     amount = "";
                                                                 }
                                                       %>
                                                        <tr>
                                                            <td colspan="2">
                                                                <div class="row">
                                                                    <div class="col-md-2"> <span class="h4"><%= history.get(his)[0]%></span></div> 
                                                             <!--   <div class="col-md-3"> <span class="h4"><%= history.get(his)[1]%></span></div>   --> 
                                                                    <div class="col-md-2"> <span class="h4"><%= history.get(his)[2]%></span></div>
                                                                    <div class="col-md-3"> <span class="h4"><%= taxType%></span></div>
                                                                    <div class="col-md-2"> <span class="h4"><%= amount%></span></div>
                                                                    <div class="col-md-3"> <span class="h4"><%= history.get(his)[5]%></span></div>
                                                                </div>

                                                            </td>
                                                        </tr>
                                                        <%}
                                                        }%>      

                                    </table>       

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end of new detail table-->


                    <p id="loghc" style="height: 10px;"> </p>
                </div>
                </body>
            </div>  
</html>
