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
String name_and_sector= "";
List<String> name_and_sectorlist;
String name_of_institution= "";
List<String> name_of_institutionlist;
String rc_number= "";
List<String> rc_numberlist;
String industry_sector= "";
List<String> industry_sectorlist;
String office_location_and_contact= "";
List<String> office_location_and_contactlist;
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
String telephone= "";
List<String> telephonelist;
String staff_strength= "";
List<String> staff_strengthlist;
String no._nigerian_staff= "";
List<String> no._nigerian_stafflist;
String no._foreigners= "";
List<String> no._foreignerslist;
String no._contract_staff= "";
List<String> no._contract_stafflist;
String directors_or_proprietors= "";
List<String> directors_or_proprietorslist;
String dir_1= "";
List<String> dir_1list;
String dir_2= "";
List<String> dir_2list;
String dir_3= "";
List<String> dir_3list;
String dir_4= "";
List<String> dir_4list;
String dir_5= "";
List<String> dir_5list;
String dir_6= "";
List<String> dir_6list;
String contact_person_= "";
List<String> contact_person_list;
String full_name= "";
List<String> full_namelist;
String phone_number= "";
List<String> phone_numberlist;
String designation= "";
List<String> designationlist;
String date= "";
List<String> datelist;
String ref_id;
List<String> imageList;
List<String> stateList;
List<String> countryList;
SaveToDb sb = new SaveToDb();
String template = "CORPORATE_REG_";
boolean isdocAvailable;
%>
<%
name_and_sectorlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='name_and_sector'");
name_of_institutionlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='name_of_institution'");
rc_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='rc_number'");
industry_sectorlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='industry_sector'");
office_location_and_contactlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='office_location_and_contact'");
house_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='house_number'");
street_namelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='street_name'");
townlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='town'");
local_governmentlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='local_government'");
statelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='state'");
countrylist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='country'");
postal_addresslist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='postal_address'");
websitelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='website'");
emaillist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='email'");
telephonelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='telephone'");
staff_strengthlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='staff_strength'");
no._nigerian_stafflist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='no._nigerian_staff'");
no._foreignerslist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='no._foreigners'");
no._contract_stafflist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='no._contract_staff'");
directors_or_proprietorslist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='directors_or_proprietors'");
dir_1list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_1'");
dir_2list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_2'");
dir_3list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_3'");
dir_4list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_4'");
dir_5list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_5'");
dir_6list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='dir_6'");
contact_person_list = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='contact_person_'");
full_namelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='full_name'");
phone_numberlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='phone_number'");
designationlist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='designation'");
datelist = sb.getList2("select param_value from param_values_CORPORATE_REG_ where parameter_name ='date'");
ref_id = (String) session.getAttribute("applicationId");
stateList = (List<String>) session.getAttribute("stateList");
imageList = (List<String>) session.getAttribute("imageList");
countryList = (List<String>) session.getAttribute("countryList");
session.setAttribute("template", "CORPORATE_REG_.jsp");
 if (imageList == null){ imageList = new ArrayList<String>();}
