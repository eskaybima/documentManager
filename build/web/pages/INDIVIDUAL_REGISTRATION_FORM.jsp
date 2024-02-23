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
String house_numner= "";
List<String> house_numnerlist;
String street_name= "";
List<String> street_namelist;
String name_of_area= "";
List<String> name_of_arealist;
String town= "";
List<String> townlist;
String local_govt= "";
List<String> local_govtlist;
String state= "";
List<String> statelist;
String country= "";
List<String> countrylist;
String email= "";
List<String> emaillist;
String postal_address= "";
List<String> postal_addresslist;
String employment_status= "";
List<String> employment_statuslist;
String employers_name= "";
List<String> employers_namelist;
String employers_business= "";
List<String> employers_businesslist;
String business_name= "";
List<String> business_namelist;
String nature_of_business= "";
List<String> nature_of_businesslist;
String address_of_business= "";
List<String> address_of_businesslist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "INDIVIDUAL_REGISTRATION_FORM";
boolean isdocAvailable;
%>
<%
titlelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='title'");
surnamelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='surname'");
other_nameslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='other_names'");
house_numnerlist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='house_numner'");
street_namelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='street_name'");
name_of_arealist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='name_of_area'");
townlist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='town'");
local_govtlist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='local_govt'");
statelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='state'");
countrylist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='country'");
emaillist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='email'");
postal_addresslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='postal_address'");
employment_statuslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='employment_status'");
employers_namelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='employers_name'");
employers_businesslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='employers_business'");
business_namelist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='business_name'");
nature_of_businesslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='nature_of_business'");
address_of_businesslist = sb.getList2("select param_value from param_values_INDIVIDUAL_REGISTRATION_FORM where parameter_name ='address_of_business'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "INDIVIDUAL_REGISTRATION_FORM.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
title= (String) request.getAttribute("title");
surname= (String) request.getAttribute("surname");
other_names= (String) request.getAttribute("other_names");
house_numner= (String) request.getAttribute("house_numner");
street_name= (String) request.getAttribute("street_name");
name_of_area= (String) request.getAttribute("name_of_area");
town= (String) request.getAttribute("town");
local_govt= (String) request.getAttribute("local_govt");
state= (String) request.getAttribute("state");
country= (String) request.getAttribute("country");
email= (String) request.getAttribute("email");
postal_address= (String) request.getAttribute("postal_address");
employment_status= (String) request.getAttribute("employment_status");
employers_name= (String) request.getAttribute("employers_name");
employers_business= (String) request.getAttribute("employers_business");
business_name= (String) request.getAttribute("business_name");
nature_of_business= (String) request.getAttribute("nature_of_business");
address_of_business= (String) request.getAttribute("address_of_business");
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
<label class="col-md-3 col-xs-12 control-label">HOUSE NUMNER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (house_numnerlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" HOUSE NUMNER" name="house_numner" value="<%=house_numner%>" id="house_numner"  onchange="renderElseWhere('house_numner', 'loghc')"/>
<%} else {%>
<select name="house_numner" value="<%=house_numner%>" id="house_numner" onchange="renderElseWhere('house_numner', 'loghc')" />
<option value="<%=house_numner%>"><%=house_numner%></option>
<% for (int i = 0; i < house_numnerlist.size(); i++) {%>
<option value="<%=house_numnerlist.get(i)%>"><%=house_numnerlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STREET NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (street_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" STREET NAME" name="street_name" value="<%=street_name%>" id="street_name"  onchange="renderElseWhere('street_name', 'loghc')"/>
<%} else {%>
<select name="street_name" value="<%=street_name%>" id="street_name" onchange="renderElseWhere('street_name', 'loghc')" />
<option value="<%=street_name%>"><%=street_name%></option>
<% for (int i = 0; i < street_namelist.size(); i++) {%>
<option value="<%=street_namelist.get(i)%>"><%=street_namelist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">LOCAL GOVT:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (local_govtlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" LOCAL GOVT" name="local_govt" value="<%=local_govt%>" id="local_govt"  onchange="renderElseWhere('local_govt', 'loghc')"/>
<%} else {%>
<select name="local_govt" value="<%=local_govt%>" id="local_govt" onchange="renderElseWhere('local_govt', 'loghc')" />
<option value="<%=local_govt%>"><%=local_govt%></option>
<% for (int i = 0; i < local_govtlist.size(); i++) {%>
<option value="<%=local_govtlist.get(i)%>"><%=local_govtlist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">COUNTRY:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (countrylist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" COUNTRY" name="country" value="<%=country%>" id="country"  onchange="renderElseWhere('country', 'loghc')"/>
<%} else {%>
<select name="country" value="<%=country%>" id="country" onchange="renderElseWhere('country', 'loghc')" />
<option value="<%=country%>"><%=country%></option>
<% for (int i = 0; i < countrylist.size(); i++) {%>
<option value="<%=countrylist.get(i)%>"><%=countrylist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMAIL:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (emaillist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" EMAIL" name="email" value="<%=email%>" id="email"  onchange="renderElseWhere('email', 'loghc')"/>
<%} else {%>
<select name="email" value="<%=email%>" id="email" onchange="renderElseWhere('email', 'loghc')" />
<option value="<%=email%>"><%=email%></option>
<% for (int i = 0; i < emaillist.size(); i++) {%>
<option value="<%=emaillist.get(i)%>"><%=emaillist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">BUSINESS NAME:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (business_namelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" BUSINESS NAME" name="business_name" value="<%=business_name%>" id="business_name"  onchange="renderElseWhere('business_name', 'loghc')"/>
<%} else {%>
<select name="business_name" value="<%=business_name%>" id="business_name" onchange="renderElseWhere('business_name', 'loghc')" />
<option value="<%=business_name%>"><%=business_name%></option>
<% for (int i = 0; i < business_namelist.size(); i++) {%>
<option value="<%=business_namelist.get(i)%>"><%=business_namelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NATURE OF BUSINESS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (nature_of_businesslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NATURE OF BUSINESS" name="nature_of_business" value="<%=nature_of_business%>" id="nature_of_business"  onchange="renderElseWhere('nature_of_business', 'loghc')"/>
<%} else {%>
<select name="nature_of_business" value="<%=nature_of_business%>" id="nature_of_business" onchange="renderElseWhere('nature_of_business', 'loghc')" />
<option value="<%=nature_of_business%>"><%=nature_of_business%></option>
<% for (int i = 0; i < nature_of_businesslist.size(); i++) {%>
<option value="<%=nature_of_businesslist.get(i)%>"><%=nature_of_businesslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">ADDRESS OF BUSINESS:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (address_of_businesslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" ADDRESS OF BUSINESS" name="address_of_business" value="<%=address_of_business%>" id="address_of_business"  onchange="renderElseWhere('address_of_business', 'loghc')"/>
<%} else {%>
<select name="address_of_business" value="<%=address_of_business%>" id="address_of_business" onchange="renderElseWhere('address_of_business', 'loghc')" />
<option value="<%=address_of_business%>"><%=address_of_business%></option>
<% for (int i = 0; i < address_of_businesslist.size(); i++) {%>
<option value="<%=address_of_businesslist.get(i)%>"><%=address_of_businesslist.get(i)%></option>
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