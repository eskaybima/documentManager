<%@page import="com.fasyl.newjobBo.PageUtil"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8 />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Upload New Job</title>
<jsp:include page="pagesimport.jsp"></jsp:include>
<script language="JavaScript" src="resources/javaScript/checkuploadsize.js"></script>
<script language="JavaScript" src="resources/javaScript/notapJs.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/fordialog.css" />
<link rel="stylesheet" type="text/css" href="resources/css/dropzone.css" />
<link href="resources/css/dropzone.css" type="text/css" rel="stylesheet" />
</head>
<body id="background">
<div class="page-container">
<jsp:include page="leftMenu.jsp"></jsp:include>
<div class="page-content">
<jsp:include page="header.jsp"></jsp:include>
<ul class="breadcrumb">
<li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
<li><a href="#">Upload Operations</a></li>
<li class="active">Scan New Jobs</li>
</ul>
<div id="bodyhold">
<div id="bodycon">
<div id='ajaxDiv'></div>
<div id="dialogoverlay"></div>
<div id="dialogbox">
<div>
<div id="dialogboxhead"></div>
<div id="dialogboxbody"></div>
<div id="dialogboxfoot"></div>
</div>
</div>
<%!
String personall_details= "";
List<String> personall_detailslist;
String first_name= "";
List<String> first_namelist;
String last_name= "";
List<String> last_namelist;
String middle_name= "";
List<String> middle_namelist;
String address= "";
List<String> addresslist;
String city_= "";
List<String> city_list;
String state= "";
List<String> statelist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "STAFF_REG";
boolean isdocAvailable;
%>
<%
personall_detailslist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='personall_details'");
first_namelist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='first_name'");
last_namelist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='last_name'");
middle_namelist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='middle_name'");
addresslist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='address'");
city_list = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='city_'");
statelist = sb.getList2("select param_value from param_values_STAFF_REG where parameter_name ='state'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "STAFF_REG.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
personall_details= (String) request.getAttribute("personall_details");
first_name= (String) request.getAttribute("first_name");
last_name= (String) request.getAttribute("last_name");
middle_name= (String) request.getAttribute("middle_name");
address= (String) request.getAttribute("address");
city_= (String) request.getAttribute("city_");
state= (String) request.getAttribute("state");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>STAFF REGISTRATION</h3><div class="clear"></div></div>
<form class="form-horizontal" action ="${pageContext.request.contextPath}/ImageUpload" method ="post" enctype="multipart/form-data">
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">Reference ID:</label>
<div class="col-md-6 col-xs-12">
<div class="input-group">
<label class="control-label"><input type="text" value ="<%= ref_id%>" readonly="true"/>
</label>
</div>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> PERSONALL DETAILS</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">FIRST NAME:</label>
<div class="col-md-6 col-xs-12">
<% if (first_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" FIRST NAME" name="first_name" value="<%=first_name%>" id="first_name"  onchange="renderElseWhere('first_name', 'loghc')"/>
<%} else {%>
<select name="first_name" value="<%=first_name%>"   class="form-control select"  id="first_name" onchange="renderElseWhere('first_name', 'loghc')" />
<option value="<%=first_name%>"><%=first_name%></option>
<% for (int i = 0; i < first_namelist.size(); i++) {%>
<option value="<%=first_namelist.get(i)%>"><%=first_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">LAST NAME:</label>
<div class="col-md-6 col-xs-12">
<% if (last_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" LAST NAME" name="last_name" value="<%=last_name%>" id="last_name"  onchange="renderElseWhere('last_name', 'loghc')"/>
<%} else {%>
<select name="last_name" value="<%=last_name%>"   class="form-control select"  id="last_name" onchange="renderElseWhere('last_name', 'loghc')" />
<option value="<%=last_name%>"><%=last_name%></option>
<% for (int i = 0; i < last_namelist.size(); i++) {%>
<option value="<%=last_namelist.get(i)%>"><%=last_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">MIDDLE NAME:</label>
<div class="col-md-6 col-xs-12">
<% if (middle_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" MIDDLE NAME" name="middle_name" value="<%=middle_name%>" id="middle_name"  onchange="renderElseWhere('middle_name', 'loghc')"/>
<%} else {%>
<select name="middle_name" value="<%=middle_name%>"   class="form-control select"  id="middle_name" onchange="renderElseWhere('middle_name', 'loghc')" />
<option value="<%=middle_name%>"><%=middle_name%></option>
<% for (int i = 0; i < middle_namelist.size(); i++) {%>
<option value="<%=middle_namelist.get(i)%>"><%=middle_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS:</label>
<div class="col-md-6 col-xs-12">
<% if (addresslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" ADDRESS" name="address" value="<%=address%>" id="address"  onchange="renderElseWhere('address', 'loghc')"/>
<%} else {%>
<select name="address" value="<%=address%>"   class="form-control select"  id="address" onchange="renderElseWhere('address', 'loghc')" />
<option value="<%=address%>"><%=address%></option>
<% for (int i = 0; i < addresslist.size(); i++) {%>
<option value="<%=addresslist.get(i)%>"><%=addresslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">CITY :</label>
<div class="col-md-6 col-xs-12">
<% if (city_list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" CITY " name="city_" value="<%=city_%>" id="city_"  onchange="renderElseWhere('city_', 'loghc')"/>
<%} else {%>
<select name="city_" value="<%=city_%>"   class="form-control select"  id="city_" onchange="renderElseWhere('city_', 'loghc')" />
<option value="<%=city_%>"><%=city_%></option>
<% for (int i = 0; i < city_list.size(); i++) {%>
<option value="<%=city_list.get(i)%>"><%=city_list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STATE:</label>
<div class="col-md-6 col-xs-12">
<% if (statelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" STATE" name="state" value="<%=state%>" id="state"  onchange="renderElseWhere('state', 'loghc')"/>
<%} else {%>
<select name="state" value="<%=state%>"   class="form-control select"  id="state" onchange="renderElseWhere('state', 'loghc')" />
<option value="<%=state%>"><%=state%></option>
<% for (int i = 0; i < statelist.size(); i++) {%>
<option value="<%=statelist.get(i)%>"><%=statelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
<div class="col-md-6 col-xs-12">
 <select type="text" class="form-control select" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" />
    <option value=""></option>
  </select>
<p id="loghc" style="height: 10px; display: none;"> </p>
</div>
</div>
<div class="well well-sm">
<div class="text-primary h5"><span class="fa fa-cloud-upload"></span> File Upload</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">File Section:</label>
<div class="col-md-3 col-xs-12">
<input type="file" class="fileinput btn-default" name="file0" id="filebayo"   onchange="checkFile()" title="Choose File From Disk"/>
</div>
<div class="col-md-3 col-xs-12">
<button type="submit" class="btn btn-success"><span class="fa fa-upload"></span> UPLOAD</button>
 </div>
</div>
</div>
<p id="loghc" style="height: 10px; display: none;"> </p>
</form>
</div>
</div>
<script>
function renderElseWhere(id, loc) {
var paramValue = document.getElementById(id).value;
var print = '<img src="${pageContext.request.contextPath}/Initiator?paramValue=' + paramValue + '&paramName='+id+'&control=one";">';
document.getElementById(loc).innerHTML = print
}
</script>
<script>
function renderElseWhere6(id, loc) {
var jobType = document.getElementById(id).value;
var print = '<img src="${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&imagecontrol=imageselect";">';
document.getElementById(loc).innerHTML = print
}
</script>
<%
String user = (String) session.getAttribute("username");
List<String> list = (List<String>) request.getAttribute("documents");
List<String> doc_ids = (List<String>) request.getAttribute("doc_ids");
if (list != null) {
if (list.size() > 0) {%>
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-default">
<div class="panel-heading">
<div class="panel-title-box">
<h3 class="panel-title"><strong><span class="fa fa-cloud-upload"></span> Uploaded Files</strong></h3>
 </div>
</div>
<div class="panel-body panel-body-table">
<div class="table-responsive">
<table class="table table-striped datatable">
<thead>
<tr>
<th width="30%"><span class="fa fa-file"></span> Document Type</th>
<th width="40%"><span class="fa fa-eye"></span> View Action</th>
<th width="30%"><span class="fa fa-trash-o"></span> Delete Action</th>
</tr>
</thead>
<tbody>
<%for (int i = 0; i < list.size(); i++) {
 String documents = list.get(i);
String doc_id = "";
if (doc_ids != null) {
doc_id = doc_ids.get(i);
}
isdocAvailable = PageUtil.isDocAvailable(doc_id);
if (documents != null) {
%>
<tr>
<td> <%= documents%></td>
<td>
<% if (isdocAvailable) {%>
<form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank"><input type ="hidden" name ="view"  value = "<%=doc_id%>">
<Button class="btn btn-success" type="submit"><span class="fa fa-file-pdf-o"></span> View Document</Button></form><br/>
<%} else {%>
<label style="color: #ffffff;" for="NotAvailable">Not Available</label>
<%}%>
<td>
<form action ="${pageContext.request.contextPath}/ImageUpload">
<input type ="hidden" name ="delete"  value ="delete2">
<input type ="hidden" name ="jp"  value ="newJob">
<input type ="hidden" name ="document_type"  value ="<%=documents%>">
<Button class="btn btn-danger" type="submit"><span class="fa fa-trash-o"></span> Delete</Button>
</form>
</td>
</tr>
<%}
}%>
</tbody>
</table><br/>
<form action ="${pageContext.request.contextPath}/ImageUpload" method="post">
<table class="table">
<td>
<input type ="hidden" name ="template"  value ="<%=template%>">
<input type ="hidden" name ="done"  value ="yes">
</td>
<td>
<Button class="btn btn-default" type="submit"><span class="fa fa-send-o"></span> Submit</Button>
</td>
</table>
</form>
</div>
</div>
</div>
</div>
 </div>
</div>
</div>
 </div>
<%}
}%>