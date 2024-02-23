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
String voucher_data= "";
List<String> voucher_datalist;
String name_of_company= "";
List<String> name_of_companylist;
String address= "";
List<String> addresslist;
String amount= "";
List<String> amountlist;
String description_of_transction= "";
List<String> description_of_transctionlist;
String position_in_company= "";
List<String> position_in_companylist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
boolean isdocAvailable;
String template = "VoucherUpload";
%>
<%
voucher_datalist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='voucher_data'");
name_of_companylist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='name_of_company'");
addresslist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='address'");
amountlist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='amount'");
description_of_transctionlist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='description_of_transction'");
position_in_companylist = sb.getList2("select param_value from param_values_VoucherUpload where parameter_name ='position_in_company'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
voucher_data= (String) request.getAttribute("voucher_data");
name_of_company= (String) request.getAttribute("name_of_company");
address= (String) request.getAttribute("address");
amount= (String) request.getAttribute("amount");
description_of_transction= (String) request.getAttribute("description_of_transction");
position_in_company= (String) request.getAttribute("position_in_company");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>VoucherUpload</h3><div class="clear"></div></div><div class="modal-header"><h3>VOUCHERUPLOAD</h3><div class="clear"></div></div>
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
<div class="modal-header"><span class="h5 text-info">" voucher_data"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF COMPANY:</label>
<div class="col-md-6 col-xs-12">
<% if (name_of_companylist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" name_of_company" name="name_of_company" value="<%=name_of_company%>" id="name_of_company"  onchange="renderElseWhere('name_of_company', 'loghc')"/>
<%} else {%>
<select name="name_of_company" value="<%=name_of_company%>"  class="form-control select"  id="name_of_company" onchange="renderElseWhere('name_of_company', 'loghc')" />
<option value="<%=name_of_company%>"><%=name_of_company%></option>
<% for (int i = 0; i < name_of_companylist.size(); i++) {%>
<option value="<%=name_of_companylist.get(i)%>"><%=name_of_companylist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS:</label>
<div class="col-md-6 col-xs-12">
<% if (addresslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" address" name="address" value="<%=address%>" id="address"  onchange="renderElseWhere('address', 'loghc')"/>
<%} else {%>
<select name="address" value="<%=address%>"  class="form-control select"  id="address" onchange="renderElseWhere('address', 'loghc')" />
<option value="<%=address%>"><%=address%></option>
<% for (int i = 0; i < addresslist.size(); i++) {%>
<option value="<%=addresslist.get(i)%>"><%=addresslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">AMOUNT:</label>
<div class="col-md-6 col-xs-12">
<% if (amountlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" amount" name="amount" value="<%=amount%>" id="amount"  onchange="renderElseWhere('amount', 'loghc')"/>
<%} else {%>
<select name="amount" value="<%=amount%>"  class="form-control select"  id="amount" onchange="renderElseWhere('amount', 'loghc')" />
<option value="<%=amount%>"><%=amount%></option>
<% for (int i = 0; i < amountlist.size(); i++) {%>
<option value="<%=amountlist.get(i)%>"><%=amountlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DESCRIPTION OF TRANSCTION:</label>
<div class="col-md-6 col-xs-12">
<% if (description_of_transctionlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" description_of_transction" name="description_of_transction" value="<%=description_of_transction%>" id="description_of_transction"  onchange="renderElseWhere('description_of_transction', 'loghc')"/>
<%} else {%>
<select name="description_of_transction" value="<%=description_of_transction%>"  class="form-control select"  id="description_of_transction" onchange="renderElseWhere('description_of_transction', 'loghc')" />
<option value="<%=description_of_transction%>"><%=description_of_transction%></option>
<% for (int i = 0; i < description_of_transctionlist.size(); i++) {%>
<option value="<%=description_of_transctionlist.get(i)%>"><%=description_of_transctionlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">POSITION IN COMPANY:</label>
<div class="col-md-6 col-xs-12">
<% if (position_in_companylist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" position_in_company" name="position_in_company" value="<%=position_in_company%>" id="position_in_company"  onchange="renderElseWhere('position_in_company', 'loghc')"/>
<%} else {%>
<select name="position_in_company" value="<%=position_in_company%>"  class="form-control select"  id="position_in_company" onchange="renderElseWhere('position_in_company', 'loghc')" />
<option value="<%=position_in_company%>"><%=position_in_company%></option>
<% for (int i = 0; i < position_in_companylist.size(); i++) {%>
<option value="<%=position_in_companylist.get(i)%>"><%=position_in_companylist.get(i)%></option>
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
   <% if (!imageList.contains("letter_of_award")) {%>
    <option value="letter_of_award">letter_of_award</option>
   <% } %>
   <% if (!imageList.contains("certificate_of_completion")) {%>
    <option value="certificate_of_completion">certificate_of_completion</option>
   <% } %>
   <% if (!imageList.contains("passport")) {%>
    <option value="passport">passport</option>
   <% } %>
   <% if (!imageList.contains("invoice")) {%>
    <option value="invoice">invoice</option>
   <% } %>
   <% if (!imageList.contains("bill_of_laden")) {%>
    <option value="bill_of_laden">bill_of_laden</option>
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