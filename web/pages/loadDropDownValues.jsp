
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
                                    <h4 class="modal-title text-primary"> LOAD DROP DOWN VALUES </h4>
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
                                                parameters = (List<String[]>)session.getAttribute("params");
                                                showSubmit = (String)request.getAttribute("showSubmit");
                                                template  = (String)session.getAttribute("template");
                                            %>
                                            <table align ="center" class="table table-bordered">
                                                

                                                <%
                                                    for (int i = 0; i < parameters.size(); i++) {
                                                        if (("DROP_DOWN").equalsIgnoreCase(parameters.get(i)[1])) {
                                                %>

                                                <tr>  
                                                    <td width="50%"> <span class="h4 text-info"><%= parameters.get(i)[0]%></span></td>

                                                    <td width="30%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="edit_parameter"/> 
                                                            <input type="hidden" name ="parameter" value ="<%= parameters.get(i)[0]%>"/> 
                                                            <button type="submit" class="btn btn-danger">load values</button></form>
                                                    </td>
                                                </tr>
                                                    <%
                                                        }
                                                    }%>
                                                    
                                                    <td width="50%"></td>
                                                    <td width="30%">
                                                        
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="exit"/> 
                                                            <button type="submit" class="btn btn-primary">Exit</button>
                                                        </form>
                                                        
                                                    </td>
                                              </table>
                                         
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
