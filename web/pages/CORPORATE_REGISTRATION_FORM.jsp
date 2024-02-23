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
String name_of_institution= "";
List<String> name_of_institutionlist;
String rc_number= "";
List<String> rc_numberlist;
String industry_sector= "";
List<String> industry_sectorlist;
String house_number= "";
List<String> house_numberlist;
String street_name= "";
List<String> street_namelist;
String town= "";
List<String> townlist;
String local_government= "";
List<String> local_governmentlist;
String state= "";
List<String> statelist;
String country= "";
List<String> countrylist;
String postal_address= "";
List<String> postal_addresslist;
String website= "";
List<String> websitelist;
String email= "";
List<String> emaillist;
String telephone_number= "";
List<String> telephone_numberlist;
String number_of_staff= "";
List<String> number_of_stafflist;
String name_of_contact_person= "";
List<String> name_of_contact_personlist;
String designation_of_contact= "";
List<String> designation_of_contactlist;
String contact_phone_number= "";
List<String> contact_phone_numberlist;
String contact_email= "";
List<String> contact_emaillist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "CORPORATE_REGISTRATION_FORM";
boolean isdocAvailable;
%>
<%
name_of_institutionlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='name_of_institution'");
rc_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='rc_number'");
industry_sectorlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='industry_sector'");
house_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='house_number'");
street_namelist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='street_name'");
townlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='town'");
local_governmentlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='local_government'");
statelist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='state'");
countrylist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='country'");
postal_addresslist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='postal_address'");
websitelist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='website'");
emaillist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='email'");
telephone_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='telephone_number'");
number_of_stafflist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='number_of_staff'");
name_of_contact_personlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='name_of_contact_person'");
designation_of_contactlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='designation_of_contact'");
contact_phone_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='contact_phone_number'");
contact_emaillist = sb.getList2("select param_value from param_values_CORPORATE_REGISTRATION_FORM where parameter_name ='contact_email'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "CORPORATE_REGISTRATION_FORM.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
name_of_institution= (String) request.getAttribute("name_of_institution");
rc_number= (String) request.getAttribute("rc_number");
industry_sector= (String) request.getAttribute("industry_sector");
house_number= (String) request.getAttribute("house_number");
street_name= (String) request.getAttribute("street_name");
town= (String) request.getAttribute("town");
local_government= (String) request.getAttribute("local_government");
state= (String) request.getAttribute("state");
country= (String) request.getAttribute("country");
postal_address= (String) request.getAttribute("postal_address");
website= (String) request.getAttribute("website");
email= (String) request.getAttribute("email");
telephone_number= (String) request.getAttribute("telephone_number");
number_of_staff= (String) request.getAttribute("number_of_staff");
name_of_contact_person= (String) request.getAttribute("name_of_contact_person");
designation_of_contact= (String) request.getAttribute("designation_of_contact");
contact_phone_number= (String) request.getAttribute("contact_phone_number");
contact_email= (String) request.getAttribute("contact_email");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel-body tab-content"><div class="modal-header"><h3>CORPORATE REGISTRATION FORM</h3><div class="clear"></div></div>
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
<label class="col-md-3 col-xs-12 control-label">NAME OF INSTITUTION:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (name_of_institutionlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NAME OF INSTITUTION" name="name_of_institution" value="<%=name_of_institution%>" id="name_of_institution"  onchange="renderElseWhere('name_of_institution', 'loghc')"/>
<%} else {%>
<select name="name_of_institution" value="<%=name_of_institution%>" id="name_of_institution" onchange="renderElseWhere('name_of_institution', 'loghc')" />
<option value="<%=name_of_institution%>"><%=name_of_institution%></option>
<% for (int i = 0; i < name_of_institutionlist.size(); i++) {%>
<option value="<%=name_of_institutionlist.get(i)%>"><%=name_of_institutionlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">RC NUMBER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (rc_numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" RC NUMBER" name="rc_number" value="<%=rc_number%>" id="rc_number"  onchange="renderElseWhere('rc_number', 'loghc')"/>
<%} else {%>
<select name="rc_number" value="<%=rc_number%>" id="rc_number" onchange="renderElseWhere('rc_number', 'loghc')" />
<option value="<%=rc_number%>"><%=rc_number%></option>
<% for (int i = 0; i < rc_numberlist.size(); i++) {%>
<option value="<%=rc_numberlist.get(i)%>"><%=rc_numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">INDUSTRY SECTOR:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (industry_sectorlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" INDUSTRY SECTOR" name="industry_sector" value="<%=industry_sector%>" id="industry_sector"  onchange="renderElseWhere('industry_sector', 'loghc')"/>
<%} else {%>
<select name="industry_sector" value="<%=industry_sector%>" id="industry_sector" onchange="renderElseWhere('industry_sector', 'loghc')" />
<option value="<%=industry_sector%>"><%=industry_sector%></option>
<% for (int i = 0; i < industry_sectorlist.size(); i++) {%>
<option value="<%=industry_sectorlist.get(i)%>"><%=industry_sectorlist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">LOCAL GOVERNMENT:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (local_governmentlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" LOCAL GOVERNMENT" name="local_government" value="<%=local_government%>" id="local_government"  onchange="renderElseWhere('local_government', 'loghc')"/>
<%} else {%>
<select name="local_government" value="<%=local_government%>" id="local_government" onchange="renderElseWhere('local_government', 'loghc')" />
<option value="<%=local_government%>"><%=local_government%></option>
<% for (int i = 0; i < local_governmentlist.size(); i++) {%>
<option value="<%=local_governmentlist.get(i)%>"><%=local_governmentlist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">WEBSITE:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (websitelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" WEBSITE" name="website" value="<%=website%>" id="website"  onchange="renderElseWhere('website', 'loghc')"/>
<%} else {%>
<select name="website" value="<%=website%>" id="website" onchange="renderElseWhere('website', 'loghc')" />
<option value="<%=website%>"><%=website%></option>
<% for (int i = 0; i < websitelist.size(); i++) {%>
<option value="<%=websitelist.get(i)%>"><%=websitelist.get(i)%></option>
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
<label class="col-md-3 col-xs-12 control-label">TELEPHONE NUMBER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (telephone_numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" TELEPHONE NUMBER" name="telephone_number" value="<%=telephone_number%>" id="telephone_number"  onchange="renderElseWhere('telephone_number', 'loghc')"/>
<%} else {%>
<select name="telephone_number" value="<%=telephone_number%>" id="telephone_number" onchange="renderElseWhere('telephone_number', 'loghc')" />
<option value="<%=telephone_number%>"><%=telephone_number%></option>
<% for (int i = 0; i < telephone_numberlist.size(); i++) {%>
<option value="<%=telephone_numberlist.get(i)%>"><%=telephone_numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NUMBER OF STAFF:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (number_of_stafflist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NUMBER OF STAFF" name="number_of_staff" value="<%=number_of_staff%>" id="number_of_staff"  onchange="renderElseWhere('number_of_staff', 'loghc')"/>
<%} else {%>
<select name="number_of_staff" value="<%=number_of_staff%>" id="number_of_staff" onchange="renderElseWhere('number_of_staff', 'loghc')" />
<option value="<%=number_of_staff%>"><%=number_of_staff%></option>
<% for (int i = 0; i < number_of_stafflist.size(); i++) {%>
<option value="<%=number_of_stafflist.get(i)%>"><%=number_of_stafflist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF CONTACT PERSON:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (name_of_contact_personlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NAME OF CONTACT PERSON" name="name_of_contact_person" value="<%=name_of_contact_person%>" id="name_of_contact_person"  onchange="renderElseWhere('name_of_contact_person', 'loghc')"/>
<%} else {%>
<select name="name_of_contact_person" value="<%=name_of_contact_person%>" id="name_of_contact_person" onchange="renderElseWhere('name_of_contact_person', 'loghc')" />
<option value="<%=name_of_contact_person%>"><%=name_of_contact_person%></option>
<% for (int i = 0; i < name_of_contact_personlist.size(); i++) {%>
<option value="<%=name_of_contact_personlist.get(i)%>"><%=name_of_contact_personlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DESIGNATION OF CONTACT:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (designation_of_contactlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DESIGNATION OF CONTACT" name="designation_of_contact" value="<%=designation_of_contact%>" id="designation_of_contact"  onchange="renderElseWhere('designation_of_contact', 'loghc')"/>
<%} else {%>
<select name="designation_of_contact" value="<%=designation_of_contact%>" id="designation_of_contact" onchange="renderElseWhere('designation_of_contact', 'loghc')" />
<option value="<%=designation_of_contact%>"><%=designation_of_contact%></option>
<% for (int i = 0; i < designation_of_contactlist.size(); i++) {%>
<option value="<%=designation_of_contactlist.get(i)%>"><%=designation_of_contactlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">CONTACT PHONE NUMBER:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (contact_phone_numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" CONTACT PHONE NUMBER" name="contact_phone_number" value="<%=contact_phone_number%>" id="contact_phone_number"  onchange="renderElseWhere('contact_phone_number', 'loghc')"/>
<%} else {%>
<select name="contact_phone_number" value="<%=contact_phone_number%>" id="contact_phone_number" onchange="renderElseWhere('contact_phone_number', 'loghc')" />
<option value="<%=contact_phone_number%>"><%=contact_phone_number%></option>
<% for (int i = 0; i < contact_phone_numberlist.size(); i++) {%>
<option value="<%=contact_phone_numberlist.get(i)%>"><%=contact_phone_numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">CONTACT EMAIL:</label>
<div class="col-md-6 col-xs-12">
 <div class="input-group">
<span class="input-group-addon"><span class="fa fa-barcode"></span></span>
<% if (contact_emaillist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" CONTACT EMAIL" name="contact_email" value="<%=contact_email%>" id="contact_email"  onchange="renderElseWhere('contact_email', 'loghc')"/>
<%} else {%>
<select name="contact_email" value="<%=contact_email%>" id="contact_email" onchange="renderElseWhere('contact_email', 'loghc')" />
<option value="<%=contact_email%>"><%=contact_email%></option>
<% for (int i = 0; i < contact_emaillist.size(); i++) {%>
<option value="<%=contact_emaillist.get(i)%>"><%=contact_emaillist.get(i)%></option>
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