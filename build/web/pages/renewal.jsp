<%@page import="com.fasyl.newjobBo.PageUtil"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
          <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload New Job</title>
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
                <li><a href="#">Upload Operations</a></li>
                <li class="active">Do Renewal</li>
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
                    String country = "";
                    String offset = null;
                    String enrolNo = "";
                    String nextDocument = "";
                    List<String> imageList;
                    List<String> countryList;
                    List<String> stateList;
                    String ref_id;
                    boolean isdocAvailable;
                    String category = "";
                    String docDesc = "";
                    String newPass_no = "";
                    String title;
                %>



                <%
                    ref_id = (String)session.getAttribute("applicationId");
                    stateList = (List<String>) session.getAttribute("stateList");
                    imageList = (List<String>) request.getAttribute("documents");
                    countryList = (List<String>) session.getAttribute("countryList");
                    
                    if (nextDocument == "") {
                       nextDocument = "PASSPORT DATA PAGE";
                    } else {
                        nextDocument = (String)request.getAttribute("nextDocument");
                    }
                   
                    if (imageList == null) {
                        imageList = new ArrayList<String>();
                    }
                    if ((String) request.getAttribute("offset") != null) {
                        passportNumber = (String) request.getAttribute("passportNumber");
                        surname = (String) request.getAttribute("surname");
                        firstname = (String) request.getAttribute("firstname");
                        middlename = (String) request.getAttribute("middlename");
                        state = (String) request.getAttribute("state");
                        sex = (String) request.getAttribute("sex");
                        category = (String) request.getAttribute("category");
                        enrolNo = (String) request.getAttribute("enrolNo");
                        title = (String) request.getAttribute("title");
                        country = (String) request.getAttribute("country");
                        newPass_no = (String) request.getAttribute("newPass_no");
                        dob = (String) request.getAttribute("dob");
                        docDesc = (String) request.getAttribute("docDesc");
                        if (docDesc == null) {
                          docDesc = "";  
                        }
                         if (newPass_no == null) {
                          newPass_no = "";  
                        }
                    }
                    if ((String) request.getAttribute("start") != null) {
                        passportNumber = "";
                        surname = "";
                        firstname = "";
                        middlename = "";
                        state = "";
                        dob = "";
                        country = "";
                        sex = "";
                        category = "";
                        newPass_no = "";
                        enrolNo = "";
                        title = "";
                    }

                %>
                
                <!-- new form -->
