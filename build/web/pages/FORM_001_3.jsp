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
String next_of_kin= "";
List<String> next_of_kinlist;
String personal_details= "";
List<String> personal_detailslist;
String title= "";
List<String> titlelist;
String full_name= "";
List<String> full_namelist;
String position= "";
List<String> positionlist;
String staff_id= "";
List<String> staff_idlist;
String amount_paid= "";
List<String> amount_paidlist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
boolean isdocAvailable;
String template = "FORM_001";
%>
<%
titlelist = sb.getList2("select distinct param_value from param_values_FORM_001 where parameter_name ='title' order by param_value asc" );
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
next_of_kin= (String) request.getAttribute("next_of_kin");
personal_details= (String) request.getAttribute("personal_details");
title= (String) request.getAttribute("title");
full_name= (String) request.getAttribute("full_name");
position= (String) request.getAttribute("position");
staff_id= (String) request.getAttribute("staff_id");
amount_paid= (String) request.getAttribute("amount_paid");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>FORM 001</h3><div class="clear"></div></div>
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NEXT OF KIN:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" next_of_kin" name="next_of_kin" value="<%=next_of_kin%>" id="next_of_kin"  onchange="renderElseWhere('next_of_kin', 'loghc')"/>
<%} else {%>
<select name="next_of_kin" value="<%=next_of_kin%>"  class="form-control select"  id="next_of_kin" onchange="renderElseWhere('next_of_kin', 'loghc')" />
<option value="<%=next_of_kin%>"><%=next_of_kin%></option>
<% for (int i = 0; i < next_of_kinlist.size(); i++) {%>
<option value="<%=next_of_kinlist.get(i)%>"><%=next_of_kinlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="modal-header"><span class="h5 text-info">" personal_details"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TITLE:</label>
<div class="col-md-6 col-xs-12">
<% if (!("DROP_DOWN".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" title" name="title" value="<%=title%>" id="title"  onchange="renderElseWhere('title', 'loghc')"/>
<%} else {%>
<select name="title" value="<%=title%>"  class="form-control select"  id="title" onchange="renderElseWhere('title', 'loghc')" />
<option value="<%=title%>"><%=title%></option>
<% for (int i = 0; i < titlelist.size(); i++) {%>
<option value="<%=titlelist.get(i)%>"><%=titlelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">FULL NAME:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" full_name" name="full_name" value="<%=full_name%>" id="full_name"  onchange="renderElseWhere('full_name', 'loghc')"/>
<%} else {%>
<select name="full_name" value="<%=full_name%>"  class="form-control select"  id="full_name" onchange="renderElseWhere('full_name', 'loghc')" />
<option value="<%=full_name%>"><%=full_name%></option>
<% for (int i = 0; i < full_namelist.size(); i++) {%>
<option value="<%=full_namelist.get(i)%>"><%=full_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">POSITION:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" position" name="position" value="<%=position%>" id="position"  onchange="renderElseWhere('position', 'loghc')"/>
<%} else {%>
<select name="position" value="<%=position%>"  class="form-control select"  id="position" onchange="renderElseWhere('position', 'loghc')" />
<option value="<%=position%>"><%=position%></option>
<% for (int i = 0; i < positionlist.size(); i++) {%>
<option value="<%=positionlist.get(i)%>"><%=positionlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STAFF ID:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" staff_id" name="staff_id" value="<%=staff_id%>" id="staff_id"  onchange="renderElseWhere('staff_id', 'loghc')"/>
<%} else {%>
<select name="staff_id" value="<%=staff_id%>"  class="form-control select"  id="staff_id" onchange="renderElseWhere('staff_id', 'loghc')" />
<option value="<%=staff_id%>"><%=staff_id%></option>
<% for (int i = 0; i < staff_idlist.size(); i++) {%>
<option value="<%=staff_idlist.get(i)%>"><%=staff_idlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">AMOUNT PAID:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" amount_paid" name="amount_paid" value="<%=amount_paid%>" id="amount_paid"  onchange="renderElseWhere('amount_paid', 'loghc')"/>
<%} else {%>
<select name="amount_paid" value="<%=amount_paid%>"  class="form-control select"  id="amount_paid" onchange="renderElseWhere('amount_paid', 'loghc')" />
<option value="<%=amount_paid%>"><%=amount_paid%></option>
<% for (int i = 0; i < amount_paidlist.size(); i++) {%>
<option value="<%=amount_paidlist.get(i)%>"><%=amount_paidlist.get(i)%></option>
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
   <% if (!imageList.contains("pay_slip")) {%>
    <option value="pay_slip">pay_slip</option>
   <% } %>
   <% if (!imageList.contains("passport_data_page")) {%>
    <option value="passport_data_page">passport_data_page</option>
   <% } %>
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
<input type ="hidden" name ="done"  value ="yes">
<input type ="hidden" name ="template"  value ="<%=template%>">
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