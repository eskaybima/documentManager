
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%  String auth_id = (String) session.getAttribute("username");
    String role_id = (String) session.getAttribute("role_id");
    SaveToDb sb = new SaveToDb();
    List<String[]> locss = sb.getList3("select loc_id, loc_desc from fas_mst_location");
    List<String[]> usersForEdit = sb.getList4("select user_id,last_name, first_name from fas_mst_users where user_auth_id = '" + auth_id + "'");
    List<String[]> UsersbyLoc = sb.getList3("select distinct  user_id,last_name  from fas_mst_users");
    List<String[]> templates = sb.getListss("select template_name, description from template_names", 2);
    List<String> userGroups = sb.getList2("select distinct group_name from user_group");
%>



<!--my modal dialog box to search Records-->
<div class="modal fade" id="dialog" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h6 class="modal-title text-primary"><span class="fa fa-search-plus"></span> Please Select Search Option</h6>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="well well-lg">
                            <form class="form-horizontal" action="${pageContext.request.contextPath}/MultiSearcher"> 
                                <div class="thumbnail">
                                    <div class="form-group">
                                        <label class="col-md-2 col-xs-12 control-label"><strong></span> Search:</strong></label>
                                        <div class="col-md-3 col-xs-12">
                                            <label class="check"><input type="radio" name="RadioGroup1" value="Reference ID" onclick="displayDialog('Search_by_param_group');" /><strong>Reference ID</strong></label>
                                        </div>

                                        <div class="col-md-3 col-xs-12">
                                            <label class="check"><input type="radio" name="RadioGroup1" value="ALL RECORDS" onclick="displayAllRecords('searchAll')" /><strong>ALL RECORDS</strong></label>
                                        </div>
                                        <!--div class="col-md-2 col-xs-12">
                                             <input type="hidden" name="SearchType" value="Search_by_param_group"/>
                                            <input type ="hidden" name ="beg"  value = "beg" >
                                              <p id="searchByParams2"></p>
                                              <input type ="hidden" name ="responseDestination" value = "/pages/detail_1.jsp" >
                                             <input type="hidden" name="uploaded_by" value="<%=(String) session.getAttribute("username")%>">
                                             <button type="submit" class="btn btn-primary"></span>ALL</button>
                                        </div-->
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

<div class="modal fade" id="ShowAllRecords" tabindex="-1" aria-labelledby="modallabel" role="dialog">
    <div class="modal-dialog modal-lg" style="max-height: 90%; overflow-y: scroll; cursor: pointer;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h6 class="modal-title text-primary"></span>Search Records</h6>
            </div>
            <div class="modal-body">
                <div class="panel-body panel-body-table">
                    
                        <table class="table datatable">
                            <thead>
                                <tr>
                                    <th width="20%">Reference ID</th>
                                    <th width="20%">Uploaded by</th>
                                    <th width="20%">Form Description</th>
                                    <th width="20%">Date Uploaded</th>
                                    <th width="20%"></th>
                                </tr>
                            </thead>
                            <tbody>
                               
                                <%
                                    List<String[]> searchResult = (List<String[]>) session.getAttribute("searchResult");
                                    if (!searchResult.isEmpty()) {
                                        for (int k = 0; k < searchResult.size(); k++) {
                                            String ref =  searchResult.get(k)[0];
                                %>
                            
                                <tr>
                                     <form class="form-horizontal" action="${pageContext.request.contextPath}/Authorize"  id="<%=ref%>">
                                 <td><b><%=ref%></b></td>
                                <td><b><%=searchResult.get(k)[1]%></b></td>
                                <td> 
                                    <b><%=searchResult.get(k)[2]%></b>
                                    <input type ="hidden" name ="ref_id"  value = "<%=ref%>" >
                                    <input type ="hidden" name ="new_upload"  value = "new" >
                                </td>
                                <td><%=searchResult.get(k)[3].substring(0, 10)%></td>
                                <td>
                                <li><a href="#" onclick="displayDocDetails('<%=ref%>')"><span>View Details</span></a></li>
                                </td>  
                                  </tr>
                            </form>
                              <% }
                                }%>
                            </tbody>
                        </table>
                    
                </div>
            </div>
        </div>
    </div>  
