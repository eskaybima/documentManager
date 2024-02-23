
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Template</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>

           
            <link rel="stylesheet" href="projectresource/css/superslides/superslides.css" type="text/css">
            
            <script type="text/javascript" src="js/bootstrapValidator.min.js" ></script>
            <script type="text/javascript" src="js/validateConfigJob.js"></script>
        </head>
        <body id="background">
            <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>

                    <div class="page-content-wrap">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                    <h4 class="modal-title text-primary"></span>Create Template </h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well well-lg">

                                            <%!
                                                List<ParameterValues> parameters;
                                                String templateName;
                                                String description;
                                                String formHeader;
                                            %>                      

                                            <%
                                                parameters = (List<ParameterValues>) session.getAttribute("parameters");
                                                description = (String) session.getAttribute("description");
                                                formHeader = (String) session.getAttribute("formHeader");
                                                templateName = (String) session.getAttribute("templateName");

                                                if ("null".equalsIgnoreCase(templateName) || (templateName == null)) {
                                                    templateName = "";
                                                }
                                                if ("null".equalsIgnoreCase(description) || (description == null)) {
                                                    description = "";
                                                }
                                                if ("null".equalsIgnoreCase(formHeader) || (formHeader == null)) {
                                                    formHeader = "";
                                                }
                                            %>

                                             <form id="templateConfig" action = "${pageContext.request.contextPath}/CreateUser" class="form-horizontal" method="post">
                                               <div class="thumbnail">
                                                    <span class="h4 text-info">FORM DETAILS</span>
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <label class="control-label">Form Name:</label>
                                                            <input type="text" class="form-control" placeholder="TemplateName" id="templateName" autocomplete="off" name="templateName" value="<%=templateName%>" onchange="renderElseWhere4('templateName', 'loghc')"/> 
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label class="control-label">Description:</label>
                                                            <input type="text" class="form-control" placeholder="Description"  name="description" id ="description" value="<%=description%>" onchange="renderElseWhere5('description', 'formHeader', 'loghc')"/>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <label class="control-label">Form Header:</label>
                                                            <input type="text" class="form-control" placeholder="FormHeader" id="formHeader" autocomplete="off" name="formHeader" value="<%=formHeader%>" onchange="renderElseWhere5('description', 'formHeader', 'loghc')"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </form>
                                            <br><br><br>

                                            <% if (!parameters.isEmpty()) {%>
                                            <table align ="center" class="table table-bordered"  id="set_up">
                                                <thead>
                                                    <tr>
                                                        <th align ="center" width="50%">DATANAME</th>
                                                        <th align ="center" width="40%">TYPE</th>  
                                                        <th align ="center" width="10%">Delete</th>  
                                                    </tr>
                                                </thead>

                                                <%
                                                    for (int i = 0; i < parameters.size(); i++) {
                                                        String documents = parameters.get(i).getParameterName();
                                                        String dataType = parameters.get(i).getDatatype();
                                                        String doc_id = "";
                                                %>

                                                <tr>  
                                                    <td> <%= documents%></td>
                                                    <td> <%= dataType%></td>  
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="deleteParameter"/> 
                                                            <input type="hidden" name ="parameter" value ="<%=documents%>"/> 
                                                            <button type="submit" class="btn btn-danger"> <i class="fa fa-trash-o"></i> Delete</button></form>
                                                    </td>
                                                </tr>
                                                <%
                                                    }%>
                                            </table>
                                            <%}%>

                                            <div class="thumbnail">
                                                <span class="h4 text-info">FORM FIELDS</span>
                                                <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                    <div class="row">
                                                        
                                                        <table align ="center" class="table table-striped table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th width="50%"> Parameter </th>
                                                                <th width="40%"> Choose Type </th>
                                                                <th width="10%"> Click To Add </th>
                                                            </tr>
                                                        </thead>
                                                        
                                                        <tbody>
                                                        <tr>
                                                            <td>
                                                            <input type="text" class="form-control" placeholder="parameter" id="parameter" autocomplete="off" name="parameter" value="" onchange="renderElseWhere1('parameter', 'loghc')"/></td>
                                                    <!--    
                                                        </div>
                                                        <div class="col-md-5">
                                                    -->     <td>
                                                            
                                                            <input type="hidden" name ="control" value ="addParameter"/> 
                                                            <select class="form-control select" data-live-search="true" name="dataType" value="" id="dataType" onchange="renderElseWhere2('dataType', 'loghc')" />
                                                            <option value=""></option>
                                                            <option value="SUBHEAD">SUB HEAD</option>
                                                            <option value="STRING">FORM FIELD</option>
                                                            <option value="DROP_DOWN">DROP DOWN</option>
                                                            <option value="DOCUMENT">DOCUMENT</option>
                                                            </select>
                                                             <!-- 
                                                        </div>
                                                        <div class="col-md-3">
                                                             -->
                                                             <td>
                                                            <button class="btn btn-success btn-block" type="submit"></b>Add Parameter</button>
                                                            </tr>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </form>
                                            </div>

                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-offset-5 col-md-3">
                                                        <input type="hidden" name ="control" value = "createJob"/>
                                                        <button class="btn btn-success btn-block" type="submit"><b class="fa fa-send-o"></b> Submit</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <p id="loghc" style="height: 10px; display: none;"> </p>

                <script>
                    function renderElseWhere1(id, loc) {
                        var parameter = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?documentParameter=' + parameter + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>  

                <script>
                    function renderElseWhere2(id, loc) {
                        var dataType = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?dataType=' + dataType + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>  
                <script>
                    function renderElseWhere3(id, loc) {
                        var defaultValue = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?defaultValue=' + defaultValue + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere4(id, loc) {
                        var templateName = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?templateName=' + templateName + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script> 

                <script>
                    function renderElseWhere5(desc, header, loc) {
                        var description = document.getElementById(desc).value;
                        var formHeader = document.getElementById(header).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?description=' + description + '&formHeader=' + formHeader + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script> 

                </body>
                </html>
