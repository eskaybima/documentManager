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
String request_for_tissues= "";
List<String> request_for_tissueslist;
String strore_name= "";
List<String> strore_namelist;
String date_of_request= "";
List<String> date_of_requestlist;
String total_number= "";
List<String> total_numberlist;
String requester= "";
List<String> requesterlist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "REQUEST_FOR_TISSUES";
boolean isdocAvailable;
%>
<%
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
request_for_tissues= (String) request.getAttribute("request_for_tissues");
strore_name= (String) request.getAttribute("strore_name");
date_of_request= (String) request.getAttribute("date_of_request");
total_number= (String) request.getAttribute("total_number");
requester= (String) request.getAttribute("requester");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>TOILET ROLL REQUEST</h3><div class="clear"></div></div>
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
<div class="modal-header"><span class="h5 text-info"> REQUEST FOR TISSUES</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STRORE NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" STRORE NAME" name="strore_name" value="<%=strore_name%>" id="strore_name"  onchange="renderElseWhere('strore_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DATE OF REQUEST:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control datepicker" placeholder=" DATE OF REQUEST" name="date_of_request" value="<%=date_of_request%>" id="date_of_request"  onchange="renderElseWhere('date_of_request', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TOTAL NUMBER:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" TOTAL NUMBER" name="total_number" value="<%=total_number%>" id="total_number"  onchange="renderElseWhere('total_number', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">REQUESTER:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" REQUESTER" name="requester" value="<%=requester%>" id="requester"  onchange="renderElseWhere('requester', 'loghc')"/>
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