</div> 

<!--my modal dialog box to search by group parameter-->
<div class="modal fade" id="Search_by_param_group" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h6 class="modal-title text-primary"><span class="fa fa-list-alt"></span> Search by group parameter</h6>
            </div>
            <div class="modal-body">
                <div class="row" id="searhparam">
                    <div class="col-md-12">
                        <div class="jumbotron">
                            <form class="form-horizontal" action="${pageContext.request.contextPath}/MultiSearcher">
                                <input type="hidden" name="SearchType" value="Search_by_param_group"/>
                                <input type ="hidden" name ="beg"  value = "beg" >
                                <p id="searchByParams2"></p>
                                <input type ="hidden" name ="responseDestination" value = "/pages/detail_1.jsp" >
                                <div class="form-group">
                                    <label class="col-md-3 col-xs-12 control-label">Reference Number:</label>
                                    <div class="col-md-6 col-xs-12">
                                        <div class="input-group">
                                            <span class="input-group-addon"><span class="fa fa-barcode"></span></span>
                                            <input type="text" class="form-control" minlength="3" name="refNumber" placeholder="Reference Number"/>
                                        </div>
                                    </div>
                                </div>




                                <!--      <div class="form-group">
                                          <label class="col-md-3 col-xs-12 control-label">Title of Agreement:</label>
                                          <div class="col-md-6 col-xs-12">
                                              <div class="input-group">
                                                  <span class="input-group-addon"><span class="fa fa-money"></span></span>
                                                  <input type="text" class="form-control" minlength="3" name="passportNumber" placeholder="Title of Agreement"/>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-md-3 col-xs-12 control-label">Transferee:</label>
                                          <div class="col-md-6 col-xs-12">
                                              <div class="input-group">
                                                  <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                  <input type="text" class="form-control" minlength="3" name="surname" placeholder="Transferee" />
                                              </div>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-md-3 col-xs-12 control-label">Address:</label>
                                          <div class="col-md-6 col-xs-12">
                                              <div class="input-group">
                                                  <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                  <input type="text" class="form-control" minlength="3" name="firstname" placeholder="Address"/>
                                              </div>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-md-3 col-xs-12 control-label">Transferor:</label>
                                          <div class="col-md-6 col-xs-12">
                                              <div class="input-group">
                                                  <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                  <input type="text" class="form-control" minlength="3" name="middlename" placeholder="Transferor" />
                                              </div>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <label class="col-md-3 col-xs-12 control-label">Date of Signing the Agreement:</label>
                                          <div class="col-md-6 col-xs-12">
                                              <div class="input-group" >
                                                  <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                                  <input type="text" class="form-control datepicker" id="dobenrol2" minlength="3" name="dob" />
                                              </div>
                                          </div>
                                      </div>
                                      
                                -->    



                                <!--  
                                  <div class="form-group">
                                      <label class="col-md-3 col-xs-12 control-label">Upload Officer:</label>
                                      <div class="col-md-6 col-xs-12">
                                          <select type="text" class="form-control select" name="uploaded_by">
                                              <option value="">Upload Officer</option>
                                          </select>
                                      </div>
                                  </div>
                                -->
                                <div class="form-group">
                                    <div class="col-md-offset-6 col-md-3 col-xs-12">
                                        <button type="submit" class="btn btn-success btn-block"><span class="fa fa-search"></span> Search</button>
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



