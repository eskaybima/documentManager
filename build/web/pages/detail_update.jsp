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
                    <li class="active">Record Detail</li>
                </ul>
                <!-- END BREADCRUMB -->
                <div id="bodyhold">
                    <div id="bodycon">  

                        <%!                    String passportNumber = "";
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
                            LoaderVo lv;
                            String docDesc;
                            String mar_status;
                            String detail;
                            String enrolNo;
                            String title;
                            /**
                             * Added by Bayo *
                             */
                            String cre_dated;
                            SaveToDb sb = new SaveToDb();
                        %>



                        <%
                            values = (String[]) session.getAttribute("values");
                            applicationId = (String) session.getAttribute("applicationId");
                            lv = (LoaderVo) session.getAttribute("valueHolder");
                            imageList = (List<String>) session.getAttribute("documents");
                            imageUpdate = (List<String>) session.getAttribute("documentUpdates");
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
                            // credt = values[16];
                            cre_dated = sb.getValue2("select cre_date from fas_int_doc where passport_no = '" + passportNumber + "'");
                            for (int i = 0; i < imageList.size(); i++) {
                                out.println(imageList.get(i));
                            }
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
                            <label class="col-md-3 col-xs-12 control-label">Category:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=category%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Enrollment Number:</label>
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
                                    <input type="text" maxlength="10" class="form-control" placeholder="Enrollment Number" name="enrolNo" value="<%=lv.getEnrolNo()%>" id="enrolNo" onchange="renderElseWhere11('enrolNo', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Passport Number:</label>
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
                                    <input type="text" maxlength="10" class="form-control" placeholder="Passport Number" name="passportNumber" value="<%=lv.getPassNo()%>" id="passportNumber" onchange="renderElseWhere('passportNumber', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Title:</label>
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
                                    <input type="text" class="form-control" placeholder="Title" name="title" value="<%=lv.getTitle()%>" id="title" onchange="renderElseWhere12('title', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Surname:</label>
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
                                    <input type="text" class="form-control" placeholder="Surname" name="surname" value="<%=lv.getSurname()%>" id="surname" onchange="renderElseWhere1('surname', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">First Name:</label>
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
                                    <input type="text" class="form-control"  placeholder="First Name" name="firstname" value="<%=lv.getFirstname()%>" id="firstname" onchange="renderElseWhere2('firstname', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Middle Name:</label>
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
                                    <input type="text" class="form-control" placeholder="Middle Name" name="middlename" value="<%=lv.getMiddlename()%>" id="middlename" onchange="renderElseWhere3('middlename', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Marital Status:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=mar_status%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><span class="fa fa-user"></span></span>
                                    <input type="text" class="form-control" placeholder="Marital Status" name="mar_status" value="<%=lv.getMarital_status()%>" id="mar_status" onchange="renderElseWhere10('mar_status', 'loghc')"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Date of Birth:</label>
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
                                    <input type="text" class="form-control" placeholder="DD-MM-YYYY"  name="dob" value="<%=lv.getDob()%>" id="onrp_dob" onchange="renderElseWhere4('dob', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">State of Origin:</label>
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
                                    <input type="text" class="form-control" placeholder="State of origin" name="state" value="<%=lv.getState()%>" id="state" onchange="renderElseWhere5('state', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Sex:</label>
                            <div class="col-md-3 col-xs-6">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=sex%></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-6">
                                <select class="form-control select">
                                    <option value="">SELECT SEX</option>
                                    <option value="MALE">MALE</option>
                                    <option value="FEMALE">FEMALE</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Country of Birth:</label>
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
                                    <input type="text" class="form-control" placeholder="Country of Birth" name="country" value="<%=lv.getCountry()%>" id="country" onchange="renderElseWhere8('country', 'loghc')" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Creation Date:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""><%=cre_dated%></h4>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <p id="loghc" style="height: 10px;"> </p>
                       </form>
                        <form class="form-horizontal" action ="${pageContext.request.contextPath}/UpdateSTATE" method ="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label class="col-md-3 col-xs-12 control-label">Document Description:</label>
                            <div class="col-md-3 col-xs-12">
                                <div class="input-group">
                                    <label class="control-label">
                                        <h4 class=""></h4>
                                    </label>
                                </div>
                            </div>
                            <div class="col-md-4 col-xs-12">
                                <textarea class="form-control" rows="3" name="docDesc" value="" id="docDesc" onchange="renderElseWhere9('docDesc', 'loghc')" required placeholder="Document Description goes here" ></textarea>
                            </div>
                        </div>
                        <div class="bg-primary"><b> <span class="fa fa-file-archive-o"></span> Uploaded Files</b></div><br>
                        <div class="thumbnail">
                            <div class="form-group">
                                <div class="col-md-offset-3 col-md-4 col-xs-12">
                                    <input type="file" class="fileinput btn-default btn-block" name ="file0" required title="Choose File From Disk"/>
                                </div>
                                <div class="col-md-4 col-xs-6">
                                    <button class="btn btn-warning btn-block" type="submit"><span class="fa fa-cloud-upload"></span> Upload Document</button>
                                </div>
                            </div>
                        </div>
                        </form>
                        <%
                            List<LoaderVo> l = sb.getLoaderList(applicationId);
                            for (int k = 0; k < l.size(); k++) {
                                doc_type = l.get(k).getType();
                                doc_id = l.get(k).getDoc_id();
                        %>
                        <div class="thumbnail">
                            <div class="row">
                                <div class="col-md-12">
                            <div class="form-group">
                                <label class="col-md-2 col-xs-6 control-label"><%= doc_type%></label>
                                <form class="form-horizontal" action ="${pageContext.request.contextPath}/PDFLoader" target="_blank">
                                    <input type ="hidden" name ="view"  value = "<%= doc_id%>" >
                                    <div class="col-md-offset-5 col-md-4 col-xs-6">
                                        <button class="btn btn-primary btn-block" type="submit"><span class="fa fa-file"></span> View Old Document</button>
                                    </div>
                                </form>
                                </div>
                                </div>
                            </div>
                        </div>
                        <%}%>
                        <div class="well well-sm">
                            <form class="form-horizontal" action ="${pageContext.request.contextPath}/UpdateHandler">
                            <input type ="hidden" name ="confirm"  value = "confirm" />
                            <div class="form-group">
                                <div class="col-md-offset-7 col-md-4 col-xs-12">
                                    <button class="btn btn-success btn-block"><span class="fa fa-check-square"></span> Confirm</button>
                                </div>
                            </div>
                           </form>
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
            var docDesc = document.getElementById(id).value;
            var print = '<img src="${pageContext.request.contextPath}/Initiator?docDesc=' + docDesc + '&renewal=yes";">';
            document.getElementById(loc).innerHTML = print
        }
    </script>

    <script>
        function renderElseWhere10(id, loc) {
            var mar_status = document.getElementById(id).value;
            var print = '<img src="${pageContext.request.contextPath}/Initiator?mar_status=' + mar_status + '&control=two";">';
            document.getElementById(loc).innerHTML = print
        }
    </script>

    <script>
        function renderElseWhere11(id, loc) {
            var enrolNo = document.getElementById(id).value;
            var print = '<img src="${pageContext.request.contextPath}/Initiator?enrolNo=' + enrolNo + '&control=two";">';
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