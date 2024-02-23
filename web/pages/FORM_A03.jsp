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
String item_id= "";
List<String> item_idlist;
String quantity_purchased= "";
List<String> quantity_purchasedlist;
String quantity_returned= "";
List<String> quantity_returnedlist;
String qunatity_price= "";
List<String> qunatity_pricelist;
String amount_refundable= "";
List<String> amount_refundablelist;
String sold_by= "";
List<String> sold_by_list;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "FORM_A03";
boolean isdocAvailable;
%>
<%
sold_by_list = sb.getList2("select distinct param_value from param_values_FORM_A03 where parameter_name ='sold_by_' order by param_value asc ");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
item_id= (String) request.getAttribute("item_id");
quantity_purchased= (String) request.getAttribute("quantity_purchased");
quantity_returned= (String) request.getAttribute("quantity_returned");
qunatity_price= (String) request.getAttribute("qunatity_price");
amount_refundable= (String) request.getAttribute("amount_refundable");
sold_by= (String) request.getAttribute("sold_by");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>RETURN GOODS</h3><div class="clear"></div></div>
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
<label class="col-md-3 col-xs-12 control-label">ITEM ID:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" ITEM ID" name="item_id" value="<%=item_id%>" id="item_id"  onchange="renderElseWhere('item_id', 'loghc')"/>
<%} else {%>
<select name="item_id" value="<%=item_id%>"   class="form-control select"  id="item_id" onchange="renderElseWhere('item_id', 'loghc')" />
<option value="<%=item_id%>"><%=item_id%></option>
<% for (int i = 0; i < item_idlist.size(); i++) {%>
<option value="<%=item_idlist.get(i)%>"><%=item_idlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">QUANTITY PURCHASED:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" QUANTITY PURCHASED" name="quantity_purchased" value="<%=quantity_purchased%>" id="quantity_purchased"  onchange="renderElseWhere('quantity_purchased', 'loghc')"/>
<%} else {%>
<select name="quantity_purchased" value="<%=quantity_purchased%>"   class="form-control select"  id="quantity_purchased" onchange="renderElseWhere('quantity_purchased', 'loghc')" />
<option value="<%=quantity_purchased%>"><%=quantity_purchased%></option>
<% for (int i = 0; i < quantity_purchasedlist.size(); i++) {%>
<option value="<%=quantity_purchasedlist.get(i)%>"><%=quantity_purchasedlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">QUANTITY RETURNED:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" QUANTITY RETURNED" name="quantity_returned" value="<%=quantity_returned%>" id="quantity_returned"  onchange="renderElseWhere('quantity_returned', 'loghc')"/>
<%} else {%>
<select name="quantity_returned" value="<%=quantity_returned%>"   class="form-control select"  id="quantity_returned" onchange="renderElseWhere('quantity_returned', 'loghc')" />
<option value="<%=quantity_returned%>"><%=quantity_returned%></option>
<% for (int i = 0; i < quantity_returnedlist.size(); i++) {%>
<option value="<%=quantity_returnedlist.get(i)%>"><%=quantity_returnedlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">QUNATITY PRICE:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" QUNATITY PRICE" name="qunatity_price" value="<%=qunatity_price%>" id="qunatity_price"  onchange="renderElseWhere('qunatity_price', 'loghc')"/>
<%} else {%>
<select name="qunatity_price" value="<%=qunatity_price%>"   class="form-control select"  id="qunatity_price" onchange="renderElseWhere('qunatity_price', 'loghc')" />
<option value="<%=qunatity_price%>"><%=qunatity_price%></option>
<% for (int i = 0; i < qunatity_pricelist.size(); i++) {%>
<option value="<%=qunatity_pricelist.get(i)%>"><%=qunatity_pricelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">AMOUNT REFUNDABLE:</label>
<div class="col-md-6 col-xs-12">
<% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" AMOUNT REFUNDABLE" name="amount_refundable" value="<%=amount_refundable%>" id="amount_refundable"  onchange="renderElseWhere('amount_refundable', 'loghc')"/>
<%} else {%>
<select name="amount_refundable" value="<%=amount_refundable%>"   class="form-control select"  id="amount_refundable" onchange="renderElseWhere('amount_refundable', 'loghc')" />
<option value="<%=amount_refundable%>"><%=amount_refundable%></option>
<% for (int i = 0; i < amount_refundablelist.size(); i++) {%>
<option value="<%=amount_refundablelist.get(i)%>"><%=amount_refundablelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SOLD BY :</label>
<div class="col-md-6 col-xs-12">
<% if (!("DROP_DOWN".equalsIgnoreCase("DROP_DOWN"))) {%>
<input type="text" class="form-control" placeholder=" SOLD BY " name="sold_by" value="<%=sold_by%>" id="sold_by"  onchange="renderElseWhere('sold_by', 'loghc')"/>
<%} else {%>
<select name="sold_by" value="<%=sold_by%>"   class="form-control select"  id="sold_by" onchange="renderElseWhere('sold_by', 'loghc')" />
<option value="<%=sold_by%>"><%=sold_by%></option>
<% for (int i = 0; i < sold_by_list.size(); i++) {%>
<option value="<%=sold_by_list.get(i)%>"><%=sold_by_list.get(i)%></option>
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
   <% if (!imageList.contains("original_receipt")) {%>
    <option value="original_receipt">ORIGINAL RECEIPT</option>
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