if ((String) request.getAttribute("offset") != null) {
name_and_sector= (String) request.getAttribute("name_and_sector");
name_of_institution= (String) request.getAttribute("name_of_institution");
rc_number= (String) request.getAttribute("rc_number");
industry_sector= (String) request.getAttribute("industry_sector");
office_location_and_contact= (String) request.getAttribute("office_location_and_contact");
house_number= (String) request.getAttribute("house_number");
street_name= (String) request.getAttribute("street_name");
town= (String) request.getAttribute("town");
local_government= (String) request.getAttribute("local_government");
state= (String) request.getAttribute("state");
country= (String) request.getAttribute("country");
postal_address= (String) request.getAttribute("postal_address");
website= (String) request.getAttribute("website");
email= (String) request.getAttribute("email");
telephone= (String) request.getAttribute("telephone");
staff_strength= (String) request.getAttribute("staff_strength");
no._nigerian_staff= (String) request.getAttribute("no._nigerian_staff");
no._foreigners= (String) request.getAttribute("no._foreigners");
no._contract_staff= (String) request.getAttribute("no._contract_staff");
directors_or_proprietors= (String) request.getAttribute("directors_or_proprietors");
dir_1= (String) request.getAttribute("dir_1");
dir_2= (String) request.getAttribute("dir_2");
dir_3= (String) request.getAttribute("dir_3");
dir_4= (String) request.getAttribute("dir_4");
dir_5= (String) request.getAttribute("dir_5");
dir_6= (String) request.getAttribute("dir_6");
contact_person_= (String) request.getAttribute("contact_person_");
full_name= (String) request.getAttribute("full_name");
phone_number= (String) request.getAttribute("phone_number");
designation= (String) request.getAttribute("designation");
date= (String) request.getAttribute("date");
}
%>
<div class="page-content-wrap">
<div class="row">
<div class="col-md-offset-1 col-md-10">
<div class="panel panel-primary">
<div class="panel-body"><div class="modal-header"><h3>CORPORATE REGISTRATION FORM </h3><div class="clear"></div></div>
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
<div class="modal-header"><span class="h5 text-info">"+ parameters.get(i).getParameterName() +"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NAME OF INSTITUTION:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">RC NUMBER:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">INDUSTRY SECTOR:</label>
<div class="col-md-6 col-xs-12">
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
<div class="modal-header"><span class="h5 text-info">"+ parameters.get(i).getParameterName() +"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">HOUSE NUMBER:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STREET NAME:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TOWN:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">LOCAL GOVERNMENT:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">STATE:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">COUNTRY:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">POSTAL ADDRESS:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">WEBSITE:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">EMAIL:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">TELEPHONE:</label>
<div class="col-md-6 col-xs-12">
<% if (telephonelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" TELEPHONE" name="telephone" value="<%=telephone%>" id="telephone"  onchange="renderElseWhere('telephone', 'loghc')"/>
<%} else {%>
<select name="telephone" value="<%=telephone%>" id="telephone" onchange="renderElseWhere('telephone', 'loghc')" />
<option value="<%=telephone%>"><%=telephone%></option>
<% for (int i = 0; i < telephonelist.size(); i++) {%>
<option value="<%=telephonelist.get(i)%>"><%=telephonelist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="modal-header"><span class="h5 text-info">"+ parameters.get(i).getParameterName() +"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NO. NIGERIAN STAFF:</label>
<div class="col-md-6 col-xs-12">
<% if (no._nigerian_stafflist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NO. NIGERIAN STAFF" name="no._nigerian_staff" value="<%=no._nigerian_staff%>" id="no._nigerian_staff"  onchange="renderElseWhere('no._nigerian_staff', 'loghc')"/>
<%} else {%>
<select name="no._nigerian_staff" value="<%=no._nigerian_staff%>" id="no._nigerian_staff" onchange="renderElseWhere('no._nigerian_staff', 'loghc')" />
<option value="<%=no._nigerian_staff%>"><%=no._nigerian_staff%></option>
<% for (int i = 0; i < no._nigerian_stafflist.size(); i++) {%>
<option value="<%=no._nigerian_stafflist.get(i)%>"><%=no._nigerian_stafflist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NO. FOREIGNERS:</label>
<div class="col-md-6 col-xs-12">
<% if (no._foreignerslist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NO. FOREIGNERS" name="no._foreigners" value="<%=no._foreigners%>" id="no._foreigners"  onchange="renderElseWhere('no._foreigners', 'loghc')"/>
<%} else {%>
<select name="no._foreigners" value="<%=no._foreigners%>" id="no._foreigners" onchange="renderElseWhere('no._foreigners', 'loghc')" />
<option value="<%=no._foreigners%>"><%=no._foreigners%></option>
<% for (int i = 0; i < no._foreignerslist.size(); i++) {%>
<option value="<%=no._foreignerslist.get(i)%>"><%=no._foreignerslist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">NO. CONTRACT STAFF:</label>
<div class="col-md-6 col-xs-12">
<% if (no._contract_stafflist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" NO. CONTRACT STAFF" name="no._contract_staff" value="<%=no._contract_staff%>" id="no._contract_staff"  onchange="renderElseWhere('no._contract_staff', 'loghc')"/>
<%} else {%>
<select name="no._contract_staff" value="<%=no._contract_staff%>" id="no._contract_staff" onchange="renderElseWhere('no._contract_staff', 'loghc')" />
<option value="<%=no._contract_staff%>"><%=no._contract_staff%></option>
<% for (int i = 0; i < no._contract_stafflist.size(); i++) {%>
<option value="<%=no._contract_stafflist.get(i)%>"><%=no._contract_stafflist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="modal-header"><span class="h5 text-info">"+ parameters.get(i).getParameterName() +"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 1:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_1list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 1" name="dir_1" value="<%=dir_1%>" id="dir_1"  onchange="renderElseWhere('dir_1', 'loghc')"/>
<%} else {%>
<select name="dir_1" value="<%=dir_1%>" id="dir_1" onchange="renderElseWhere('dir_1', 'loghc')" />
<option value="<%=dir_1%>"><%=dir_1%></option>
<% for (int i = 0; i < dir_1list.size(); i++) {%>
<option value="<%=dir_1list.get(i)%>"><%=dir_1list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 2:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_2list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 2" name="dir_2" value="<%=dir_2%>" id="dir_2"  onchange="renderElseWhere('dir_2', 'loghc')"/>
<%} else {%>
<select name="dir_2" value="<%=dir_2%>" id="dir_2" onchange="renderElseWhere('dir_2', 'loghc')" />
<option value="<%=dir_2%>"><%=dir_2%></option>
<% for (int i = 0; i < dir_2list.size(); i++) {%>
<option value="<%=dir_2list.get(i)%>"><%=dir_2list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 3:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_3list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 3" name="dir_3" value="<%=dir_3%>" id="dir_3"  onchange="renderElseWhere('dir_3', 'loghc')"/>
<%} else {%>
<select name="dir_3" value="<%=dir_3%>" id="dir_3" onchange="renderElseWhere('dir_3', 'loghc')" />
<option value="<%=dir_3%>"><%=dir_3%></option>
<% for (int i = 0; i < dir_3list.size(); i++) {%>
<option value="<%=dir_3list.get(i)%>"><%=dir_3list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 4:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_4list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 4" name="dir_4" value="<%=dir_4%>" id="dir_4"  onchange="renderElseWhere('dir_4', 'loghc')"/>
<%} else {%>
<select name="dir_4" value="<%=dir_4%>" id="dir_4" onchange="renderElseWhere('dir_4', 'loghc')" />
<option value="<%=dir_4%>"><%=dir_4%></option>
<% for (int i = 0; i < dir_4list.size(); i++) {%>
<option value="<%=dir_4list.get(i)%>"><%=dir_4list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 5:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_5list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 5" name="dir_5" value="<%=dir_5%>" id="dir_5"  onchange="renderElseWhere('dir_5', 'loghc')"/>
<%} else {%>
<select name="dir_5" value="<%=dir_5%>" id="dir_5" onchange="renderElseWhere('dir_5', 'loghc')" />
<option value="<%=dir_5%>"><%=dir_5%></option>
<% for (int i = 0; i < dir_5list.size(); i++) {%>
<option value="<%=dir_5list.get(i)%>"><%=dir_5list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DIR 6:</label>
<div class="col-md-6 col-xs-12">
<% if (dir_6list.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DIR 6" name="dir_6" value="<%=dir_6%>" id="dir_6"  onchange="renderElseWhere('dir_6', 'loghc')"/>
<%} else {%>
<select name="dir_6" value="<%=dir_6%>" id="dir_6" onchange="renderElseWhere('dir_6', 'loghc')" />
<option value="<%=dir_6%>"><%=dir_6%></option>
<% for (int i = 0; i < dir_6list.size(); i++) {%>
<option value="<%=dir_6list.get(i)%>"><%=dir_6list.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="modal-header"><span class="h5 text-info">"+ parameters.get(i).getParameterName() +"</strong></span></div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">FULL NAME:</label>
<div class="col-md-6 col-xs-12">
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
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">PHONE NUMBER:</label>
<div class="col-md-6 col-xs-12">
<% if (phone_numberlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" PHONE NUMBER" name="phone_number" value="<%=phone_number%>" id="phone_number"  onchange="renderElseWhere('phone_number', 'loghc')"/>
<%} else {%>
<select name="phone_number" value="<%=phone_number%>" id="phone_number" onchange="renderElseWhere('phone_number', 'loghc')" />
<option value="<%=phone_number%>"><%=phone_number%></option>
<% for (int i = 0; i < phone_numberlist.size(); i++) {%>
<option value="<%=phone_numberlist.get(i)%>"><%=phone_numberlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DESIGNATION:</label>
<div class="col-md-6 col-xs-12">
<% if (designationlist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DESIGNATION" name="designation" value="<%=designation%>" id="designation"  onchange="renderElseWhere('designation', 'loghc')"/>
<%} else {%>
<select name="designation" value="<%=designation%>" id="designation" onchange="renderElseWhere('designation', 'loghc')" />
<option value="<%=designation%>"><%=designation%></option>
<% for (int i = 0; i < designationlist.size(); i++) {%>
<option value="<%=designationlist.get(i)%>"><%=designationlist.get(i)%></option>
<%}%>
</select>
<%}%>
</div>
</div>
<div class="form-group">
<label class="col-md-3 col-xs-12 control-label">DATE:</label>
<div class="col-md-6 col-xs-12">
<% if (datelist.isEmpty()) {%>
<input type="text" class="form-control" placeholder=" DATE" name="date" value="<%=date%>" id="date"  onchange="renderElseWhere('date', 'loghc')"/>
<%} else {%>
<select name="date" value="<%=date%>" id="date" onchange="renderElseWhere('date', 'loghc')" />
<option value="<%=date%>"><%=date%></option>
<% for (int i = 0; i < datelist.size(); i++) {%>
<option value="<%=datelist.get(i)%>"><%=datelist.get(i)%></option>
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