<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
		<link rel="stylesheet" type="text/css" id="theme" href="source/css/theme-light.css"/>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/t/dt/dt-1.10.11/datatables.min.css"/>
		<title>BIR Ibadan</title>
		<link rel="icon" href="source/img/bg.png" type="image/x-icon" />
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
        <script type="text/javascript" src="source/js/actions.js"></script><script type='text/javascript' src='js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js'></script>
        <script type='text/javascript' src='source/js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js'></script>                
        <script type="text/javascript" src="source/js/plugins/owl/owl.carousel.min.js"></script>                 
        <script type="text/javascript" src="source/js/plugins/moment.min.js"></script>
        <script type="text/javascript" src="source/js/plugins/daterangepicker/daterangepicker.js"></script>
		<script type="text/javascript" src="source/js/plugins/bootstrap/bootstrap-timepicker.min.js"></script>
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
		.regForm{
			z-index: 22;
			position: absolute;
			padding: 50px 50px 5px 50px;
			background: rgba(255, 255, 255, 0.70);
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
			color: #000000;
			font-size: 16px;
		}
		.text2{
			color: #ffffff;
			font-size: 12px;
		}
		.text3{
			font-size: 12px;
		}
		.buttonsize{
			color: #000000;
			width: 100%;
			height: 200px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			
		});
	</script>
        
        <%!
        List<String[]> list;
        SaveToDb sb = new SaveToDb();
        String user_id;
        %>
        
        <%
         user_id = (String)session.getAttribute("username");
        list = sb.getListss("select id, tax_type, amount, pay_date, trans_id from fas_int_revenue where user_id = '" + user_id + "'", 5);
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
									<li><a href="receipts.html"><b class="glyphicon glyphicon-minus"></b> Obtain Your Fees/Levies Receipts</a></li>
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
			<div class="row col-md-12" style="padding-top:50px">
				<div class="col-md-offset-1 col-md-10 regForm" style="padding-top:25px;">
					<div align="center">
						<i class="text1">PAYMENT CERTIFICATES AND RECEIPTS</i>
					</div><hr>
					<div class="row col-md-12" style="padding-bottom:50px">
						<table class="datatable text3">
							<thead>
								<tr>
									<!--<th width="10%">S/No.</th>  -->
									<th width="30%"> Fee/Levy Description</th>
									<th width="15%"> Amount Due </th>
									<th width="15%"> Amount Paid </th>
									<th width="20%"> Payment Date </th>
									<th width="5%"> </th>
									<th width="5%"> </th>
								</tr>
							</thead>
							<tbody>
                                                     
                                                  <% for (int i = 0; i < list.size(); i++) {  
                                                  String[] amts = sb.getListStringArray("select amount, amount_pending from tax_record where trans_id = '" + list.get(i)[4] + "'", 2);
                                                  %>          
								<tr>
                                                                        <td><%= list.get(i)[1]%></td><input type ="hidden" name ="desc">
                                                                        <td><%= amts[0] %></td> <input type ="hidden" name ="amtDue"> 
									<td><%= list.get(i)[2]%></td><input type ="hidden" name ="amtPd">
									<td><%= list.get(i)[3]%></td><input type ="hidden" name ="payDate">
                                                                        <td><a type="button" href="receiptDetails.jsp?amtPd=<%=list.get(i)[2]%>&payDate=<%=list.get(i)[3]%>&amtDue=<%=amts[0]%>&bal=<%=amts[1]%>"class="btn btn-xs btn-primary">View</a></td>
                                                                        <td><a type="button" href="downloadReceipt.jsp?amtPd=<%=list.get(i)[2]%>&payDate=<%=list.get(i)[3]%>&amtDue=<%=amts[0]%>&bal=<%=amts[1]%>&desc=<%=list.get(i)[1]%>"class="btn btn-xs btn-primary">Download</a></td>
                                                               </tr>
                                                  <% } %>      
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>    
	</body>
</html>
