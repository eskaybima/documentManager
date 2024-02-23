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
                            String supplier = "";
                            List<String> supplierlist;
                            String street_address = "";
                            List<String> street_addresslist;
                            String city = "";
                            List<String> citylist;
                            String state = "";
                            List<String> statelist;
                            String ref_id;
                            List<String> imageList;
                            List<String> stateList;
                            List<String> countryList;
                            SaveToDb sb = new SaveToDb();
                            String template = "FORM_A08";
                            boolean isdocAvailable;
                        %>
                        <%
                            statelist = sb.getList2("select distinct param_value from param_values_FORM_A08 where parameter_name ='state' order by param_value asc ");
                            ref_id = (String) session.getAttribute("applicationId");
                            stateList = (List<String>) session.getAttribute("stateList");
                            imageList = (List<String>) session.getAttribute("imageList");
                            countryList = (List<String>) session.getAttribute("countryList");
                            //session.setAttribute("template", "FORM_A08.jsp");
                            if (imageList == null) {
                                imageList = new ArrayList<String>();
                            }
                            if ((String) request.getAttribute("offset") != null) {
                                supplier = (String) request.getAttribute("supplier");
                                street_address = (String) request.getAttribute("street_address");
                                city = (String) request.getAttribute("city");
                                state = (String) request.getAttribute("state");
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

                                                        <label class="control-label"><strong><%= ref_id%></strong>
                                                        </label>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-3 col-xs-12 control-label">SUPPLIER:</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
                                                        <input type="text" class="form-control" placeholder=" SUPPLIER" name="supplier" value="<%=supplier%>" id="supplier"  onchange="renderElseWhere('supplier', 'loghc')"/>
                                                        <%} else {%>
                                                        <select name="supplier" value="<%=supplier%>"   class="form-control select"  id="supplier" onchange="renderElseWhere('supplier', 'loghc')" />
                                                        <option value="<%=supplier%>"><%=supplier%></option>
                                                        <% for (int i = 0; i < supplierlist.size(); i++) {%>
                                                        <option value="<%=supplierlist.get(i)%>"><%=supplierlist.get(i)%></option>
                                                        <%}%>
                                                        </select>
                                                        <%}%>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-3 col-xs-12 control-label">STREET ADDRESS:</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
                                                        <input type="text" class="form-control" placeholder=" STREET ADDRESS" name="street_address" value="<%=street_address%>" id="street_address"  onchange="renderElseWhere('street_address', 'loghc')"/>
                                                        <%} else {%>
                                                        <select name="street_address" value="<%=street_address%>"   class="form-control select"  id="street_address" onchange="renderElseWhere('street_address', 'loghc')" />
                                                        <option value="<%=street_address%>"><%=street_address%></option>
                                                        <% for (int i = 0; i < street_addresslist.size(); i++) {%>
                                                        <option value="<%=street_addresslist.get(i)%>"><%=street_addresslist.get(i)%></option>
                                                        <%}%>
                                                        </select>
                                                        <%}%>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-md-3 col-xs-12 control-label">CITY:</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <% if (!("STRING".equalsIgnoreCase("DROP_DOWN"))) {%>
                                                        <input type="text" class="form-control" placeholder=" CITY" name="city" value="<%=city%>" id="city"  onchange="renderElseWhere('city', 'loghc')"/>
                                                        <%} else {%>
                                                        <select name="city" value="<%=city%>"   class="form-control select"  id="city" onchange="renderElseWhere('city', 'loghc')" />
                                                        <option value="<%=city%>"><%=city%></option>
                                                        <% for (int i = 0; i < citylist.size(); i++) {%>
                                                        <option value="<%=citylist.get(i)%>"><%=citylist.get(i)%></option>
                                                        <%}%>
                                                        </select>
                                                        <%}%>
                                                    </div>
                                                </div>
                                                    
                                                <div class="form-group">
                                                    <label class="col-md-3 col-xs-12 control-label">STATE:</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <% if (!("DROP_DOWN".equalsIgnoreCase("DROP_DOWN"))) {%>
                                                        <input type="text" class="form-control" placeholder=" STATE" name="state" value="<%=state%>" id="state"  onchange="renderElseWhere('state', 'loghc')"/>
                                                        <%} else {%>
                                                        <select name="state" value="<%=state%>"   class="form-control select"  id="state" onchange="renderElseWhere('state', 'loghc')" />
                                                        <option value="<%=state%>"><%=state%></option>
                                                        <% for (int i = 0; i < statelist.size(); i++) {%>
                                                        <option value="<%=statelist.get(i)%>"><%=statelist.get(i)%></option>
                                                        <%}%>
                                                        </select>
                                                        <%}%>
                                                    </div>
                                                </div>  

                                                <div class="form-group">
                                                    <label class="col-md-3 col-xs-12 control-label">SELECT DOCUMENT:</label>
                                                    <div class="col-md-6 col-xs-12">
                                                        <select type="text" class="form-control" name="jobType" value="" id="jobType" onchange="renderElseWhere6('jobType', 'loghc')" >
                                                        </select>
                                                    </div>
                                                </div> 

                                                <p id="loghc" style="height: 10px; display: none;"> </p>     
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
                                            </form>
                                        </div>
                                    </div>
                                    <script>
                                        function renderElseWhere(id, loc) {
                                            var paramValue = document.getElementById(id).value;
                                            var print = '<img src="${pageContext.request.contextPath}/Initiator?paramValue=' + paramValue + '&paramName=' + id + '&control=one";">';
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


                                </div>
                            </div>
                        </div>
