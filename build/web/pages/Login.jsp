<!DOCTYPE html>
<html lang="en">
<head>
    <!-- META SECTION -->
    <meta charset="UTF-8">
    <title>Document Management Solution </title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <!-- END META SECTION -->

    <link rel="stylesheet" type="text/css" href="projectresource/css/styles.css" media="screen" />
    <link rel="stylesheet" type="text/css" href="projectresource/css/superslides/superslides.css" media="screen" />
</head>
<body>
<div class="page-container">
    <div class="page-content">

        <div class="page-content-wrap">
            <div class="page-content-holder-orijo">
                <div class="jumbotron">
                    <div class="row">
                        <div class="col-md-offset-1 col-md-4 animated flipInX">
                            <div class="text-column text-column-centralized tex-column-icon-lg">
                                <div class="text-column-subtitle">
                                    <img src="img/fasyl-inner-logo.png" width="255" height="65" alt="Notap">
                                </div><br><br>
                                <div class="text-column-icon">
                                    <span class="fa fa-user"></span>
                                </div>
                                <h4>User Login </h4>
                            </div>
                        </div>
                        <div class="col-md-6 animated flipInY" style="border-left: 1px dotted #999;">
                             <form name='loginForm'  action="Login" class="form-horizontal" method="post">
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-8">
                                        <label class="control-label">Username:</label>
                                         <input type="text" class="form-control"  name='userName' required placeholder="Username"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-8">
                                        <label class="control-label">Password:</label>
                                        <input type="password" class="form-control"  name='password' required placeholder="Password"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-8">
                                        <label class="check"><input type="checkbox"  checked="checked"/> <b>Keep me loged in</b></label>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-6">
                                       
                                          <button class="btn btn-success btn-lg btn-block"> Login <span class="fa fa-play-circle-o"></span></button>
                                        
                                        
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-md-offset-1 col-md-4">
                                        <div class="login-subtitle">
                                            <a href="#"><i class="fa fa-meh-o"></i> Forgot your password?</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                             <%! String display = "";%>
                    <% request.setAttribute("validate", "true");
                            if (request.getAttribute("message") != null) {%>
                            <a onclick="hide('loginMessage')" id="loginMessage">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=request.getAttribute("message")%></a>
                    <%}%>
                            <script>
                                function hide(element){
                                    document.getElementById(element).style.display="none";
                                    
                                }
                            </script>
                
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-offset-4 col-md-10">
                        <div class="text-column-info">
                             &copy; 2019 FASYL TECHNOLOGY GROUP
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- ./page content -->
</div>

<script type="text/javascript" src="projectresource/js/plugins/jquery/jquery.min.js"></script>
<script type="text/javascript" src="projectresource/js/plugins/jquery/jquery-ui.min.js"></script>
<script type="text/javascript" src="projectresource/js/plugins/bootstrap/bootstrap.min.js"></script>
<script type="text/javascript" src="projectresource/js/plugins/scrolltotop/scrolltopcontrol.js"></script>
<script type='text/javascript' src='projectresource/js/plugins/icheck/icheck.min.js'></script>
<script type="text/javascript" src="projectresource/js/NotapApp.js"></script>
<script>
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-green',
        radioClass: 'iradio_square-green',
        increaseArea: '20%'
    });
</script>
</body>
</html>