
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Job</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>
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
                                    <h4 class="modal-title text-primary">EDIT JOB </h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well well-lg">

                                            <%!
                                                List<String[]> parameters;
                                                String parameter;
                                                List<ParameterValues> newparams;
                                                String showSubmit;
                                                String template;
                                            %>                      




                                            <%
                                                newparams = (List<ParameterValues>) session.getAttribute("parameters");
                                                parameters = (List<String[]>) session.getAttribute("params");
                                                showSubmit = (String) request.getAttribute("showSubmit");
                                                template = (String) session.getAttribute("template");
                                            %>
                                            <table align ="center" class="table table-bordered">


                                                <%
                                                    for (int i = 0; i < parameters.size(); i++) {
                                                        if (!("document").equalsIgnoreCase(parameters.get(i)[1])) {
                                                %>

                                                <tr>  
                                                    <td width="50%"> <span class="h4 text-info"><%= parameters.get(i)[0]%></span></td>

                                                    <td width="30%">
                                                        <% if (("drop_down").equalsIgnoreCase(parameters.get(i)[1])) {%>
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="edit_parameter"/> 
                                                            <input type="hidden" name ="parameter" value ="<%= parameters.get(i)[0]%>"/> 
                                                            <button type="submit" class="btn btn-primary">load values</button></form>
                                                            <% }%>
                                                    </td>

                                                    <td width="30%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="delete_param"/> 
                                                            <input type="hidden" name ="template" value ="<%=template%>"/> 
                                                            <input type="hidden" name ="parameter" value ="<%= parameters.get(i)[0]%>"/> 
                                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash-o"></i> Delete</button></form>
                                                    </td>

                                                </tr>
                                                <%
                                                        }
                                                    }%>


                                                <%  if (!newparams.isEmpty()) { %>
                                                <%
                                                    for (int i = 0; i < newparams.size(); i++) {
                                                        if (!("document").equalsIgnoreCase(newparams.get(i).getDatatype())) {
                                                %>

                                                <tr>  
                                                    <td width="40%"> <%= newparams.get(i).getParameterName()%></td>
                                                </tr>
                                                <%
                                                                }
                                                            }
                                                        }%>
                                            </table>

                                            <p>DOCUMENTS
                                            <table align ="center" class="table table-bordered">


                                                <%
                                                    for (int i = 0; i < parameters.size(); i++) {
                                                        if (("document").equalsIgnoreCase(parameters.get(i)[1])) {
                                                %>
                                                <tr width="50%">  
                                                    <td> <span class="h4 text-info"><%= parameters.get(i)[0]%></span></td>
                                                    <td width="40%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="parameter_to_edit" value ="<%=parameters.get(i)[0]%>"/> 
                                                            <input type="hidden" name ="template" value ="<%=template%>"/> 
                                                            <input type="hidden" name ="control" value ="deleteParameterFromDb"/> 
                                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash-o"></i>Delete</button></form>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }%>


                                                <%  if (!newparams.isEmpty()) { %>
                                                <%
                                                    for (int i = 0; i < newparams.size(); i++) {
                                                        if (("document").equalsIgnoreCase(newparams.get(i).getDatatype())) {
                                                %>
                                                <tr>  
                                                    <td width="50%"><span class="h4 text-info"><%= newparams.get(i).getParameterName()%></span> </td>
                                                    <td width="40%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="parameter_to_edit" value ="<%=newparams.get(i).getParameterName()%>"/>
                                                            <input type="hidden" name ="template" value ="<%=template%>"/> 
                                                            <input type="hidden" name ="control" value ="deleteParameterFromSessionOnEditJob"/> 
                                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash-o"></i> Delete</button></form>
                                                    </td>
                                                </tr>


                                                <%
                                                                }
                                                            }
                                                        }%>


                                            </table>


                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-md-4 col-xs-12 control-label">Enter Parameter :</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <div class="input-group">
                                                            <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                            <input type="text" class="form-control" placeholder="parameter" id="parameter" autocomplete="off" name="parameter" value="" onchange="renderElseWhere1('parameter', 'loghc')"/>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-4 col-xs-12 control-label">Parameter Type :</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <select class="form-control select" data-live-search="true" name="dataType" value="" id="dataType" onchange="renderElseWhere2('dataType', 'loghc')" />
                                                        <option value=""></option>
                                                        <option value="SUBHEAD">SUB HEAD</option>
                                                        <option value="STRING">FORM FIELD</option>
                                                        <option value="DROP_DOWN">DROP DOWN</option>
                                                        <option value="DOCUMENT">DOCUMENT</option>
                                                        <option value="DATE">DATE</option>
                                                        </select>
                                                    </div> 
                                                </div>
                                                <input type="hidden" name ="control" value ="addParameterFromEdit"/>  
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <button class="btn btn-success btn-block" type="submit"><b class="fa fa-plus-circle"></b> Add Parameter</button>
                                                    </div>
                                                </div>
                                            </form>

                                            <div class="col-md-offset-2 col-md-4">
                                                <%if (!newparams.isEmpty()) {%>
                                                <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                    <input type="hidden" name ="control" value ="submitEditJob"/>   
                                                    <button class="btn btn-success btn-block" type="submit"><b class="fa fa-send-o"></b> Submit</button>
                                                </form>
                                                <% } %>
                                            </div>

                                             <%
                                                        System.out.println("this is showSubmit " + showSubmit);
                                                        if ("yes".equalsIgnoreCase(showSubmit)) 
                                            { %>
                                           
                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-offset-7 col-md-3">
                                                        <input type="hidden" name ="control" value ="submitEditJob"/>   
                                                        <input type="hidden" name ="template" value ="submitEditJob"/>   
                                                        <button class="btn btn-success btn-block" type="submit"><b class="fa fa-send-o"></b>Submit</button>
                                                    </div>
                                                </div>
                                            </form>
                                            <%}%>


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


                                </body>
                                </html>
