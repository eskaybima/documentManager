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
String personal_details_of_traveller= "";
List<String> personal_details_of_travellerlist;
String title= "";
List<String> titlelist;
String first_name= "";
List<String> first_namelist;
String last_name= "";
List<String> last_namelist;
String middle_name= "";
List<String> middle_namelist;
String staff_id= "";
List<String> staff_idlist;
String department= "";
List<String> departmentlist;
String position_held= "";
List<String> position_heldlist;
String details_of_destination= "";
List<String> details_of_destinationlist;
String destination= "";
List<String> destinationlist;
String nature_of_trip= "";
List<String> nature_of_triplist;
String number_of_days_requested= "";
List<String> number_of_days_requestedlist;
String state= "";
List<String> statelist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "FORM_G10";
boolean isdocAvailable;
%>
<%
titlelist = sb.getList2("select distinct param_value from param_values_FORM_G10 where parameter_name ='title' order by param_value asc ");
departmentlist = sb.getList2("select distinct param_value from param_values_FORM_G10 where parameter_name ='department' order by param_value asc ");
nature_of_triplist = sb.getList2("select distinct param_value from param_values_FORM_G10 where parameter_name ='nature_of_trip' order by param_value asc ");
statelist = sb.getList2("select distinct param_value from param_values_FORM_G10 where parameter_name ='state' order by param_value asc ");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
personal_details_of_traveller= (String) request.getAttribute("personal_details_of_traveller");
title= (String) request.getAttribute("title");
first_name= (String) request.getAttribute("first_name");
last_name= (String) request.getAttribute("last_name");
middle_name= (String) request.getAttribute("middle_name");
staff_id= (String) request.getAttribute("staff_id");
department= (String) request.getAttribute("department");
position_held= (String) request.getAttribute("position_held");
details_of_destination= (String) request.getAttribute("details_of_destination");
destination= (String) request.getAttribute("destination");
nature_of_trip= (String) request.getAttribute("nature_of_trip");
number_of_days_requested= (String) request.getAttribute("number_of_days_requested");
state= (String) request.getAttribute("state");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>TRAVEL EXPENSE</h3><div class="clear"></div></div>
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
<div class="modal-header"><span class="h5 text-info"> PERSONAL DETAILS OF TRAVELLER</strong></span></div><br>
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
<label class="col-md-3 col-xs-12 control-label">FIRST NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" FIRST NAME" name="first_name" value="<%=first_name%>" id="first_name"  onchange="renderElseWhere('first_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">LAST NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" LAST NAME" name="last_name" value="<%=last_name%>" id="last_name"  onchange="renderElseWhere('last_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">MIDDLE NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" MIDDLE NAME" name="middle_name" value="<%=middle_name%>" id="middle_name"  onchange="renderElseWhere('middle_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STAFF ID:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" STAFF ID" name="staff_id" value="<%=staff_id%>" id="staff_id"  onchange="renderElseWhere('staff_id', 'loghc')"/>
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
<label class="col-md-3 col-xs-12 control-label">POSITION HELD:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" POSITION HELD" name="position_held" value="<%=position_held%>" id="position_held"  onchange="renderElseWhere('position_held', 'loghc')"/>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> DETAILS OF DESTINATION</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DESTINATION:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" DESTINATION" name="destination" value="<%=destination%>" id="destination"  onchange="renderElseWhere('destination', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NATURE OF TRIP:</label>
<div class="col-md-6 col-xs-12">
<select name="nature_of_trip" value="<%=nature_of_trip%>"   class="form-control select"  id="nature_of_trip" onchange="renderElseWhere('nature_of_trip', 'loghc')" />
<option value="<%=nature_of_trip%>"><%=nature_of_trip%></option>
<% for (int i = 0; i < nature_of_triplist.size(); i++) {%>
<option value="<%=nature_of_triplist.get(i)%>"><%=nature_of_triplist.get(i)%></option>
<%}%>
</select>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NUMBER OF DAYS REQUESTED:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" NUMBER OF DAYS REQUESTED" name="number_of_days_requested" value="<%=number_of_days_requested%>" id="number_of_days_requested"  onchange="renderElseWhere('number_of_days_requested', 'loghc')"/>
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