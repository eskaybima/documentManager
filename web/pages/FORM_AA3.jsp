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
String supplier_information= "";
List<String> supplier_informationlist;
String company_name= "";
List<String> company_namelist;
String address_street= "";
List<String> address_streetlist;
String city= "";
List<String> citylist;
String state= "";
List<String> statelist;
String date_of_establishment= "";
List<String> date_of_establishmentlist;
String diesel_info= "";
List<String> diesel_infolist;
String volume_in_litres= "";
List<String> volume_in_litreslist;
String amount_per_litre= "";
List<String> amount_per_litrelist;
String total_amount= "";
List<String> total_amountlist;
String expected_date_of_delivery= "";
List<String> expected_date_of_deliverylist;
String documents= "";
List<String> documentslist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "FORM_AA3";
boolean isdocAvailable;
%>
<%
citylist = sb.getList2("select distinct param_value from param_values_FORM_AA3 where parameter_name ='city' order by param_value asc ");
statelist = sb.getList2("select distinct param_value from param_values_FORM_AA3 where parameter_name ='state' order by param_value asc ");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
supplier_information= (String) request.getAttribute("supplier_information");
company_name= (String) request.getAttribute("company_name");
address_street= (String) request.getAttribute("address_street");
city= (String) request.getAttribute("city");
state= (String) request.getAttribute("state");
date_of_establishment= (String) request.getAttribute("date_of_establishment");
diesel_info= (String) request.getAttribute("diesel_info");
volume_in_litres= (String) request.getAttribute("volume_in_litres");
amount_per_litre= (String) request.getAttribute("amount_per_litre");
total_amount= (String) request.getAttribute("total_amount");
expected_date_of_delivery= (String) request.getAttribute("expected_date_of_delivery");
documents= (String) request.getAttribute("documents");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>DIESEL REQUEST</h3><div class="clear"></div></div>
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
<div class="modal-header"><span class="h5 text-info"> SUPPLIER INFORMATION</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">COMPANY NAME:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" COMPANY NAME" name="company_name" value="<%=company_name%>" id="company_name"  onchange="renderElseWhere('company_name', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS STREET:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" ADDRESS STREET" name="address_street" value="<%=address_street%>" id="address_street"  onchange="renderElseWhere('address_street', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">CITY:</label>
<div class="col-md-6 col-xs-12">
<select name="city" value="<%=city%>"   class="form-control select"  id="city" onchange="renderElseWhere('city', 'loghc')" />
<option value="<%=city%>"><%=city%></option>
<% for (int i = 0; i < citylist.size(); i++) {%>
<option value="<%=citylist.get(i)%>"><%=citylist.get(i)%></option>
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DATE OF ESTABLISHMENT:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control datepicker" placeholder=" DATE OF ESTABLISHMENT" name="date_of_establishment" value="<%=date_of_establishment%>" id="date_of_establishment"  onchange="renderElseWhere('date_of_establishment', 'loghc')"/>
</div>
</div>
<div class="modal-header"><span class="h5 text-info"> DIESEL INFO</strong></span></div><br>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">VOLUME IN LITRES:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" VOLUME IN LITRES" name="volume_in_litres" value="<%=volume_in_litres%>" id="volume_in_litres"  onchange="renderElseWhere('volume_in_litres', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">AMOUNT PER LITRE:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" AMOUNT PER LITRE" name="amount_per_litre" value="<%=amount_per_litre%>" id="amount_per_litre"  onchange="renderElseWhere('amount_per_litre', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TOTAL AMOUNT:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control" placeholder=" TOTAL AMOUNT" name="total_amount" value="<%=total_amount%>" id="total_amount"  onchange="renderElseWhere('total_amount', 'loghc')"/>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EXPECTED DATE OF DELIVERY:</label>
<div class="col-md-6 col-xs-12">
<input type="text" class="form-control datepicker" placeholder=" EXPECTED DATE OF DELIVERY" name="expected_date_of_delivery" value="<%=expected_date_of_delivery%>" id="expected_date_of_delivery"  onchange="renderElseWhere('expected_date_of_delivery', 'loghc')"/>
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