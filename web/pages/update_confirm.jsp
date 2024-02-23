<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
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
            <script>
                $(function() {
                    $("#accord").accordion();
                });
            </script>
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
                    <li class="active">Confirm Record</li>
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
                    String applicationId;
                    String offset = null;
                    List<String> imageList;  
                    List<String> imageUpdate;
                    String[] values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                    String mar_status;
                    String title;
                    String enrolNo;
                    LoaderVo lv;
                    SaveToDb sb = new SaveToDb();
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
                    mar_status = values[13];
                    enrolNo = values[14];
                    title = values[15];
                %>
                
               <!-- end of new form --> 
    <div class="row">
        <div class="col-md-offset-1 col-md-10">
            <!-- START PROJECTS BLOCK -->
            <div class="panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title-box">
                        <span>Confirm Update for <%=applicationId%></span>
                    </div>
                    <ul class="panel-controls" style="margin-top: 2px;">
                        <li><a href="#" class="panel-fullscreen" data-toggle="tooltip" title="Full Screen"><span class="fa fa-expand"></span></a></li>
                        <li><a href="#" class="panel-refresh" data-toggle="tooltip" title="Refresh"><span class="fa fa-refresh"></span></a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="fa fa-cog"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" class="panel-collapse"><span class="fa fa-angle-down"></span> Collapse</a></li>
                                <li><a href="#" class="panel-remove"><span class="fa fa-times"></span> Remove</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="panel-body panel-body-table">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th width="30%">Item</th>
                                <th width="30%">Old Value</th>
                                <th width="40%">New Value</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% if ((lv.getPassNo() != "") & !lv.getPassNo().equalsIgnoreCase(passportNumber)) {%>
                                <tr>
                                    <td> Title of the Agreement: </td>
                                    <td><%=passportNumber%></td>
                                    <td><%=lv.getPassNo()%></td>
                                </tr>
                                <% }  if ((lv.getSurname() != "") & !lv.getSurname().equalsIgnoreCase(surname)) {%>
                                <tr>
                                    <td> Transferee: </td>
                                    <td><%=surname%></td>
                                    <td><%=lv.getSurname()%></td>
                                </tr>
                                 <% }  if ((lv.getFirstname() != "") & !lv.getFirstname().equalsIgnoreCase(firstname)) {%>
                                <tr>
                                    <td> Address: </td>
                                    <td><%=firstname%></td>
                                    <td><%=lv.getFirstname()%></td>
                                </tr>
                                <% }  if ((lv.getMiddlename() != "") & !lv.getMiddlename().equalsIgnoreCase(middlename)) {%>
                                <tr>
                                    <td> Transferor: </td>
                                    <td><%=middlename%></td>
                                    <td><%=lv.getMiddlename()%></td>
                                </tr>
                                 <% }  if ((lv.getDob() != "") & !lv.getDob().equalsIgnoreCase(dob)) {%>
                                <tr>
                                    <td>Date of Signing the Agreement: </td>
                                    <td><%=dob%></td>
                                    <td><%=lv.getDob()%></td>
                                </tr>
                                <% }  if ((lv.getState() != "") & !lv.getState().equalsIgnoreCase(state)) {%>
                                <tr>
                                    <td>Line of Bussiness: </td>
                                    <td><%=state%></td> 
                                    <td><%=lv.getState()%></td>
                                </tr>

                                <% }  if ((lv.getSex() != "") & !lv.getSex().equalsIgnoreCase(sex)) {%>
                                <tr>
                                    <td>Expiry Date of the Agreement: </td>
                                    <td><%=sex%></td> 
                                    <td><%=lv.getSex()%></td>
                               </tr
                               <% }  if ((lv.getCountry() != "") & !lv.getCountry().equalsIgnoreCase(country)) {%>
                                <tr>
                                    <td>Citizen Of:</td> 
                                    <td><%=country%></td> 
                                    <td><%=lv.getCountry()%></td>
                                </tr>
                                <% } if ((lv.getMarital_status() != "") & !lv.getMarital_status().equalsIgnoreCase(mar_status)) {%>
                                <tr>
                                    <td>Effective Date of the Agreement: </td>
                                    <td><%=mar_status%></td> 
                                    <td><%=lv.getMarital_status()%></td>
                                </tr>
                                <% } if ((lv.getTitle() != "") & !lv.getTitle().equalsIgnoreCase(title)) {%>
                                <tr>
                                    <td>Address: </td> 
                                    <td><%=title%></td> 
                                    <td><%=lv.getTitle()%></td> 
                                </tr>
                                <% } if ((lv.getEnrolNo() != "") & !lv.getTitle().equalsIgnoreCase(enrolNo)) {%>
                                <tr>
                                    <td>Position in Company:</td> 
                                    <td><%=enrolNo%></td> 
                                    <td><%=lv.getEnrolNo()%></td>
                                </tr>
                                <% } %>
                                <p id="loghc" style="height: 10px;"> </p>
                            </tbody>
                        </table>
                    </div>
                    <div class="bg-primary">Uploaded Files</div>
                        <%
                            List<LoaderVo> l = sb.getLoaderList(applicationId);
                            for (int k = 0; k < l.size(); k++) {
                                doc_type = l.get(k).getType();
                                doc_id = l.get(k).getDoc_id();
                        %>

                        <%if (imageUpdate.contains(doc_type)) {%>
                        <div class="well well-sm">
                           <form class="form-horizontal" action ="${pageContext.request.contextPath}/PDFLoader" target="_blank">
                            <div class="form-group">
                                <label class="col-md-3  col-xs-12 control-label">File Type: <%= doc_type%></label>
                                <div class="col-md-offset-4 col-md-4 col-xs-12">
                                        <input type ="hidden" name ="view"  value = "<%= doc_id%>">
                                        <button type ="submit" class="btn btn-default btn-block btn-lg"><span class="fa fa-file-pdf-o"></span> New Uploaded Document</button>
                                </div>
                            </div>
                           </form>
                        </div>
                         <% } %>
                       <% } %>
                       <form action ="${pageContext.request.contextPath}/UpdateHandler">
                        <div class="form-group">
                            <div class="col-md-3 col-xs-12">
                                <input type ="hidden" name ="update"  value = "update" />
                                <button type="submit" class="btn btn-success btn-block btn-lg"><span class="fa fa-send-o"></span> Submit</button>
                            </div>
                        </div>
                     </form>
                </div>
            </div>
            <!-- END PROJECTS BLOCK -->
        </div>
    </div>
<!-- end of new form -->


                        <script>
                            function renderElseWhere(id, loc) {
                                var pNumber = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?passportNumber=' + pNumber + '&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere1(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?surname=' + firstname + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere2(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?firstname=' + firstname + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere3(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?middlename=' + firstname + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere4(id, loc) {
                                var dob = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?dob=' + dob + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere5(id, loc) {
                                var firstname = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?state=' + firstname + '&passportNumber=<%=passportNumber%>&control=two";">';
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
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?sex=' + sex + '&passportNumber=<%=passportNumber%>&control=two";">';
                                document.getElementById(loc).innerHTML = print
                            }
                        </script>

                        <script>
                            function renderElseWhere8(id, loc) {
                                var country = document.getElementById(id).value;
                                var print = '<img src="${pageContext.request.contextPath}/Initiator?country=' + country + '&passportNumber=<%=passportNumber%>&control=two";">';
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



