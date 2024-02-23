
<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">

<html>
    <head>
        <title>Detail Update</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
           
        </head>
        
        
    
        <body id="background">
               
        <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>
                    <!-- START BREADCRUMB -->
                    <ul class="breadcrumb">
                        <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                    <li><a href="#">Upload Operations</a></li>
                    <li><a href="#">Update Record</a></li>
                    <li class="active">Confirm Record </li>  
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
                    String category = "";
                    String country = "";
                    String applicationId;
                    String offset = null;
                    List<String> imageList;  
                    List<String> imageUpdate;
                    String[] values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                    String comment;
                    String mar_status;
                    String enrolNo;
                    String title;
                    LoaderVo lv;
                    SaveToDb sb = new SaveToDb();
                   // List<String[]> authHistory;
                   
                %>



                <%  
                   
                    values = (String[]) session.getAttribute("values");
                    applicationId = (String) session.getAttribute("applicationId");
                    lv = (LoaderVo) session.getAttribute("valueHolder");
                    imageList = (List<String>) session.getAttribute("documents");
                    imageUpdate =  (List<String>)session.getAttribute("documentUpdates");
                    passportNumber = values[0];
                    surname = values[1];
                    firstname = values[2];
                    middlename = values[3];
                    state = values[4];
                    dob = values[5];
                    sex = values[6];
                    country = values[7];
                    comment = values[10];
                    category = values[12];
                    mar_status = values[13];
                    enrolNo = values[14];
                    title = values[15];
                    //authHistory = sb.getListss("select auth_id, action, comments from fas_mst_user_authorization where ref_id = '" + applicationId + "'", 3);
                     
                %>
                
                <!-- new edit form -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
    <div class="row">
        <div class="col-md-offset-1 col-md-10">

            
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span class="fa fa-edit"></span> <strong>Edit Document</strong></h3>
                        <ul class="panel-controls" style="margin-top: 2px;">
                            <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                            <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-10">
                                <p class="text-primary"><span class="fa fa-circle"></span> Edit and save document details here.</p>
                            </div>
                        </div>
                        <form action ="${pageContext.request.contextPath}/pages/scan_job.html" target="_blank">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="tile tile-warning tile-valign">
                                        <button class="btn-block btn-success" type="submit"><span class="glyphicon glyphicon-print"></span></button>
                                    </div>
                                </div>
                              
                            </div>
                        </form>
                        <hr>
                        <form class="form-horizontal" action="" method="post">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Reference ID:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=applicationId%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Name:</label>
                            <div class="col-md-3 col-xs-6">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=category%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" class="form-control select" name="CATEGORY" value="<%=lv.getCategory()%>" id="category" onchange="renderElseWhere9('category', 'loghc')">
                                      
                            </div>
                        </div>
                                
                          <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Position in Company:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=enrolNo%></h4>
                                    </label>
                                </div>
                            </div>       
                               <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-barcode"></span></span>
                                    <input type="text" class="form-control" placeholder="Position in Company" name="enrolNo" value="<%=lv.getEnrolNo()%>" id="enrolNo" onchange="renderElseWhere11('enrolNo', 'loghc')"/>
                                </div>
                            </div>
                        </div>  
                                    
                              <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Citizen Of:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=country%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Citizen Of" name="country" value="<%=lv.getCountry()%>" id="country" onchange="renderElseWhere8('country', 'loghc')" />
                                </div>
                            </div>
                        </div>       
                                    
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Title of the Agreement:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=passportNumber%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-money"></span></span>
                                    <input type="text" maxlength="10" class="form-control" placeholder="Title of the Agreement" name="passportNumber" value="<%=lv.getPassNo()%>" id="passportNumber" onchange="renderElseWhere('passportNumber', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                       
                                 <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Transferee:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=surname%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Transferee:" name="surname" value="<%=lv.getSurname()%>" id="surname" onchange="renderElseWhere1('surname', 'loghc')" />
                                </div>
                            </div>
                        </div>
                                
                           <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Address:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=firstname%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control"  placeholder="Address" name="firstname" value="<%=lv.getFirstname()%>" id="firstname" onchange="renderElseWhere2('firstname', 'loghc')" />
                                </div>
                            </div>
                        </div>   
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Transferor:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=middlename%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Transferor" name="middlename" value="<%=lv.getMiddlename()%>" id="middlename" onchange="renderElseWhere3('middlename', 'loghc')"/>
                                </div>
                            </div>
                        </div>        
                        
                                <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Address:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=title%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Address" name="title" value="<%=lv.getTitle()%>" id="title" onchange="renderElseWhere12('title', 'loghc')" />
                                </div>
                            </div>
                        </div>
                           
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Date of Signing the Agreement:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=dob%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group" >
                                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                    <input type="text" class="form-control datepicker" placeholder="DD-MM-YYYY"  name="dob" value="<%=lv.getDob()%>" id="dob" onchange="renderElseWhere4('dob', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Effective date of Agreement:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    
                                   <h4 class=""><%=mar_status%></h4>
                                    <label class="control-label">
                                      
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control datepicker" placeholder="DD-MM-YYYY" name="mar_status" value="<%=lv.getMarital_status()%>" id="mar_status" onchange="renderElseWhere10('mar_status', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                        
                                 <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Expiry date of Agreement:</label>
                            <div class="col-md-3 col-xs-6">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=sex%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-6">
                                 <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control datepicker" placeholder="DD-MM-YYYY" name="sex" value="<%=lv.getSex()%>" id="sex" onchange="renderElseWhere10('mar_status', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                                    
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Line of Bussiness:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=state%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Line of Bussiness" name="state" value="<%=lv.getState()%>" id="state" onchange="renderElseWhere5('state', 'loghc')" />
                                </div>
                            </div>
                        </div>
                       
                       
                        <p id="loghc" style="height: 10px;display: none;"> </p>
                      
                     
                   <!--     <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Comment:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <textarea class="form-control" rows="3" name="comment" value="" id="" onchange="renderElseWhere9('docDesc', 'loghc')" required placeholder="Comment goes here" ><%= comment%></textarea>
                            </div>
                        </div>
                    -->        
                       <br>
                        </form>
                        
                            
                            
                        
             
                                
                                
                                
                            </table>   
                            
                            
                            
                            
                            
                            
                         <%
                            List<LoaderVo> l = sb.getLoaderList(applicationId);
                             List<String> docu = new ArrayList<String>();
                            for (int k = 0; k < l.size(); k++) {
                                doc_type = l.get(k).getType();
                                doc_id = l.get(k).getDoc_id();
                                docu.add(doc_type);
                        %>
                     
                        <div class="thumbnail">
                            <div class="row">
                              <div class="col-md-12">
                                <div class="form-group">
                                <label class="col-md-2 col-xs-6 control-label"><%= doc_type%></label>
                                    <form class="form-horizontal" action ="${pageContext.request.contextPath}/PDFLoader" target="_blank">
                                        <input type ="hidden" name ="view"  value = "<%= doc_id%>">
                                        <div class="col-md-offset-1 col-md-4 col-xs-6">
                                            <button class="btn btn-primary btn-block" type="submit"><span class="fa fa-file"></span> View Document</button>
                                        </div>
                                    </form>
                                    <div class="col-md-4 col-xs-6">
                                        <form action ="${pageContext.request.contextPath}/ImageUpload" >
                                            <input type ="hidden" name ="delete"  value ="delete2">
                                            <input type ="hidden" name ="to_correct"  value ="newJob">
                                            <input type ="hidden" name ="document_type"  value ="<%=doc_type%>">
                                            <button class="btn btn-danger btn-block" type="submit"><span class="fa fa-trash-o"></span> Delete</button>
                                        </form>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        
                        
                             <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
                            <div class="col-md-6 col-xs-12">
                                
                            </div>
			</div> 
                        
                        
                        
                      
                        <form class="form-horizontal" action ="${pageContext.request.contextPath}/CorrectSTATE" method ="post" enctype="multipart/form-data">
                        <div class="bg-primary"><b> <span class="fa fa-file-archive-o"></span> Uploaded Files</b></div><br>
                        <div class="thumbnail">
                            <div class="form-group">
                                <div class="col-md-4 col-xs-12">
                                   <select type="text" class="form-control select" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" required>
                                     <option value="">Choose Document</option>   
                                           <% if (!imageList.contains("Tax")) {%>
                            <option value="Tax">Tax Payer Identification Number (TIN)</option>
                            <% }
                                if (!imageList.contains("Evidence_Tax")) {%>
                            <option value="Evidence_Tax">Evidence of Tax payments (Company tax) for the last 3 years</option>
                            <%}
                                if (!imageList.contains("Certificate of incorporation")) {%>
                            <option value="Cert_inco">Certificate of incorporation (for new companies)</option>
                            <%}
                                if (!imageList.contains("Annual_audit")) {%>
                            <option value="Annual_audit">Annual audited accounts for 3 years</option>
                            <%}
                                if (!imageList.contains("Transferor_Technical")) {%>
                            <option value="Transferor/Technical">Profile on Transferor/Technical Partner</option>
                            <%}%>
				   </select>
                                </div>
                                <div class="col-md-4 col-xs-12">
                                    <input type="file" class="fileinput btn-default btn-block" name ="file0" required title="Choose File From Disk"/>
                                </div>
                                <div class="col-md-4 col-xs-6">
                                    <button class="btn btn-warning btn-block" type="submit"><span class="fa fa-cloud-upload"></span> Upload Document</button>
                                </div>
                            </div>
                        </div>
                        </form>
                        
                        
                        <div class="well well-sm">
                            <form class="form-horizontal" action ="${pageContext.request.contextPath}/UpdateHandler">
                            <input type ="hidden" name ="correct_confirm"  value = "confirm" />
                            <div class="form-group">
                                <div class="col-md-offset-7 col-md-4 col-xs-12">
                                    <button class="btn btn-success btn-block"><span class="fa fa-check-square"></span> Confirm</button>
                                </div>
                            </div>
                           </form>
                        </div>
                            
                            
                            
                                <br> <br> 
                         Authorization History   
          
              <div class="well well-sm">  
                  <table class="table table-bordered table-striped">
                     <%
                   List<String[]> history = sb.getListss("select comments, action, user_id from fas_action_flow where ref_id = '" + applicationId + "'", 3);
            if (!history.isEmpty()) {
                   for (int his = 0; his < history.size(); his++) {
                %>
                <tr class="h4">
               <td><span class="h5"><%= history.get(his)[0]%></span></td>
               <td><span class="h5"><%= history.get(his)[1]%></span></td>
               <td><span class="h5"><%= history.get(his)[2]%></span></td>
            </tr>
             <%}}%>      
                         </table>       
                            
              </div>              
                    </div>
                </div>
        </div>
    </div>
</div>
<!-- END PAGE CONTENT WRAPPER -->
<!-- end of new edit form -->
                
                    


                        <script>
                            function renderElseWhere(id, loc) {
                                var pNumber = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?passportNumber=' + pNumber + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere1(id, loc) {
                                var surname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?surname=' + surname + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere2(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?firstname=' + firstname + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere3(id, loc) {
                                var middlename = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?middlename=' + middlename + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere4(id, loc) {
                                var dob = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?dob=' + dob + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere5(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?state=' + firstname + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>


                        <script>
                            function renderElseWhere6(id, loc) {
                                var jobType = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&passportNumber=<%=passportNumber%>&imageupdate=imageselect&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere7(id, loc) {
                                var sex = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?sex=' + sex + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere8(id, loc) {
                                var country = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?country=' + country + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere9(id, loc) {
                                var category = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?category=' + category + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>
                        
                        <script>
                            function renderElseWhere10(id, loc) {
                                var mar_status = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?mar_status=' + mar_status + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>
                        
                        <script>
                            function renderElseWhere11(id, loc) {
                                var enrolNo = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?enrolNo=' + enrolNo + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>
                        <script>
                            function renderElseWhere12(id, loc) {
                                var title = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?title=' + title + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>
                        <script>
                            $(function() {
                                $("#onrp_dob").datepicker({maxDate: "+0M +0D", changeMonth: true, dateFormat: "yy-mm-dd",
                                    changeYear: true, buttonImage: "/resources/images/icons/calendar.gif", buttonImageOnly: true});
                            });
                        </script>
                   </div>
                  </div>                 
                </div>
            </div>         
    </body>
</html>