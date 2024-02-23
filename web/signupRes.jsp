

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
    
    <script type="text/javascript">
        $(function(){
            $(document).on('submit','loginForm',function(evt){
                evt.preventDefault();
                var passcode = $('#passcode').val();
                var confirm = $('#confirm').val();
                alert (passcode+' '+confirm); return false;
                if(passcode != confirm){
                    alert("Please re-enter your preferred pass phrase..."); return false;
                }
            });
        });
    </script>
    
    
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
			position: absolute;
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
		.algn{
			width: 85%;
			margin-left: 30px;
			margin-right: 0px;
		}
	</style>
        
        
    
    <body>
        <div class="page-container">
			<div class="row col-md-12" style="background: #29290e; padding-left: 25px;">
				<div class="pull-left col-md-4">
					<img src="source/img/logo_backUp.JPG" alt="logo" width="75%"/>
				</div>
				<div class="pull-right col-md-offset-4 col-md-4" style="padding-top: 20px;">
					<div class="col-md-12">
						<div class="col-md-4">
							<a class="brand" type="button" href="bir.html"><b class="fa fa-home"></b> HOME</a>
						</div>
						<div class="col-md-4">
							<a class="brand" type="button" href="Login.jsp"><b class="fa fa-sign-in"></b> SIGN IN</a>
						</div>
						<div class="col-md-4">
							<a class="brand" type="button" href="signup.jsp"><b class="fa fa-user-plus"></b> SIGN UP</a>
						</div>
					</div>
				</div>
			</div>
			<div class="row col-md-12" style="padding-top:150px">
				<div class="col-md-offset-2 col-md-8">
					<div class="col-md-12 login" style="padding-top:25px;">
						<div align="center">
							<i class="text1"><b class="fa fa-user-plus"></b> SIGN UP</i>
                                                </div><hr>
                                                <form id="loginForm" name='loginForm'  action="Login" class="form-horizontal" method="post">
						  <div class="form-group">
                                                      <div class="text1" align="center">
                                                           <%= (String)request.getAttribute("message")%> <a class="brand" href="${pageContext.request.contextPath}/bir.html"><span class="fa fa-desktop"></span> <span class="fa-text">HOME</span></a>
                                                      </div>
							</div><br/>
                                                    
                                                   
						</form>
					</div>
				</div>
			</div>
		</div>
    </body>
</html>
