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
<script language="JavaScript" src="resources/javaScript/extFile.js"></script>
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
String item_description= "";
List<String> item_descriptionlist;
String item_name= "";
List<String> item_namelist;
String quantity_requested= "";
List<String> quantity_requestedlist;
String other_relevant_info= "";
List<String> other_relevant_infolist;
String information_about_requester= "";
List<String> information_about_requesterlist;
String title= "";
List<String> titlelist;
String full_names= "";
List<String> full_nameslist;
String department= "";
List<String> departmentlist;
String address_street= "";
List<String> address_streetlist;
String address_city= "";
List<String> address_citylist;
String state= "";
List<String> statelist;
String documents= "";
List<String> documentslist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "FORM_AA1";
boolean isdocAvailable;
%>
<%
titlelist = sb.getList2("select distinct param_value from param_values_FORM_AA1 where parameter_name ='title' order by param_value asc ");
departmentlist = sb.getList2("select distinct param_value from param_values_FORM_AA1 where parameter_name ='department' order by param_value asc ");
address_citylist = sb.getList2("select distinct param_value from param_values_FORM_AA1 where parameter_name ='address_city' order by param_value asc ");
statelist = sb.getList2("select distinct param_value from param_values_FORM_AA1 where parameter_name ='state' order by param_value asc ");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
item_description= (String) request.getAttribute("item_description");
item_name= (String) request.getAttribute("item_name");
quantity_requested= (String) request.getAttribute("quantity_requested");
other_relevant_info= (String) request.getAttribute("other_relevant_info");
information_about_requester= (String) request.getAttribute("information_about_requester");
title= (String) request.getAttribute("title");
full_names= (String) request.getAttribute("full_names");
department= (String) request.getAttribute("department");
address_street= (String) request.getAttribute("address_street");
address_city= (String) request.getAttribute("address_city");
state= (String) request.getAttribute("state");
documents= (String) request.getAttribute("documents");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>ITEM REQUEST</h3><div class="clear"></div></div>
<form class="form-horizontal">
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">Reference ID:</label>
<div class="col-md-6 col-xs-12">
<div class="input-group">
<label class="control-label"><strong><%= ref_id%></strong>
</label>
</div>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> ITEM DESCRIPTION</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ITEM NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" ITEM NAME" name="item_name" value="<%=item_name%>" id="item_name"  onchange="renderElseWhere('item_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">QUANTITY REQUESTED:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" QUANTITY REQUESTED" name="quantity_requested" value="<%=quantity_requested%>" id="quantity_requested"  onchange="renderElseWhere('quantity_requested', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">OTHER RELEVANT INFO:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" OTHER RELEVANT INFO" name="other_relevant_info" value="<%=other_relevant_info%>" id="other_relevant_info"  onchange="renderElseWhere('other_relevant_info', 'loghc')"/>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> INFORMATION ABOUT REQUESTER</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TITLE:</label>
<div class="col-md-6 col-xs-12">
<select name="title" value="<%=title%>"   class="form-control select"  id="title" onchange="renderElseWhere('title', 'loghc')" />
<option value="<%=title%>"><%=title%></option>
<% for (int i = 0; i < titlelist.size(); i++) {%>
<option value="<%=titlelist.get(i)%>"><%=titlelist.get(i)%></option>
<%}%>
</select>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">FULL NAMES:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" FULL NAMES" name="full_names" value="<%=full_names%>" id="full_names"  onchange="renderElseWhere('full_names', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DEPARTMENT:</label>
<div class="col-md-6 col-xs-12">
<select name="department" value="<%=department%>"   class="form-control select"  id="department" onchange="renderElseWhere('department', 'loghc')" />
<option value="<%=department%>"><%=department%></option>
<% for (int i = 0; i < departmentlist.size(); i++) {%>
<option value="<%=departmentlist.get(i)%>"><%=departmentlist.get(i)%></option>
<%}%>
</select>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS STREET:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" ADDRESS STREET" name="address_street" value="<%=address_street%>" id="address_street"  onchange="renderElseWhere('address_street', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS CITY:</label>
<div class="col-md-6 col-xs-12">
<select name="address_city" value="<%=address_city%>"   class="form-control select"  id="address_city" onchange="renderElseWhere('address_city', 'loghc')" />
<option value="<%=address_city%>"><%=address_city%></option>
<% for (int i = 0; i < address_citylist.size(); i++) {%>
<option value="<%=address_citylist.get(i)%>"><%=address_citylist.get(i)%></option>
<%}%>
</select>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STATE:</label>
<div class="col-md-6 col-xs-12">
<select name="state" value="<%=state%>"   class="form-control select"  id="state" onchange="renderElseWhere('state', 'loghc')" />
<option value="<%=state%>"><%=state%></option>
<% for (int i = 0; i < statelist.size(); i++) {%>
<option value="<%=statelist.get(i)%>"><%=statelist.get(i)%></option>
<%}%>
</select>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> DOCUMENTS</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
<div class="col-md-6 col-xs-12">
 <select type="text" class="form-control" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" />
</select>
</div>
</div>
<table class="table table-striped table-bordered table-hover" id="applDocuments">
<thead>
<tr>
<th width="30%"><span class="fa fa-file"></span> Document Type</th>
<th width="40%"><span class="fa fa-eye"></span> View</th>
<th width="30%"><span class="fa fa-trash-o"></span> Delete</th>
</tr>
</thead>
</table>
<div class="well well-sm" id="fileUploadDiv">
<div class="text-primary h5"><span class="fa fa-cloud-upload"></span> File Upload</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">File Section:</label>
<div class="col-md-3 col-xs-12" id="select-controller">
<input type="file" class="fileinput btn-default" name="file0" id="file-select"   title="Choose File From Disk"/>
</div>
<div class="col-md-3 col-xs-12">
<button  class="btn btn-success" id="upload-button"><span class="fa fa-upload"></span> Upload</button>
</div>
</div>
</div>
</form>
<div class="row">
<div class="col-md-15">
<div class="panel panel-default">
<div class="panel-body panel-body-table">
<div class="table-responsive">

<form action ="${pageContext.request.contextPath}/ImageUpload" method="post">
<table class="table">
<td>
<input type ="hidden" name ="template"  value ="<%=template%>">
<input type ="hidden" name ="done"  value ="yes">
</td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>

<td>
<div class="col-md-3 col-xs-12">
<Button class="btn btn-success" type="submit"><span class="fa fa-send-o"></span> Submit</Button>
</div>
</td>
</table>
</form>
</div>
</div>
</div>
</div>
</div>
<p id="loghc" style="height: 10px; display: none;"> </p>
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
</script></div></div></div>