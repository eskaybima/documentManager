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
String title= "";
List<String> titlelist;
String surname= "";
List<String> surnamelist;
String other_names= "";
List<String> other_nameslist;
String house_number= "";
List<String> house_numberlist;
String name_of_area= "";
List<String> name_of_arealist;
String town= "";
List<String> townlist;
String state= "";
List<String> statelist;
String telephone= "";
List<String> telephonelist;
String postal_address= "";
List<String> postal_addresslist;
String employment_status= "";
List<String> employment_statuslist;
String employers_name= "";
List<String> employers_namelist;
String employers_address= "";
List<String> employers_addresslist;
String employers_business= "";
List<String> employers_businesslist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "IND_REG_FORM";
boolean isdocAvailable;
%>
<%
titlelist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='title'");
surnamelist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='surname'");
other_nameslist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='other_names'");
house_numberlist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='house_number'");
name_of_arealist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='name_of_area'");
townlist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='town'");
statelist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='state'");
telephonelist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='telephone'");
postal_addresslist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='postal_address'");
employment_statuslist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='employment_status'");
employers_namelist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='employers_name'");
employers_addresslist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='employers_address'");
employers_businesslist = sb.getList2("select param_value from param_values_IND_REG_FORM where parameter_name ='employers_business'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "IND_REG_FORM.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
title= (String) request.getAttribute("title");
surname= (String) request.getAttribute("surname");
other_names= (String) request.getAttribute("other_names");
house_number= (String) request.getAttribute("house_number");
name_of_area= (String) request.getAttribute("name_of_area");
town= (String) request.getAttribute("town");
state= (String) request.getAttribute("state");
telephone= (String) request.getAttribute("telephone");
postal_address= (String) request.getAttribute("postal_address");
employment_status= (String) request.getAttribute("employment_status");
employers_name= (String) request.getAttribute("employers_name");
employers_address= (String) request.getAttribute("employers_address");
employers_business= (String) request.getAttribute("employers_business");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel-body tab-content"><div class="modal-header"><h3>INDIVIDUAL REGISTRATION FORM</h3><div class="clear"></div></div>
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
<label class="col-md-3 col-xs-12 control-label">TITLE:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (titlelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" TITLE" name="title" value="<%=title%>" id="title"  onchange="renderElseWhere('title', 'loghc')"/>
<%} else {%>
<select name="title" value="<%=title%>" id="title" onchange="renderElseWhere('title', 'loghc')" />
<option value="<%=title%>"><%=title%></option>
<% for (int i = 0; i < titlelist.size(); i++) {%>
<option value="<%=titlelist.get(i)%>"><%=titlelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SURNAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (surnamelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" SURNAME" name="surname" value="<%=surname%>" id="surname"  onchange="renderElseWhere('surname', 'loghc')"/>
<%} else {%>
<select name="surname" value="<%=surname%>" id="surname" onchange="renderElseWhere('surname', 'loghc')" />
<option value="<%=surname%>"><%=surname%></option>
<% for (int i = 0; i < surnamelist.size(); i++) {%>
<option value="<%=surnamelist.get(i)%>"><%=surnamelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">OTHER NAMES:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (other_nameslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" OTHER NAMES" name="other_names" value="<%=other_names%>" id="other_names"  onchange="renderElseWhere('other_names', 'loghc')"/>
<%} else {%>
<select name="other_names" value="<%=other_names%>" id="other_names" onchange="renderElseWhere('other_names', 'loghc')" />
<option value="<%=other_names%>"><%=other_names%></option>
<% for (int i = 0; i < other_nameslist.size(); i++) {%>
<option value="<%=other_nameslist.get(i)%>"><%=other_nameslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">HOUSE NUMBER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (house_numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" HOUSE NUMBER" name="house_number" value="<%=house_number%>" id="house_number"  onchange="renderElseWhere('house_number', 'loghc')"/>
<%} else {%>
<select name="house_number" value="<%=house_number%>" id="house_number" onchange="renderElseWhere('house_number', 'loghc')" />
<option value="<%=house_number%>"><%=house_number%></option>
<% for (int i = 0; i < house_numberlist.size(); i++) {%>
<option value="<%=house_numberlist.get(i)%>"><%=house_numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF AREA:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (name_of_arealist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NAME OF AREA" name="name_of_area" value="<%=name_of_area%>" id="name_of_area"  onchange="renderElseWhere('name_of_area', 'loghc')"/>
<%} else {%>
<select name="name_of_area" value="<%=name_of_area%>" id="name_of_area" onchange="renderElseWhere('name_of_area', 'loghc')" />
<option value="<%=name_of_area%>"><%=name_of_area%></option>
<% for (int i = 0; i < name_of_arealist.size(); i++) {%>
<option value="<%=name_of_arealist.get(i)%>"><%=name_of_arealist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TOWN:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (townlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" TOWN" name="town" value="<%=town%>" id="town"  onchange="renderElseWhere('town', 'loghc')"/>
<%} else {%>
<select name="town" value="<%=town%>" id="town" onchange="renderElseWhere('town', 'loghc')" />
<option value="<%=town%>"><%=town%></option>
<% for (int i = 0; i < townlist.size(); i++) {%>
<option value="<%=townlist.get(i)%>"><%=townlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STATE:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (statelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" STATE" name="state" value="<%=state%>" id="state"  onchange="renderElseWhere('state', 'loghc')"/>
<%} else {%>
<select name="state" value="<%=state%>" id="state" onchange="renderElseWhere('state', 'loghc')" />
<option value="<%=state%>"><%=state%></option>
<% for (int i = 0; i < statelist.size(); i++) {%>
<option value="<%=statelist.get(i)%>"><%=statelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TELEPHONE:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (telephonelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" TELEPHONE" name="telephone" value="<%=telephone%>" id="telephone"  onchange="renderElseWhere('telephone', 'loghc')"/>
<%} else {%>
<select name="telephone" value="<%=telephone%>" id="telephone" onchange="renderElseWhere('telephone', 'loghc')" />
<option value="<%=telephone%>"><%=telephone%></option>
<% for (int i = 0; i < telephonelist.size(); i++) {%>
<option value="<%=telephonelist.get(i)%>"><%=telephonelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">POSTAL ADDRESS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (postal_addresslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" POSTAL ADDRESS" name="postal_address" value="<%=postal_address%>" id="postal_address"  onchange="renderElseWhere('postal_address', 'loghc')"/>
<%} else {%>
<select name="postal_address" value="<%=postal_address%>" id="postal_address" onchange="renderElseWhere('postal_address', 'loghc')" />
<option value="<%=postal_address%>"><%=postal_address%></option>
<% for (int i = 0; i < postal_addresslist.size(); i++) {%>
<option value="<%=postal_addresslist.get(i)%>"><%=postal_addresslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMPLOYMENT STATUS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (employment_statuslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" EMPLOYMENT STATUS" name="employment_status" value="<%=employment_status%>" id="employment_status"  onchange="renderElseWhere('employment_status', 'loghc')"/>
<%} else {%>
<select name="employment_status" value="<%=employment_status%>" id="employment_status" onchange="renderElseWhere('employment_status', 'loghc')" />
<option value="<%=employment_status%>"><%=employment_status%></option>
<% for (int i = 0; i < employment_statuslist.size(); i++) {%>
<option value="<%=employment_statuslist.get(i)%>"><%=employment_statuslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMPLOYERS NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (employers_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" EMPLOYERS NAME" name="employers_name" value="<%=employers_name%>" id="employers_name"  onchange="renderElseWhere('employers_name', 'loghc')"/>
<%} else {%>
<select name="employers_name" value="<%=employers_name%>" id="employers_name" onchange="renderElseWhere('employers_name', 'loghc')" />
<option value="<%=employers_name%>"><%=employers_name%></option>
<% for (int i = 0; i < employers_namelist.size(); i++) {%>
<option value="<%=employers_namelist.get(i)%>"><%=employers_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMPLOYERS ADDRESS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (employers_addresslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" EMPLOYERS ADDRESS" name="employers_address" value="<%=employers_address%>" id="employers_address"  onchange="renderElseWhere('employers_address', 'loghc')"/>
<%} else {%>
<select name="employers_address" value="<%=employers_address%>" id="employers_address" onchange="renderElseWhere('employers_address', 'loghc')" />
<option value="<%=employers_address%>"><%=employers_address%></option>
<% for (int i = 0; i < employers_addresslist.size(); i++) {%>
<option value="<%=employers_addresslist.get(i)%>"><%=employers_addresslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMPLOYERS BUSINESS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (employers_businesslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" EMPLOYERS BUSINESS" name="employers_business" value="<%=employers_business%>" id="employers_business"  onchange="renderElseWhere('employers_business', 'loghc')"/>
<%} else {%>
<select name="employers_business" value="<%=employers_business%>" id="employers_business" onchange="renderElseWhere('employers_business', 'loghc')" />
<option value="<%=employers_business%>"><%=employers_business%></option>
<% for (int i = 0; i < employers_businesslist.size(); i++) {%>
<option value="<%=employers_businesslist.get(i)%>"><%=employers_businesslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
<div class="col-md-6 col-xs-12">
 <select type="text" class="form-control select" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" />
    <option value=""></option>
   <% if (!imageList.contains("signature_and_date")) {%>
    <option value="signature_and_date">SIGNATURE AND DATE</option>
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
<%}
}%>