<!--my modal dialog box for new QuitOrMore-->
<div class="modal fade" id="QuitOrMore" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> New Document Entry</h6>
            </div>
            <div class="modal-body">
                <div class="well well-lg">
                    <div class="row">
                        <div class="col-md-12">
                            <h5><strong>Successfully Uploaded! Do you want to upload another document?</strong></h5><br>

                            <% if (!"000".equalsIgnoreCase(role_id)) {  %>
                            <form action="${pageContext.request.contextPath}/ImageUpload">
                                <input type ="hidden" name ="uploadType" value ="scanner">
                                <%} else {%>
                                <form action="${pageContext.request.contextPath}/individual.jsp">
                                    <%} %>
                                    <div class="form-group">
                                        <div class="col-md-offset-3 col-md-3 col-xs-12">
                                            <button type="submit" class="btn btn-primary btn-block btn-lg"><b class="fa fa-check-circle"></b> Yes</button>
                                        </div>
                                    </div>
                                </form>
                                <% if (!"000".equalsIgnoreCase(role_id)) { %>
                                <form action = "${pageContext.request.contextPath}/pages/homepage.jsp">
                                    <%} else {%>
                                    <form action = "${pageContext.request.contextPath}/registerAs.jsp">
                                        <%}%>
                                        <div class="form-group">
                                            <div class="col-md-3 col-xs-12">
                                                <button type="submit" class="btn btn-danger btn-block btn-lg"><b class="fa fa-times-circle"></b> No</button>
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




                                    <div class="modal fade" id="editTemplate" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> Choose Template</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="well well-lg">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/ConfigureJobController">
                                                                    <input type ="hidden" name ="uploadType"  value="changePassword"> 
                                                                    <input type ="hidden" name ="control"  value="editJob">
                                                                    <!-- <div class="col-md-8 col-xs-12"> -->
                                                                    <table class="table table-bordered" align ="center">
                                                                        <tr>
                                                                            <td>
                                                                                <select type="text" class="form-control select" data-live-search="true" name="template" value="" required>
                                                                                    <option value="">Select Template</option>
                                                                                    <% for (int i = 0; i < templates.size(); i++) {%>
                                                                                    <option value="<%= templates.get(i)[0]%>"><%=templates.get(i)[1]%></option>
                                                                                    <%}%>
                                                                                </select>
                                                                            </td>
                                                                            <td> <button class="btn btn-success btn-block" id="save-password" type="submit"><b class="fa fa-save"></b>Submit</button></td>
                                                                        </tr>
                                                                    </table>    
                                                                    <!--  </div>  -->
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-md-offset-7 col-md-3">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        </form>
                                                    </div>   
                                                </div>
                                            </div>
                                        </div>
                                    </div>





                                    <div class="modal fade" id="chooseTemplate" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">

                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> Choose Template</h6>
                                                </div>

                                                <div class="modal-body">
                                                    <div class="well well-lg">
                                                        <div class="row">
                                                            <div class="col-md-12">

                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/ImageUpload">
                                                                    <input type ="hidden" name ="uploadType"  value="changePassword">
                                                                    <table class="table table-bordered" align ="center">
                                                                        <tr>
                                                                            <td>
                                                                                <select type="text" class="form-control select" data-live-search="true" name="template" value="" required>
                                                                                    <option value="">Select Template</option>
                                                                                    <% for (int i = 0; i < templates.size(); i++) {%>
                                                                                    <option value="<%= templates.get(i)[0]%>"><%=templates.get(i)[1]%></option>
                                                                                    <%}%>
                                                                                </select>

                                                                            </td> 

                                                                            <td>

                                                                                <button class="btn btn-success btn-block" id="save-password" type="submit">Submit</button>

                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                            </div>

                                                        </div>

                                                        </form>
                                                    </div>   
                                                </div>
                                            </div>
                                        </div>
                                    </div>



                                    <div class="modal fade" id="workflowConfig" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> Choose Template</h6>
                                                </div>

                                                <div class="modal-body">
                                                    <div class="well well-lg">
                                                        <div class="row">
                                                            <div class="col-md-12">

                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/Authorize">
                                                                    <input type ="hidden" name ="workflowDefine"  value="workflowDefine">
                                                                    <table class="table table-bordered" align ="center">
                                                                        <tr>
                                                                            <td>
                                                                                <select type="text" class="form-control select" data-live-search="true" name="template" value="" required>
                                                                                    <option value="">Select Template</option>
                                                                                    <% for (int i = 0; i < templates.size(); i++) {%>
                                                                                    <option value="<%= templates.get(i)[0]%>"><%=templates.get(i)[1]%></option>
                                                                                    <%}%>
                                                                                </select>
                                                                            </td> 
                                                                            <td>
                                                                                <button class="btn btn-success btn-block" id="save-password" type="submit">Submit</button>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                            </div>
                                                        </div>
                                                        </form>
                                                    </div>   
                                                </div>
                                            </div>
                                        </div>
                                    </div>





                                    <!--my modal dialog box to change password-->
                                    <div class="modal fade" id="ChangePassword" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/CreateUser">
                                                    <input type ="hidden" name ="changePassword"  value="changePassword">
                                                    <div class="modal-header">
                                                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                        <h6 class="modal-title text-primary" id="modallabel2"><span class="fa fa-pencil-square"></span> CHANGE PASSWORD</h6>
                                                    </div>
                                                    <div class="modal-body" id="modal-result">
                                                        <div class="form-group">
                                                            <label for="old-password" class="col-md-4 control-label">Old Password:</label>
                                                            <div class="col-md-6">
                                                                <input type="password" class="form-control" name ="old password" id="old-password" placeholder="Enter Old Password" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="new-password" class="col-md-4 control-label">New Password:</label>
                                                            <div class="col-md-6">
                                                                <input type="password" class="form-control" name ="new password" id="new-password" placeholder="Enter New Password" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="confirm-password" class="col-md-4 control-label">Confirm New Password:</label>
                                                            <div class="col-md-6" id="conpass">
                                                                <input type="password" class="form-control" name ="new password confirm" id="confirm-password" placeholder="Confirm New Password" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <div class="col-md-offset-7 col-md-3">
                                                                <button class="btn btn-success btn-block" id="save-password" type="submit"><b class="fa fa-save"></b> Save</button>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </form>
                                            </div>
                                        </div>
                                    </div>



                                    <!--my modal dialog box for General search-->
                                    <div class="modal fade" id="General_search" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-search-plus"></span> General Search</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row" id="namesearch">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/MultiSearcher">
                                                                    <input type="hidden" class="inputtext" name="SearchLocation" value="enrolment_search"/>
                                                                    <input type="hidden" class="inputtext" name="SearchType" value="General_search"/>
                                                                    <input type ="hidden" name ="responseDestination"  value ="/pages/detail_1.jsp" >
                                                                    <p id="generalsearch"></p>
                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label"><strong>Name:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><span class="fa fa-male"></span></span>
                                                                                <input type="text" class="form-control" minlength="3" name="name" value="" required placeholder="Enter name please" />
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
                                                                            <button type="submit" class="btn btn-success btn-block"><b class="fa fa-search"></b> Search</button>
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



                                    <!--my modal dialog box for Record update-->
                                    <div class="modal fade" id="update" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-random"></span> Record Update</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/MultiSearcher">
                                                                    <input type="hidden" class="inputtext" name="update" value="update"/>
                                                                    <p id="generalsearch"></p>
                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label"><strong> Passport Number:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><span class="fa fa-money"></span></span>
                                                                                <input type="text" maxlength="10" class="form-control" placeholder="Passport Number" name="passportNumber" value="" required/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
                                                                            <button type="submit" class="btn btn-success btn-block"><b class="fa fa-send-o"></b> Submit</button>
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


                                    <!--my modal dialog box for Renewal -->
                                    <div class="modal fade" id="doRenewal" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-random"></span> Renewal Form</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/ImageUpload">
                                                                    <input type="hidden" class="inputtext" name="renewal" value="yes"/>
                                                                    <p id="generalsearch"></p>
                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label"><strong> Old Passport Number:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><span class="fa fa-money"></span></span>
                                                                                <input type="text" class="form-control" placeholder="Old Passport Number" maxlength="10" name="passportNumber" required/>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
                                                                            <button type="submit" class="btn btn-success btn-block"><b class="fa fa-send-o"></b> Submit</button>
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




                                    <!--my modal dialog box to Authorize Records-->
                                    <div class="modal fade" id="Authorize" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-check-square-o"></span> Authorize Records</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/Authorize">
                                                                    <input type="hidden" class="inputtext" name="update" value="update"/>
                                                                    <p id="generalsearch"></p>
                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label"><strong> Authorization Type:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <select class="form-control select"   name="AuthorizeType"  required>
                                                                                <option>Choose Authorization Type</option>
                                                                                <option value="new">NEW</option>
                                                                                <option value="update">UPDATED</option>
                                                                                <option value="renewal">RENEWAL</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
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



                                    <!--my modal dialog box to create users-->
                                    <div class="modal fade" id="user_creation" tabindex="-1"  aria-labelledby="modallabel" role="dialog" onsubmit="return validateUserCreation();">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-male"></span> User Creation Module </h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <form class="form-horizontal" action="${pageContext.request.contextPath}/CreateUser" method="post">
                                                                <div class="panel panel-default">
                                                                    <div class="panel-heading">
                                                                        <h3 class="panel-title"><span class="fa fa-users"></span> <strong>Create New Users</strong></h3>
                                                                        <ul class="panel-controls" style="margin-top: 2px;">
                                                                            <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                                                                        </ul>
                                                                    </div>
                                                                    <div class="panel-body">
                                                                        <p class="text-warning"><strong><span class="fa fa-exclamation-circle"></span> Please fill in all necessary details for the user before the form can be submitted. </strong></p>
                                                                        <hr>
                                                                    </div>
                                                                    <div class="panel-body">
                                                                        <div class="row">
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">User ID:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-addon"><span class="fa fa-qrcode"></span></span>
                                                                                            <input type="text" class="form-control" id="userNameCu" autocomplete="off" name="id" required onChange="toUppercase('userNameCu')" placeholder="Enter User ID"/>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">Surname:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                                                            <input type="text" class="form-control" id="lastNameCu" autocomplete="off" name="lastName"  onChange="toUppercase('lastNameCu')" required placeholder="Surname" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">Location:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <select type="text" class="form-control select" data-live-search="true" name="location" required>
                                                                                            <option value="">Select Location</option>
                                                                                            <% for (int i = 0; i < locss.size(); i++) {%>
                                                                                            <option value="<%= locss.get(i)[0]%>"><%=locss.get(i)[1]%></option>
                                                                                            <%}%>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">Gender:</label>
                                                                                    <div class="col-md-4 col-xs-6">
                                                                                        <label class="check"><input type="radio" class="icheckbox" name="gender" value="M" /> Male</label>
                                                                                    </div>
                                                                                    <div class="col-md-4 col-xs-6">
                                                                                        <label class="check"><input type="radio" class="icheckbox" name="gender" value="F"/> Female</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">First Name:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                                                            <input type="text" class="form-control" id="firstNameCu" autocomplete="off" name="firstName" value="" required onChange="toUppercase('firstNameCu');" placeholder="First Name"/>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">Middle Name:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <div class="input-group">
                                                                                            <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                                                                            <input type="text" class="form-control" id="lastNameCu" autocomplete="off" name="middleName" value="" onChange="toUppercase('lastNameCu');" placeholder="Middle Name" />
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">Authorizer:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <select type="text" class="form-control select" name="authorizer" required>
                                                                                            <option value="">Select Authorizer</option>
                                                                                            <%  List<String> authorizers = sb.getList2("select user_id from fas_mst_users where user_role_id ='002'");
                                                                                                for (int i = 0; i < authorizers.size(); i++) {
                                                                                            %>
                                                                                            <option value="<%=authorizers.get(i)%>"><%= authorizers.get(i)%></option>
                                                                                            <%}%>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="form-group">
                                                                                    <label class="col-md-3 col-xs-12 control-label">User Role:</label>
                                                                                    <div class="col-md-8 col-xs-12">
                                                                                        <select type="text" class="form-control select" name="roleId" required>
                                                                                            <option value="">Select Role</option>
                                                                                            <%  List<String[]> rols = sb.getList3("select role_id, role_desc from fas_mst_role");
                                                                                                for (int i = 0; i < rols.size(); i++) {
                                                                                            %>
                                                                                            <option value="<%= rols.get(i)[0]%>"><%=rols.get(i)[1]%></option>
                                                                                            <%}%>
                                                                                        </select>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <br>
                                                                        <div class="well well-sm">
                                                                            <div class="text-success"><strong><span class="fa fa-exclamation-circle"></span> Kindly input a secure password and validate.</strong></div>
                                                                            <br />
                                                                            <div class="row">
                                                                                <div class="col-md-6">
                                                                                    <div class="form-group">
                                                                                        <label class="col-md-3 col-xs-12 control-label">Password:</label>
                                                                                        <div class="col-md-8 col-xs-12">
                                                                                            <div class="input-group">
                                                                                                <span class="input-group-addon"><span class="fa fa-unlock-alt"></span></span>
                                                                                                <input type="password" class="form-control" id="password" name="password" required placeholder="Password"/>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                    <div class="form-group">
                                                                                        <label class="col-md-4 col-xs-12 control-label">Confirm Password:</label>
                                                                                        <div class="col-md-8 col-xs-12">
                                                                                            <div class="input-group">
                                                                                                <span class="input-group-addon"><span class="fa fa-key"></span></span>
                                                                                                <input type="password" class="form-control" placeholder="Confirm Password" />
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="panel-footer" id="buttonsubmit">
                                                                        <button type="reset" class="btn btn-default"><span class="fa fa-refresh"></span> Clear Form</button>
                                                                        <button type="submit" class="btn btn-success pull-right"><span class="fa fa-male"></span><span class="fa fa-plus-circle"></span> Create User</button>
                                                                    </div>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>   

                                    <!--<div id="dailyDetailPerLocation" class="ui-dialog" title="Daily upload detail per Location" style=" display:none;">
                                        <div style="padding-left: 30px;">
                                            <form action="${pageContext.request.contextPath}/Statistic">
                                                <input type="hidden" class="inputtext" name="reportType" value="dailyDetailperLocation"/>
                                                <p id="generalsearch"></p>
                                                <table class="table">
                                                    <td>Location:</td>
                                                    <td>
                                                        <select type="text" class="inputtext" name="location" required>
                                                            <option value="">Select Location</option>
                                    /**
                                                     
                                                            <select/>
                                                    </td></table>
                                                <input type="submit" value="submit"/>
                                            </form>
                                        </div>
                                    </div>-->

                                    <!--my modal dialog box for Record update-->
                                    <div class="modal fade" id="dailyDetailPerLocation" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-list-alt"></span> Daily upload detail per location</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/Statistic">
                                                                    <input type="hidden" class="inputtext" name="reportType" value="dailyDetailperLocation"/>
                                                                    <p id="generalsearch"></p>
                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label"><strong> Location:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <select class="form-control select" name="location" required>
                                                                                <option>-- Select Location --</option>
                                                                                <%  List<String[]> locs
                                                                                            = sb.getList3("select distinct loc_code, loc_desc from fas_mst_location");
                                                                                    for (int i = 0; i < locs.size(); i++) {
                                                                                %>
                                                                                <option value="<%= locs.get(i)[0]%>"><%=locs.get(i)[1]%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
                                                                            <button type="submit" class="btn btn-success btn-block"><b class="fa fa-send-o"></b> Submit</button>
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

                                    <div class="modal fade" id="CreateLocation" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h4 class="modal-title text-primary"><span class="fa fa-map-marker"></span> CREATE NEW LOCATION</h4>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form action="${pageContext.request.contextPath}/CreateLocation" class="form-horizontal">
                                                                    <div class="form-group">
                                                                        <label class="col-md-4 col-xs-12 control-label">Location Description:</label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                                                <input type="text" class="form-control" placeholder="Description" id="lastNameCu" autocomplete="off" name="loc_desc" value="" onChange="toUppercase('lastNameCu')"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label class="col-md-4 col-xs-12 control-label">Location Code:</label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group">
                                                                                <span class="input-group-addon"><span class="fa fa-lock"></span></span>
                                                                                <input type="text" class="form-control" placeholder="Location Code" id="firstNameCu" autocomplete="off" name="loc_code" value="" required onChange="toUppercase('firstNameCu')"/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <div class="col-md-offset-7 col-md-3">
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



                                    <div id="filteReport" class="ui-dialog" title="Filter Report" style="display:none;">
                                        <form action ="${pageContext.request.contextPath}/Statistic">
                                            <input type="hidden" class="inputtext" name="reportType"value="filterByRange"/>
                                            <div style="padding-left: 30px;">
                                                <table class="table">
                                                    <tr>
                                                        <td>
                                                            Start Date :<input readonly="true" class="inputtext" type="text" name="start_date" id="start_en_date"/>
                                                        </td>
                                                        <td>
                                                            End Date : <input readonly="true" class="inputtext" type="text" name="end_date" id="end_en_date"/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>Location:</td>
                                                        <td>
                                                            <select type="text" class="inputtext" name="location" required>
                                                                <option value="all">All Locations</option>
                                                                <%
                                                                    for (int i = 0; i < locss.size(); i++) {
                                                                %>
                                                                <option value="<%= locss.get(i)[0]%>"><%=locss.get(i)[1]%></option>
                                                                <%}%>
                                                                <select/>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <input class="inputtext" type="hidden" name="rangeFilter" value ="rangeFilter"/>
                                                            <input type="submit" class ="submitlink" value="Submit" style="padding: 5px;"/>
                                                        </td>
                                                        </form>
                                                    </tr>
                                                </table>
                                            </div>
                                    </div>
                                    <%

                                    %>


                                    <!--my modal dialog box for edit user -->
                                    <div class="modal fade" id="EditUser" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-user-md"></span> Edit User</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="row">
                                                        <div class="col-md-12">
                                                            <div class="well well-lg">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/CreateUser">
                                                                    <div class="form-group">   <input type="hidden" class="inputtext" name="editUser" value="yes"/>
                                                                        <label class="col-md-2 col-xs-12 control-label"><strong>  User Id:</strong></label>
                                                                        <div class="col-md-7 col-xs-12">
                                                                            <select type="text" class="form-control select" name="userId" required>
                                                                                <% for (int i = 0; i < usersForEdit.size(); i++) {%>
                                                                                <option value="<%= usersForEdit.get(i)[0]%>"><%= usersForEdit.get(i)[0]%> <%= usersForEdit.get(i)[1]%>  <%= usersForEdit.get(i)[2]%></option>
                                                                                <%}%>
                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
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



                                    <div class="modal fade" id="filteReportByUser" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-list-alt"></span>User Report By Count</h6>
                                                </div>
                                                <div class="modal-body"> 
                                                    <div class="row"> 
                                                        <div class="col-md-12"> 
                                                            <div class="well well-lg"> 
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/Statistic">
                                                                    <input type="hidden" class="inputtext" name="reportType" value="filterByUsers"/>






                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label">Start Date:</label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group" >
                                                                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input class="form-control datepicker" type="text" name="start_date"   required/>
                                                                            </div>
                                                                        </div>
                                                                    </div>


                                                                    <div class="form-group">
                                                                        <label class="col-md-3 col-xs-12 control-label">End Date:</label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <div class="input-group" >
                                                                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                                                                <input class="form-control datepicker" type="text" name="end_date"  required/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="form-group">				

                                                                        <label class="col-md-3 col-xs-12 control-label"><strong> Users:</strong></label>
                                                                        <div class="col-md-6 col-xs-12">
                                                                            <select class="form-control select" name="usersupload" required>

                                                                                <option value="USERSID">All USERS</option>

                                                                                <%
                                                                                    for (int i = 0; i < UsersbyLoc.size(); i++) {
                                                                                %>
                                                                                <option value="<%= UsersbyLoc.get(i)[0]%>"><%=UsersbyLoc.get(i)[1]%></option>
                                                                                <%}%>

                                                                            </select>
                                                                        </div>
                                                                        <div class="col-md-3 col-xs-12">
                                                                            <button type="submit" class="btn btn-success btn-block"> <b class="fa fa-send-o"></b> Submit</button>
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

                                    <div class="modal fade" id="ShowDocument" tabindex="-1" aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog modal-lg" style="max-height: 90%; overflow-y: scroll; cursor: pointer;">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"></span> Display Document</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div id="doc_content">

                                                    </div> 
                                                </div>
                                            </div>
                                        </div>  
                                    </div>                                                                 


                                    <div class="modal fade" id="CreateModifyUserGroup" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> Create or Modify User Group </h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="well well-lg">
                                                        <div class="row">
                                                            <div class="col-md-12" id="select_task">
                                                                <form action="${pageContext.request.contextPath}/ConfigureJobController" >
                                                                    <input type="hidden" name ="control" value ="createUserGroup"/> 
                                                                    <table class="table table-bordered" align ="center">
                                                                        <tr>
                                                                            <td>
                                                                                <select type="text" class="form-control select" data-live-search="true" name="modCreate" id="modCreate" value="" required onchange="CreateModifyUserGroup('modCreate')"/>
                                                                        <option value="Create">Create User Group</option>
                                                                        <option value="Modify">Modify User Group</option>
                                                                        </select>
                                                                        </td>
                                                                        <td> <button class="btn btn-success btn-block" id="createModifyUserGroup" onclick="">Submit</button></td>
                                                                        </tr>
                                                                    </table> 
                                                                </form>
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-md-offset-7 col-md-3">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>   
                                                </div>
                                            </div>
                                        </div>
                                    </div>                                              

                                    <div class="modal fade" id="ModiyUserGroup" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                    <h6 class="modal-title text-primary"><span class="fa fa-upload"></span> Choose User Group</h6>
                                                </div>
                                                <div class="modal-body">
                                                    <div class="well well-lg">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <form class="form-horizontal" action="${pageContext.request.contextPath}/ConfigureJobController">
                                                                    <input type ="hidden" name ="control"  value="modifyUserGroup"> 
                                                                    <table class="table table-bordered" align ="center">
                                                                        <tr>
                                                                            <td>
                                                                                <select type="text" class="form-control select" data-live-search="true" name="userGroup" value="" required>
                                                                                    <option value="">Select User Group</option>
                                                                                    <% for (int i = 0; i < userGroups.size(); i++) {%>
                                                                                    <option value="<%= userGroups.get(i)%>"><%=userGroups.get(i)%></option>
                                                                                    <%}%>
                                                                                </select>
                                                                            </td>
                                                                            <td> <button class="btn btn-success btn-block" id="save-password" type="submit"><b class="fa fa-save"></b>Submit</button></td>
                                                                        </tr>
                                                                    </table>    
                                                                    <!--  </div>  -->
                                                            </div>
                                                            <div class="form-group">
                                                                <div class="col-md-offset-7 col-md-3">
                                                                </div>
                                                            </div>
                                                        </div>

                                                        </form>
                                                    </div>   
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Modal Testing  -->
                                    <div  class="modal fade"  id="myModal"       tabindex="-1" role="dialog" aria-labelledby="modallabel">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h3 id="myModalLabel">Modal header</h3>
                                        </div>
                                        <div class="modal-body">
                                            <div id="datetimepicker1" class="input-append date">
                                                <input data-format="dd/MM/yyyy hh:mm:ss" type="text"></input>
                                                <span class="add-on"><i data-time-icon="icon-time" data-date-icon="icon-calendar"></i></span>
                                            </div>
                                        </div>

                                    </div>



                                    <script>
                                        function CreateModifyUserGroup(id) {
                                            var task = document.getElementById(id).value;
                                            if (task === 'Modify') {
                                                displayDialog('ModiyUserGroup');
                                            }
                                        }
                                    </script>                          


                                    <script>
                                        $(function () {
                                            $("#datetimepicker1").datepicker();
                                        });
                                    </script>
                                    <script src="${pageContext.request.contextPath}/resources/javaScript/jquery-ui-1.10.3.custom.js"></script>