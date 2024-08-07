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
String goods_type= "";
List<String> goods_typelist;
String name_of_item= "";
List<String> name_of_itemlist;
String number= "";
List<String> numberlist;
String price_per_item= "";
List<String> price_per_itemlist;
String sales_officer_detail= "";
List<String> sales_officer_detaillist;
String staff_id= "";
List<String> staff_idlist;
String full_name= "";
List<String> full_namelist;
String department= "";
List<String> departmentlist;
String supervisor= "";
List<String> supervisorlist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "SALES_JOURNAL";
boolean isdocAvailable;
%>
<%
goods_typelist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='goods_type'");
name_of_itemlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='name_of_item'");
numberlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='number'");
price_per_itemlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='price_per_item'");
sales_officer_detaillist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='sales_officer_detail'");
staff_idlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='staff_id'");
full_namelist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='full_name'");
departmentlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='department'");
supervisorlist = sb.getList2("select param_value from param_values_SALES_JOURNAL where parameter_name ='supervisor'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "SALES_JOURNAL.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
goods_type= (String) request.getAttribute("goods_type");
name_of_item= (String) request.getAttribute("name_of_item");
number= (String) request.getAttribute("number");
price_per_item= (String) request.getAttribute("price_per_item");
sales_officer_detail= (String) request.getAttribute("sales_officer_detail");
staff_id= (String) request.getAttribute("staff_id");
full_name= (String) request.getAttribute("full_name");
department= (String) request.getAttribute("department");
supervisor= (String) request.getAttribute("supervisor");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
    <div class="panel panel-primary">   
<div class="panel-body">
    <div class="modal-header"><h2><strong>SALES JOURNAL</strong></h2><div class="clear"></div></div>
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


    <div class="panel-heading"> <span class="h5 text-info"><strong>GOODS TYPE</strong></span></div>
 
       
       <div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF ITEM:</label>
<div class="col-md-6 col-xs-12">
<% if (name_of_itemlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NAME OF ITEM" name="name_of_item" value="<%=name_of_item%>" id="name_of_item"  onchange="renderElseWhere('name_of_item', 'loghc')"/>
<%} else {%>
<select name="name_of_item" value="<%=name_of_item%>" id="name_of_item" onchange="renderElseWhere('name_of_item', 'loghc')" />
<option value="<%=name_of_item%>"><%=name_of_item%></option>
<% for (int i = 0; i < name_of_itemlist.size(); i++) {%>
<option value="<%=name_of_itemlist.get(i)%>"><%=name_of_itemlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>

<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NUMBER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NUMBER" name="number" value="<%=number%>" id="number"  onchange="renderElseWhere('number', 'loghc')"/>
<%} else {%>
<select name="number" value="<%=number%>" id="number" onchange="renderElseWhere('number', 'loghc')" />
<option value="<%=number%>"><%=number%></option>
<% for (int i = 0; i < numberlist.size(); i++) {%>
<option value="<%=numberlist.get(i)%>"><%=numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">PRICE PER ITEM:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (price_per_itemlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" PRICE PER ITEM" name="price_per_item" value="<%=price_per_item%>" id="price_per_item"  onchange="renderElseWhere('price_per_item', 'loghc')"/>
<%} else {%>
<select name="price_per_item" value="<%=price_per_item%>" id="price_per_item" onchange="renderElseWhere('price_per_item', 'loghc')" />
<option value="<%=price_per_item%>"><%=price_per_item%></option>
<% for (int i = 0; i < price_per_itemlist.size(); i++) {%>
<option value="<%=price_per_itemlist.get(i)%>"><%=price_per_itemlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div> 




<div class="modal-header"><span class="h5 text-info"><strong>SALES OFFICER DETAIL</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STAFF ID:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (staff_idlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" STAFF ID" name="staff_id" value="<%=staff_id%>" id="staff_id"  onchange="renderElseWhere('staff_id', 'loghc')"/>
<%} else {%>
<select name="staff_id" value="<%=staff_id%>" id="staff_id" onchange="renderElseWhere('staff_id', 'loghc')" />
<option value="<%=staff_id%>"><%=staff_id%></option>
<% for (int i = 0; i < staff_idlist.size(); i++) {%>
<option value="<%=staff_idlist.get(i)%>"><%=staff_idlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">FULL NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (full_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" FULL NAME" name="full_name" value="<%=full_name%>" id="full_name"  onchange="renderElseWhere('full_name', 'loghc')"/>
<%} else {%>
<select name="full_name" value="<%=full_name%>" id="full_name" onchange="renderElseWhere('full_name', 'loghc')" />
<option value="<%=full_name%>"><%=full_name%></option>
<% for (int i = 0; i < full_namelist.size(); i++) {%>
<option value="<%=full_namelist.get(i)%>"><%=full_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DEPARTMENT:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (departmentlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DEPARTMENT" name="department" value="<%=department%>" id="department"  onchange="renderElseWhere('department', 'loghc')"/>
<%} else {%>
<select name="department" value="<%=department%>" id="department" onchange="renderElseWhere('department', 'loghc')" />
<option value="<%=department%>"><%=department%></option>
<% for (int i = 0; i < departmentlist.size(); i++) {%>
<option value="<%=departmentlist.get(i)%>"><%=departmentlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SUPERVISOR:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (supervisorlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" SUPERVISOR" name="supervisor" value="<%=supervisor%>" id="supervisor"  onchange="renderElseWhere('supervisor', 'loghc')"/>
<%} else {%>
<select name="supervisor" value="<%=supervisor%>" id="supervisor" onchange="renderElseWhere('supervisor', 'loghc')" />
<option value="<%=supervisor%>"><%=supervisor%></option>
<% for (int i = 0; i < supervisorlist.size(); i++) {%>
<option value="<%=supervisorlist.get(i)%>"><%=supervisorlist.get(i)%></option>
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
   <% if (!imageList.contains("receipt")) {%>
    <option value="receipt">RECEIPT</option>
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