<!-- PAGE CONTENT WRAPPER -->
<div class="page-content-wrap">
    <div class="row">
        <div class="col-md-offset-2 col-md-8">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title"><span class="glyphicon glyphicon-print"></span> <strong>Scan New Job</strong></h3>
                        <ul class="panel-controls" style="margin-top: 2px;">
                            <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                            <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <form  class="form-horizontal" action ="${pageContext.request.contextPath}/pages/scan_job.jsp" target="_blank">
                            <div class="row">
                                <div class="col-md-2">
                                    <div class="tile tile-warning tile-valign">
                                        <Button class="btn-block btn-success" type="submit"><span class="glyphicon glyphicon-print"></span></Button>
                                    </div>
                                </div>
                                <div class="col-md-10">
                                    <p class="text-primary h3"><span class="fa fa-arrow-circle-left"></span> Please Click scan button to upload document from scanner.</p>
                                    <div class="help-block"><span class="fa fa-bolt"> Please connect the system to the Scanner</span></div>
                                </div>
                            </div>
                        </form>
                        <hr>
                        <form class="form-horizontal" action ="${pageContext.request.contextPath}/ImageUpload" method ="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Reference ID:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-danger"><i class="fa fa-qrcode"></i> <%= ref_id%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                           <label class="col-md-3 col-xs-12 control-label">New Passport Number:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-money"></span></span>
                                    <input type="text" class="form-control" placeholder="New Passport Number" maxlength="10" name="newPass_no" value="<%=newPass_no%>" id="newPass_no" onchange="renderElseWhere('newPass_no', 'loghc')" required/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Category:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-certificate"></i> <%=category%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Old Passport Number:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-money"></i> <%=passportNumber%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>            
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Enrollment Number:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-danger"><i class="fa fa-barcode"></i> <%=enrolNo%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Title:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-user"></i> <%=title%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Surname:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-user"></i> <%=surname%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">First Name:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-user"></i> <%=firstname%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Middle Name:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-user"></i> <%=middlename%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Date of Birth:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-calendar"></i> <%=dob%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Country of Birth:</label>
                            <div class="col-md-6 col-xs-12">
                               <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-flag-o"></i> <%=country%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">State of Origin:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-flag-o"></i> <%=state%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Sex:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class="text-primary"><i class="fa fa-female"></i> <%=sex%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                           <label class="col-md-3 col-xs-12 control-label">Document Description:</label>
                            <div class="col-md-6 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-file-pdf-o"></span></span>
                                    <input type="text" class="form-control" placeholder="Input Document Description" name="docDesc" value="" id="docDesc" onchange="renderElseWhere1('docDesc', 'loghc');" required/>
                                </div>
                            </div>
                        </div>
                        <% if (docDesc == "") { %>       
                        <div class="well well-sm">
                           <div class="text-primary h5"><span class="fa fa-cloud-upload"></span> File Upload</div>
                            <div class="form-group">
                                <label class="col-md-3 col-xs-12 control-label">File Section:</label>
                                <div class="col-md-3 col-xs-12">
                                    <input type="file" class="fileinput btn-default" name ="file0" title="Choose File From Disk" required/>
                                </div>
                                <div class="col-md-3 col-xs-12">
                                    <button type="submit" class="btn btn-success"><span class="fa fa-upload"></span> Upload Document</button>
                                </div>
                            </div>
                        </div>
                        <%}%> 
                        <p id="loghc" style="height: 10px; display: none;"> </p>
                       </form>
                        <script>
                    function renderElseWhere(id, loc) {
                        var newPass_no = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?newPass_no=' + newPass_no + '&renewal=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere1(id, loc) {
                        var docDesc = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?docDesc=' + docDesc + '&renewal=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere2(id, loc) {
                        var firstname = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?firstname=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere3(id, loc) {
                        var firstname = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?middlename=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere4(id, loc) {
                        var dob = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?dob=' + dob + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere5(id, loc) {
                        var firstname = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?state=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>


                <script>
                    function renderElseWhere6(id, loc) {
                        var jobType = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&passportNumber=<%=passportNumber%>&imagecontrol=imageselect";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere7(id, loc) {
                        var sex = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?sex=' + sex + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere8(id, loc) {
                        var country = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?country=' + country + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere9(id, loc) {
                        var category = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?category=' + category + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>
                
                 <script>
                    function renderElseWhere10(id, loc) {
                        var docDesc = document.getElementById(id).value;
                        var print = '<img src="${pageContext.request.contextPath}/Initiator?docDesc=' + docDesc + '&renewal=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>
                
                <script>
                    $(function() {
                        $("#onrp_dob").datepicker({maxDate: "+0M +0D", changeMonth: true, dateFormat: "yy-mm-dd",
                            changeYear: true, buttonImage: "/resources/images/icons/calendar.gif", buttonImageOnly: true});
                    });
                </script>
                 <p class="tabheader"> Uploaded Files</p>
                <%
                    String user = (String) session.getAttribute("username");
                    List<String> list = (List<String>) request.getAttribute("documents");
                    List<String> doc_ids = (List<String>) request.getAttribute("doc_ids");
                    if (list != null) {
                        if (list.size() > 0) {%>
               

                    <%for (int i = 0; i < list.size(); i++) {
                            String documents = list.get(i);
                            String doc_id = "";
                            if (doc_ids != null) {
                                doc_id = doc_ids.get(i);
                            }
                           isdocAvailable = PageUtil.isDocAvailable(doc_id);
                           //  String jobType = list.get(i)[0];
                            if (documents != null) {
                    %>
           
                    <div class="thumbnail">
                      <div class="row">
                          <div class="col-md-3">
                              <strong><%= documents%></strong>
                          </div>
                        <div class="col-md-7">
                            <% if (isdocAvailable) { %>
                            <form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank"><input type ="hidden" name ="view"  value = "<%=doc_id%>" >
                                <button type ="submit" class="btn btn-default btn-block btn-lg"><span class="fa fa-folder"></span> View Document</button></form><br/> 
                                <%} else {%>
                                <label style="color: #ffffff;" for="NotAvailable">Not Available</label>
                                <%}%>
                 
                                        <%}
                        }%>
                        </div>
                      </div>
                    </div>
                        <div class="row">
                            <div class="col-md-offset-8 col-md-4">
                        <form action ="${pageContext.request.contextPath}/ImageUpload" method="post">
                            <input type ="hidden" name ="done"  value ="yes">
                            <input type ="hidden" name ="doneRenewal"  value ="yes">
                            <input type ="hidden" name ="renewal"  value ="yes">
                            <button type ="submit" class="btn btn-primary btn-block btn-lg"><span class="fa fa-send-o"></span> Submit</button>
                        </form>
                        </div>
                       </div>
                     <%}

                    }%>
            
                    </div>
                </div>
            </div>
        </div>
    </div>
        <!-- END PAGE CONTENT WRAPPER -->                                   
        <!-- end new form-->
            </div>
        </div>         
     </div>
   </div> 
    </body>
</html>
