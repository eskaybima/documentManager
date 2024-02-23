
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
                                              
                                                    <span class="h4 text-info">FORM DETAILS</span>
                                                           
                                                    <table align ="center" class="table table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th align ="center" width="50%">Form Name</th>
                                                                <th align ="center" width="50%">Description</th> 
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        <td>
                                                            <div class="col-md-10">
                                                            <input type="text" class="form-control" placeholder="TemplateName" id="templateName" autocomplete="off" name="templateName" value="<%=templateName%>" onchange="renderElseWhere4('templateName', 'loghc')"/> 
                                                            </div>
                                                        </td>

                                                        <td>
                                                            <div class="col-md-10">
                                                            <input type="text" class="form-control" placeholder="Description"  name="description" id ="description" value="<%=description%>" onchange="renderElseWhere5('description', 'formHeader', 'loghc')"/>
                                                           </div>
                                                        </td>
                                                        </tbody>         
                                                    </table>
                                                    
                                               
                                            </form>
                                            <br><br><br>
                                           
                                            <div id="set_up_form"> 
                                            <table align ="center" class="table table-bordered"  id="set_up">
                                                <thead>
                                                    <tr>
                                                        <th align ="center" width="50%">PARAMETER</th>
                                                        <th align ="center" width="40%">TYPE</th>  
                                                        <th align ="center" width="10%">DELETE</th>  
                                                    </tr>
                                                </thead>

                                              
                                               
                                                
                                                  <table align ="center" class="table table-striped table-bordered table-hover">
                                                     <thead>
                                                     <tr>
                                                        <th align ="center" width="50%"></th>
                                                        <th align ="center" width="40%"></th>  
                                                        <th align ="center" width="10%"></th>  
                                                    </tr>
                                                   </thead>
                                                      <tbody>
                                                        <tr>
                                                            <td>
                                                            <input type="text" class="form-control" placeholder="parameter" id="parameter" autocomplete="off" name="parameter" value=""/></td>
                                                            <td>
                                                            <input type="hidden" name ="control" value ="addParameter"/> 
                                                            <div id="selectController">
                                                            <select class="form-control select" data-live-search="true" name="dataType" value=""  autocomplete="off" id="dataType"/>
                                                            <option value="Select"></option>
                                                            <option value="SUBHEAD">SUB HEAD</option>
                                                            <option value="STRING">FORM FIELD</option>
                                                            <option value="DROP_DOWN">DROP DOWN</option>
                                                            <option value="DOCUMENT">DOCUMENT</option>
                                                            <option value="DATE">DATE</option>
                                                            </select>
                                                            </div>
                                                             <td>
                                                            <button class="btn btn-success btn-block"  id="add_form_field"  type="submit"></b>Add</button>
                                                          </tr>
                                                            </tbody>
                                                        </table>  
                                                     </div>
                                                </div>
                                                
                                                       
                                                
                                           

                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <div class="col-md-offset-5 col-md-3">
                                                        <button type="button" class="btn btn-success btn-block" id="sendajax" onclick="submitChange()"><b class="fa fa-save"></b>Submit</button>
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
                        //var formHeader = document.getElementById(header).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?description=' + description + '&params=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script> 

                </body>
                </html>
