
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Payment Types</title>
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
                                    <h4 class="modal-title text-primary">Edit Payment Types</h4>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="well well-lg">

                                            <%!
                                                List<String[]> parameters;
                                                SaveToDb sb = new SaveToDb();
                                            %>                      

                                            
                                            
                                            
                                            <%
                                                parameters = sb.getListss("select tax_name, description from tax_type", 2);
                                            %>
                                           
                                            <table align ="center" class="table table-bordered">
                                                
                                                <tr width="50%">  
                                                                     <td width="50%"> <span class="h4 text-info">PAYMENT TYPE</span></div> 
                                                                     <td width="50%"> <span class="h4 text-info">Description</span></div>
                                                </tr>
                                                
                                                <tr width="50%"> 
                                                <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="add_pay_type"/> 
                                                             <td width="50%"> <span class="h4 text-info"><input type="text" name ="tax_name" value =""/></div> 
                                                             <td width="50%"> <span class="h4 text-info"><input type="text" name ="description" value =""/></div> 
                                                            <td width="50%"> <button type="submit" class="btn btn-success"><i class="fa fa-plus"></i>Add</button></div>
                                                </form>
                                                </tr>
                                                
                                                <%
                                                    for (int i = 0; i < parameters.size(); i++) {
                                                %>

                                                <tr width="50%">  
                                                    <td width="50%"> <span class="h4 text-info"><%= parameters.get(i)[0]%></span></td>
                                                     <td width="50%"> <span class="h4 text-info"><%= parameters.get(i)[1]%></span></td>
                                                        <td width="30%">
                                                        <form action="${pageContext.request.contextPath}/ConfigureJobController" class="form-horizontal">
                                                            <input type="hidden" name ="control" value ="delete_pay_type"/> 
                                                            <input type="hidden" name ="tax_name" value ="<%= parameters.get(i)[0]%>"/> 
                                                            <input type="hidden" name ="description" value ="<%= parameters.get(i)[1]%>"/> 
                                                            <button type="submit" class="btn btn-danger"><i class="fa fa-trash-o"></i> Delete</button>
                                                        </form>
                                                    </td>
                                                    
                                                </tr>
                                                <%
                                                    }%>
                                                    
                                                   
                                              </table>
                                            
                                             
                                              
                                              
                                             
                                    
                        </div>
                    </div>
                </div>
                <p id="loghc" style="height: 10px; display: none;"> </p>   
            

                </body>
                </html>
