

<%@page import="com.fasyl.util.FormatAmount"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
		<link rel="stylesheet" type="text/css" id="theme" href="source/css/theme-light.css"/>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css"/>
		<title>BIR Ibadan</title>
		<script type="text/javascript" src="source/js/plugins/jquery/jquery.min.js"></script>
        <script type="text/javascript" src="source/js/plugins/jquery/jquery-ui.min.js"></script>
        <script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap.min.js"></script> 
		<script type="text/javascript" src="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.js"></script>
		<script type='text/javascript' src='source/js/plugins/icheck/icheck.min.js'></script>        
        <script type="text/javascript" src="source/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
        <script type="text/javascript" src="source/js/plugins/scrolltotop/scrolltopcontrol.js"></script>
		<script type="text/javascript" src="source/js/plugins/filetree/jqueryFileTree.js"></script>
		<script type="text/javascript" src="source/js/plugins/fileinput/fileinput.min.js"></script>
		<script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap-datepicker.js"></script>                
        <script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap-file-input.js"></script>
        <script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap-select.js"></script>
        <script type="text/javascript" src="source/js/plugins/tagsinput/jquery.tagsinput.min.js"></script>
		<script type="text/javascript" src="source/js/plugins.js"></script>        
        <script type="text/javascript" src="source/js/actions.js"></script>
		<script type='text/javascript' src='source/js/plugins/nvd3/nv.d3.min.js'></script>      
        <script type="text/javascript" src="source/js/plugins/morris/raphael-min.js"></script>
        <script type="text/javascript" src="source/js/plugins/morris/morris.min.js"></script>       
        <script type="text/javascript" src="source/js/plugins/rickshaw/d3.v3.js"></script>
        <script type="text/javascript" src="source/js/plugins/rickshaw/rickshaw.min.js"></script>
        <script type='text/javascript' src='source/js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js'></script>
        <script type='text/javascript' src='source/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js'></script>                
        <script type="text/javascript" src="source/js/plugins/owl/owl.carousel.min.js"></script>                 
        <script type="text/javascript" src="source/js/plugins/moment.min.js"></script>
        <script type="text/javascript" src="source/js/plugins/daterangepicker/daterangepicker.js"></script>
		<script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap-timepicker.min.js"></script>
		<script type='text/javascript' src='source/js/demo_charts_nvd3.js'></script> 
		<script type='text/javascript' src='source/js/demo_charts_morris.js'></script>        
		<script type="text/javascript" src="source/js/plugins/datatables/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/tableExport.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/jquery.base64.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/html2canvas.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/jspdf/libs/sprintf.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/jspdf/jspdf.js"></script>
		<script type="text/javascript" src="source/js/plugins/tableexport/jspdf/libs/base64.js"></script>
		<script type="text/javascript" src="source/js/plugins/jquery-validation/jquery.validate.js"></script>
		<script type="text/javascript" src="source/js/plugins/summernote/summernote.js"></script>
		<script type="text/javascript" src="source/js/plugins/dropzone/dropzone.min.js"></script>
		<script type="text/javascript" src="source/js/plugins/smartwizard/jquery.smartWizard-2.0.min.js"></script>
		<script type="text/javascript" src="source/js/plugins/fullcalendar/fullcalendar.min.js"></script>
	</head>
	<style>
		body  {
			background: url("source/img/wallpaper1.jpg");
			background-repeat: no-repeat;
			background-attachment: fixed;
			background-position: center;
			background-size: cover;
			-webkit-background-size: cover;
		}
		.login{
			z-index: 22;
			padding: 50px 50px 5px 50px;
			margin: 0 0 35px 0;
			background: rgba(0, 0, 0, 0.70);
			border: 1px solid rgba(156, 112, 112, 0.15);
		}
		.brand{
			color: #ecbd36;
		}
		a.brand{
			text-decoration: none;
			cursor: pointer;
			color: #ecbd36;
		}
		.text1{
			color: #ffffff;
			font-size: 16px;
		}
		.text2{
			color: #ffffff;
			font-size: 12px;
		}
		.buttonsize{
			color: #000000;
			width: 100%;
			height: 200px;
		}
	</style>
        
       <%!
        String user = "";
       %>
        
       <%
       user = (String)session.getAttribute("username");
       %>
	<body>
		<div class="page-container">
			<div class="row col-md-12" style="background: #29290e; padding-left: 25px;">
				<div class="pull-left col-md-4">
					<img src="source/img/logo_backUp.JPG" alt="logo" width="75%"/>
				</div>
				<div class="pull-right col-md-offset-4 col-md-4" style="padding-top: 20px;">
					<div class="col-md-12">
                                            <div class="col-md-4">
                                                <a href="registerAs.jsp" class="brand" type="button"><b class="fa fa-dashboard"></b> DASHBOARD</a>
                                            </div>
						<div class="col-md-4">
							<div class="dropdown">
								<a class="brand" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
									<b class="fa fa-list"></b> MENU
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
									<li><a href="individual.jsp"><b class="glyphicon glyphicon-minus"></b> Register Your Firm/Fill a Form</a></li>
									<li><a href="payment.jsp"><b class="glyphicon glyphicon-minus"></b> Pay Your Fees/Levies</a></li>
									<li><a href="receipts.jsp"><b class="glyphicon glyphicon-minus"></b> Obtain Your Fees/Levies Receipts</a></li>
								</ul>
							</div>
						</div>
						<div class="col-md-4">
							<div class="dropdown">
								<a class="brand" type="button" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
									<b class="fa fa-user"></b> PROFILE
									<span class="caret"></span>
								</a>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
									<li><a href="#"><b class="glyphicon glyphicon-minus"></b> Edit Profile</a></li>
									<li><a href="#"><b class="glyphicon glyphicon-minus"></b> Change Password</a></li>
									<li><a href="Login.jsp"><b class="glyphicon glyphicon-minus"></b> Sign Out</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
                    <div class="row">
                        &nbsp;
                    </div>
                    <div class="row" style="margin-top: 20px">
				<div class="col-md-3">
				<!-- START WIDGET REGISTRED -->
					<div class="widget widget-warning widget-item-icon" >
						<div class="widget-item-left">
							<span class="fa fa-money"></span>
						</div>
						<div class="widget-data">
                                                    <div class="widget-int num-count">N<%= FormatAmount.getPendingAmtForUser(user) %></div>
							<div class="widget-title">Total Amount Pending</div>
						</div>                           
					</div>                            
				<!-- END WIDGET REGISTRED -->
				</div>
				<div class="col-md-3">
				<!-- START WIDGET MESSAGES -->
					<div class="widget widget-success widget-item-icon">
						<div class="widget-item-left">
							<span class="fa fa-envelope"></span>
						</div>                             
						<div class="widget-data">
                                                    <div class="widget-int num-count"><%= FormatAmount.getNumberOfSubmissions(user) %></div>
							<div class="widget-title">No. of Submissions </div>
						</div> 
                                 
                               <li><a class="h4" href="${pageContext.request.contextPath}/MultiSearcher?SearchType=Search_by_param_group&beg=beg&responseDestination=/pages/detail_1.jsp&uploaded_by=<%=(String)session.getAttribute("username")%>" id="a"><Strong>View Details</Strong></a></li>                         
                                	</div>                            
				<!-- END WIDGET MESSAGES -->
				</div>
				<div class="col-md-3">
				<!-- START WIDGET MESSAGES -->
					<div class="widget widget-primary widget-item-icon">
						<div class="widget-item-left">
							<span class="fa fa-check-square-o"></span>
						</div>                             
						<div class="widget-data">
                                                    <div class="widget-int num-count"><%= FormatAmount.getNumberOfApproved(user) %></div>
							<div class="widget-title">No. of Approved Submissions</div>
						</div> 
                                                        <li><a class="h4" href="${pageContext.request.contextPath}/MultiSearcher?SearchType=Search_by_param_group&begin=beg&approved=yes&responseDestination=/pages/detail_1.jsp&uploaded_by=<%=(String)session.getAttribute("username")%>" id="a"><Strong>View Details</Strong></a></li>   
					</div>
				<!-- END WIDGET MESSAGES -->
				</div>
				<div class="col-md-3">
				<!-- START WIDGET CLOCK -->
					<div class="widget widget-danger widget-item-icon" >
						<div class="widget-item-left">
							<span class="fa fa-exclamation"></span>
						</div>
						<div class="widget-data">
                                                    <div class="widget-int num-count"><%= FormatAmount.getNumberOfDeclined(user) %></div>
							<div class="widget-title">No. of Rejected Submissions</div>
						</div>  
                                                         <li><a class="h4" href="${pageContext.request.contextPath}/MultiSearcher?begin=yes&control=one" id="a">View Details</a></li>
					</div>                     
				<!-- END WIDGET CLOCK -->
				</div>
			</div>
			<div class="row col-md-12" style="padding-top:25px">
				<div class="col-md-12 login" style="padding-top:25px;">
					<div align="center">
						<i class="text1"> MAIN MENU</i>
					</div><br/>
					<div class="row col-lg-12" style="padding-bottom:50px">
						<div class="col-lg-4">
							<a href="individual.jsp">
								<button class="btn-lg buttonsize">
									Register Your Firm/Fill a Form
								</button>
							</a>
						</div>
						<div class="col-lg-4">
							<a href="payment.jsp">
								<button class="btn-lg buttonsize">
									Pay Your Fees/Levies
								</button>
							</a>
						</div>
						<div class="col-lg-4">
							<a href="receipts.jsp">
								<button class="btn-lg buttonsize">
									Obtain Your Fees/Levies Receipts
								</button>
							</a>
						</div>
					</div>
				</div>
			</div>
                    <div class="row col-md-12 text-column-info" align="center" style="color: #fff; padding-top:100px">
				&copy; 2016 Board of Internal Revenue OYO STATE.
			</div>
		</div>
	</body>
</html>
