
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Configure Job</title>
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
                                    <h4 class="modal-title text-primary"></span>EDIT PARAMETER</h4>
                                </div>






                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well well-lg">







                                            <%!                                                
                                                List<String> values;
                                                List<String> valuesInDb;
                                                String parameter_to_edit;
                                                SaveToDb sb = new SaveToDb();
                                                String template;
                                            %>                      

                                            <%
                                                template = (String) session.getAttribute("template");
                                                parameter_to_edit = (String) request.getAttribute("parameter_to_edit");
                                                values = (List<String>) session.getAttribute("values");
                                                valuesInDb = sb.getList2("select param_value from param_values_" + template + " where parameter_name = '" + parameter_to_edit + "'");
                                            %>


                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal" align = "center">
                                                <input type="hidden" name ="control" value ="formList"/> 
                                                <input type="hidden" name ="parameter_to_edit" value ="<%= parameter_to_edit%>"/> 
                                                <select name="formList" value="" id="formList"/>
                                                <option value="">Select item to upload</option>
                                                <option value="Titles">Titles</option>
                                                <option value="State">States of Nigeria</option>
                                                <option value="Countries">Countries of the World</option>
                                                </select>
                                                <button type="submit" class="btn btn-primary">Upload List</button>
                                            </form>


                                            <label align ="center"> <h> VALUES FOR  <%= parameter_to_edit.toUpperCase()%></h> </label>
                                           <table class="table table-bordered" align ="center">
                                                <% if (!values.isEmpty()) {%>
                                                <%
                                                    for (int i = 0; i < values.size(); i++) {
                                                    if (!valuesInDb.contains(values.get(i))) {
                                                %>

                                                <tr>  
                                                    <td> <%= values.get(i)%></td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="deleteValue"/> 
                                                            <input type="hidden" name ="parameter_to_edit" value ="<%= parameter_to_edit%>"/> 
                                                            <input type="hidden" name ="value" value ="<%=values.get(i)%>"/> 
                                                            <input type="hidden" name ="template" value ="<%= template%>"/> 
                                                            <button type="submit"  class="btn btn-danger">Delete</button></form>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }%>
                                                <% } %>

                                                <% if (!valuesInDb.isEmpty()) {%>
                                                <%
                                                    for (int i = 0; i < valuesInDb.size(); i++) {
                                                %>        
                                                <tr>  

                                                    <td width="50%"> <span class="h4 text-info"><%= valuesInDb.get(i)%></span></td>

                                                    <td width="30%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="deleteValueFromDb"/> 
                                                            <input type="hidden" name ="parameter_to_edit" value ="<%= parameter_to_edit%>"/> 
                                                            <input type="hidden" name ="template" value ="<%= template%>"/> 
                                                            <input type="hidden" name ="value" value ="<%=valuesInDb.get(i)%>"/> 
                                                            <button type="submit"  class="btn btn-danger">Delete</button></form>
                                                    </td>



                                                </tr>
                                                <%
                                                    }%>
                                                <% }                                                        %>





                                                <tr>
                                                <div class="form-group">

                                                    <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                        <td width="50%">
                                                            <label class="col-md-4 col-xs-12 control-label">Enter Value :</label>
                                                            <div class="col-md-5 col-xs-12">
                                                                <div class="input-group">
                                                                    <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                                    <input type="text" class="form-control" placeholder="Value" id="value" autocomplete="off" name="value" value="" onchange="addDefaultValue('value', '<%= parameter_to_edit%>', 'loghc')"/>
                                                                </div>
                                                            </div>
                                                            <input type="hidden" name ="parameter_to_edit" value ="<%= parameter_to_edit%>"/>    
                                                            <input type="hidden" name ="control" value ="addValue"/>        
                                                        </td>
                                                        <td width="30%">
                                                            <div class="form-group">
                                                                <button class="btn btn-primary" type="submit">Add</button>
                                                            </div>
                                                        </td>
                                                    </form>
                                                    </tr> 
                                                    <tr>
                                                        <td>
                                                            <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                                <div class="form-group">
                                                                    <div class="col-md-offset-7 col-md-3">
                                                                        <input type="hidden" name ="control" value = "submit_values"/>
                                                                        <input type="hidden" name ="template" value ="<%= template%>"/> 
                                                                        <input type="hidden" name ="parameter_to_edit" value ="<%= parameter_to_edit%>"/> 
                                                                        <button class="btn btn-success btn-block" type="submit"><b>Submit</b></button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </td>       
                                                    </tr>        
                                                </div>                                    
                                                </td>

                                            </table> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <p id="loghc" style="height: 10px; display: none;"> </p>

                    <script>
                        function addDefaultValue(id, parameter_to_edit, loc) {
                            var value = document.getElementById(id).value;
                            var print = '<img src="${pageContext.request.contextPath}/Initiator?paramterValue=' + value + '&parameter_to_edit=' + parameter_to_edit + ';">';
                            document.getElementById(loc).innerHTML = print
                        }
                    </script>                          


                    </body>
                    </html>
