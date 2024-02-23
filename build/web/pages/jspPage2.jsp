<%@page import="com.fasyl.newjobBo.PageUtil"%>
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
String first_name= "";
String last_name= "";
String middle_name= "";
String salary= "";
String name_of_organisation= "";
String state_of_origin= "";
String proof_of_state_of_origin= "";
String local_government_of_orign= "";
String birth_certificate= "";
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
boolean isdocAvailable;
%>
<%
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
first_name= (String) request.getAttribute("first_name");
last_name= (String) request.getAttribute("last_name");
middle_name= (String) request.getAttribute("middle_name");
salary= (String) request.getAttribute("salary");
name_of_organisation= (String) request.getAttribute("name_of_organisation");
state_of_origin= (String) request.getAttribute("state_of_origin");
proof_of_state_of_origin= (String) request.getAttribute("proof_of_state_of_origin");
local_government_of_orign= (String) request.getAttribute("local_government_of_orign");
birth_certificate= (String) request.getAttribute("birth_certificate");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel-body tab-content">
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
<label class="col-md-3 col-xs-12 control-label">FIRST NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" FIRST NAME" name="first_name" value="<%=first_name%>" id="first_name"  onchange="renderElseWhere11('first_name', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">LAST NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" LAST NAME" name="last_name" value="<%=last_name%>" id="last_name"  onchange="renderElseWhere11('last_name', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">MIDDLE NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" MIDDLE NAME" name="middle_name" value="<%=middle_name%>" id="middle_name"  onchange="renderElseWhere11('middle_name', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SALARY:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" SALARY" name="salary" value="<%=salary%>" id="salary"  onchange="renderElseWhere11('salary', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF ORGANISATION:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" NAME OF ORGANISATION" name="name_of_organisation" value="<%=name_of_organisation%>" id="name_of_organisation"  onchange="renderElseWhere11('name_of_organisation', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STATE OF ORIGIN:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<input type="text" class="form-control" placeholder=" STATE OF ORIGIN" name="state_of_origin" value="<%=state_of_origin%>" id="state_of_origin"  onchange="renderElseWhere11('state_of_origin', 'loghc')"/>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
<div class="col-md-6 col-xs-12">
 <select type="text" class="form-control select" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" />
   <% if (!imageList.contains("proof_of_state_of_origin")) {%>
    <option value="PROOF OF STATE OF ORIGIN">PROOF OF STATE OF ORIGIN</option>
   <% } %>
   <% if (!imageList.contains("local_government_of_orign")) {%>
    <option value="LOCAL GOVERNMENT OF ORIGN">LOCAL GOVERNMENT OF ORIGN</option>
   <% } %>
   <% if (!imageList.contains("birth_certificate")) {%>
    <option value="BIRTH CERTIFICATE">BIRTH CERTIFICATE</option>
   <% } %>
  </select>
<p id="loghc" style="height: 10px; display: none;"> </p>
</div>
</div>
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
