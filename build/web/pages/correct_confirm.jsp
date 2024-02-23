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
                    String category = "";
                    String applicationId;
                    String offset = null;
                    List<String> imageList;  
                    List<String> imageUpdate;
                    String[] values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                    String mar_status;
                    String enrolNo;
                    String title;
                    LoaderVo lv;
                    public SaveToDb sb = new SaveToDb();
                %>

                       <div class="row">
                            <div class="col-md-offset-1 col-md-10">
                                <!-- START PROJECTS BLOCK -->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="panel-title-box">
                                            <span>Confirm Updates for <%=applicationId%></span>
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
                                                    <th width="40%">Old Value</th>
                                                    <th width="30%">New Value</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="bg-primary">Uploaded Files</div>
                                        <div class="well well-sm">
                                            <div class="form-group">
                                                <label class="col-md-3 col-xs-12 control-label">File Name:</label>
                                                <div class="col-md-6 col-xs-12">
                                                    <span class="h4">My_passport_0002.xls</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-2 col-xs-12">
                                                <button type="button" class="btn btn-success btn-block mb-control" onclick="removemodal()"  data-box="#message-box-success2"><span class="fa fa-location-arrow"></span> Submit</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- END PROJECTS BLOCK -->
                            </div>
                        </div> 

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
                    category = values[12];
                    mar_status = values[13];
                    enrolNo = values[14];
                    title = values[15];
                %>
                
                
                
                <p class="tabheader"> Confirm Updates for <%=applicationId%></p>
                <div class="panel-body panel-body-table">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                    <tr>
                        <td> <label style="color:orangered" for="Item">Item</label>
                        <td> <label style="color:orangered" for="Old Value">Old Value</label>
                        <td> <label style="color:orangered" for="New Value">New Value</label>
                    </tr>
                     <thead>
                    <tbody>

                        <% if ((lv.getPassNo() != "") & !lv.getPassNo().equalsIgnoreCase(passportNumber)) {%>
                        <tr>
                            <td>Title of the Agreement: 
                            <td><%=passportNumber%></td>
                            <td><%=lv.getPassNo()%>
                        </tr>
                        <% }  if ((lv.getSurname() != "") & !lv.getSurname().equalsIgnoreCase(surname)) {%>
                        <tr>
                            <td> Transferee: 
                            <td><%=surname%></td>
                            <td><%=lv.getSurname()%>
                        </tr>
                         <% }  if ((lv.getFirstname() != "") & !lv.getFirstname().equalsIgnoreCase(firstname)) {%>
                        <tr>
                            <td> Address: 
                            <td><%=firstname%></td>
                            <td><%=lv.getFirstname()%>
                        </tr>
                        <% }  if ((lv.getMiddlename() != "") & !lv.getMiddlename().equalsIgnoreCase(middlename)) {%>
                        <tr>
                            <td> Transferor: 
                            <td><%=middlename%></td>
                            <td><%=lv.getMiddlename()%>
                        </tr>
                         <% }  if ((lv.getDob() != "") & !lv.getDob().equalsIgnoreCase(dob)) {%>
                        <tr>
                            <td>Date of Signing Agreement: 
                            <td><%=dob%></td>
                            <td><%=lv.getDob()%>
                        </tr>
                        <% }  if ((lv.getState() != "") & !lv.getState().equalsIgnoreCase(state)) {%>
                        <tr>
                            <td>Line Of Bussiness: 
                            <td><%=state%></td> 
                            <td><%=lv.getState()%>
                        </tr>
                        
                        <% }  if ((lv.getSex() != "") & !lv.getSex().equalsIgnoreCase(sex)) {%>
                        <tr>
                            <td>Expiry Date of Agreement: 
                            <td><%=sex%></td> 
                            <td><%=lv.getSex()%>
                       </tr
                       <% }  if ((lv.getCountry() != "") & !lv.getCountry().equalsIgnoreCase(country)) {%>
                        <tr>
                            <td>Citizen Of: 
                            <td><%=country%></td> 
                            <td><%=lv.getCountry()%>
                        </tr>
                        <% } if ((lv.getCategory() != "") & !lv.getCategory().equalsIgnoreCase(category)) {%>
                        <tr>
                            <td>Name: 
                            <td><%=category%></td> 
                            <td><%=lv.getCategory()%>
                        </tr>
                        <% } if ((lv.getMarital_status() != "") & !lv.getMarital_status().equalsIgnoreCase(mar_status)) {%>
                        <tr>
                            <td>Effective Date of Agreement
                            <td><%=mar_status%></td> 
                            <td><%=lv.getMarital_status()%>
                        </tr>
                        <%} if ((lv.getEnrolNo() != "") & !lv.getEnrolNo().equalsIgnoreCase(enrolNo)) {%>
                        <tr>
                            <td>Position in Company:
                            <td><%=enrolNo%></td> 
                            <td><%=lv.getEnrolNo()%>
                        </tr>
                        <%} if ((lv.getTitle() != "") & !lv.getTitle().equalsIgnoreCase(title)) {%>
                        <tr>
                            <td>Address 
                           <td><%=title%></td> 
                            <td><%=lv.getTitle()%>
                        </tr>
                        <%}%>
                       <br/> 
                        <p id="loghc" style="height: 10px;"> </p>
                </form>
                       </tbody>
                        </table>   
                    </div>
                    <div class="bg-primary">Uploaded Files</div>
                   
                 <table class="table">

                        <tr>
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
                                <input type ="hidden" name ="view"  value = "<%= doc_id%>" >
                               
                                
                                 <button type ="submit" class="btn btn-default btn-block btn-lg"><span class="fa fa-file-pdf-o"></span> New Uploaded Document</button>
                                  </div>
                            </div>
                            </form>
                           </div>
                            <% } %>
                    </tr>
                <%}%>
                
                
                 <form action ="${pageContext.request.contextPath}/UpdateHandler">
                        <div class="form-group">
                            <div class="col-md-3 col-xs-12">
                                <input type ="hidden" name ="correct"  value = "correct" />
                                <button type="submit" class="btn btn-success btn-block btn-lg"><span class="fa fa-send-o"></span> Submit</button>
                            </div>
                        </div>
                     </form>
                           </div>
            </div>
            <!-- END PROJECTS BLOCK -->
        </div>
    </div>
                        
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
    </body>
</html>



