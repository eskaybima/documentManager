

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
        .regForm{
            z-index: 22;
            position: absolute;
            padding: 50px 50px 5px 50px;
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
    
      <script type="text/javascript">
        $(function () {

            $('#forms').hide();

            $('#payForm').change(function () {
                $('#forms').show(400);
            });

            $(document).on('submit', '#formSubmit', function (evt) {
                evt.preventDefault();
                var amtPaid, amtDue, payForm, taxType, trans_id;

                amtPaid = Number($('#amtPaid').val());
                amtDue = Number($('#amtDue').val());
                taxType = ($('#taxType').val());
                trans_id = ($('#trans_id').val());
                
                payForm = $('#payForm').val();
                //alert(amtPaid+' '+amtDue); return false;

                if (amtPaid == "") {
                    $('#incomplete').modal(200);
                }
                else if (amtPaid < amtDue) {
                    var x = amtDue - amtPaid;
                    $('#alertOne').modal(200);
                    document.getElementById("due").innerHTML = "N" + '' + x;
                } else if (amtPaid > amtDue) {
                    var x = amtPaid - amtDue;
                    $('#alertTwo').modal(200);
                    document.getElementById("surplus").innerHTML = "N" + '' + x;
                } else {
                    //Passing Servelet code here...
                    $.ajax({
                        url: "submitReceipt",
                        data: {start: amtPaid, end: taxType, id: trans_id, RememberMe: false},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                              alert(JSON.stringify(data))
                            var result = $.trim(data);
                            alert(result);
                            if (result == 'Success') {

                                $.notify("Payment  was succesfully paid!", "Successs");

                            } else {
                                alert('Receipt Payment Failed');
                            }   // End of Grid show ()
                        },
                        //If there was no resonse from the server
                        error: function (xhr, status, error) {
                            //    alert("Error Occured")

                        }
                        ,
                        //capture the request before it was sent to server
                        beforeSend: function (jqXHR, settings) {

                            // alert("Processing Request")
                        },
                        complete: function (jqXHR, textStatus) {
                            $('#success').modal(200);
                        }

                    });

                }

                $('#proceed').click(function () {
                    var x = amtDue - amtPaid;

                    //Passing Servelet code here...
                    $.ajax({
                        url: "submitReceipt",
                        data: {start: amtPaid, end: taxType, id: trans_id, RememberMe: false},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            //  alert(JSON.stringify(data))
                            var result = $.trim(data);
                            alert(result);
                            if (result == 'Success') {

                                $.notify("Payment  was succesfully paid!", "Successs");

                            } else {

                                alert('Receipt Payment Failed');

                            }   // End of Grid show ()
                        },
                        //If there was no resonse from the server
                        error: function (xhr, status, error) {
                            //    alert("Error Occured")

                        }
                        ,
                        //capture the request before it was sent to server
                        beforeSend: function (jqXHR, settings) {

                            // alert("Processing Request")
                        },
                        complete: function (jqXHR, textStatus) {
                            $('#alertThree').modal(200);
                            document.getElementById("due1").innerHTML = "N" + '' + x;
                        }

                    });


                });

                $('#proceed2').click(function () {
                    var x = amtPaid - amtDue;

                    //Passing Servelet code here...
                    $.ajax({
                        url: "submitReceipt",
                        data: {start: amtPaid, end: taxType, id: trans_id, RememberMe: false},
                        dataType: "json",
                        type: "POST",
                        success: function (data) {
                            //  alert(JSON.stringify(data))
                            var result = $.trim(data);
                            alert(result);
                            if (result == 'Success') {

                                $.notify("Payment  was succesfully paid!", "Successs");

                            } else {

                                alert('Receipt Payment Failed');

                            }   // End of Grid show ()
                        },
                        //If there was no resonse from the server
                        error: function (xhr, status, error) {
                            //    alert("Error Occured")

                        }
                        ,
                        //capture the request before it was sent to server
                        beforeSend: function (jqXHR, settings) {

                            // alert("Processing Request")
                        },
                        complete: function (jqXHR, textStatus) {
                            $('#alertFour').modal(200);
                            document.getElementById("surplus1").innerHTML = "N" + '' + x;
                        }

                    });


                });
            });

        });
    </script> 
  
    
    <script>
     var amtdu ;   
     var tax_type;
     var trans_id;
     var raw_data;
        function getAmount(amountSelected) {
       raw_data =  document.getElementById(amountSelected).value;
       var l = raw_data.length;
       var n = raw_data.indexOf("kk");
       var j = raw_data.indexOf("jj");
       amtdu = raw_data.substring(0, n);
       tax_type = raw_data.substring(n, j);
       trans_id =  raw_data.substring(j, l);
       document.getElementById("amtDue").value = amtdu;
       document.getElementById("taxType").value = tax_type;
       document.getElementById("trans_id").value = trans_id;
    //return document.getElementById(amtSelected).value;
} </script>
    
    <%!
    List<String[]> list;
    SaveToDb sb = new SaveToDb();
    String payform;
    String amtDue;
    %>
    
    <%
    list = sb.getListss("select tax_type, amount_pending, trans_id from tax_record where status = 'pending' and user_id = '" + (String)session.getAttribute("username")  + "'", 3);
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
            <div class="row col-md-12" style="padding-top:50px">
                <div class="col-md-offset-2 col-md-8 regForm" style="padding-top:25px;">
                    <div align="center">
                        <i class="text1">PAYMENT FORM</i>
                    </div><hr>
                        <div class="col-md-offset-3 col-md-6">
                            <select class="form-control select" id="payForm" name="payForm" value="" onchange="getAmount('payForm')"  data-live-search="true">
                                                                    <option value="">Select Tax Type</option>
                                                                    <%   for (int i = 0; i < list.size(); i++) {
                                                                        String val =list.get(i)[1];
                                                                        if (val.contains(".")){
                                                                            val = list.get(i)[1].substring(0, (list.get(i)[1].length() - 3));
                                                                        }
                                                                        val = val.replace(",", "");
                                                                    %>
                                                                    <option value="<%=val %>kk<%=list.get(i)[0].replace(" ", "_")%>jj<%=list.get(i)[2]%>"><%=list.get(i)[0]%>&nbsp;<%=list.get(i)[1] %></option>
                                                                    <%}%>
                                                                    </select>
                                                                </div> 
                        <div class="row col-md-12" style="padding-top: 50px; padding-bottom:50px">
                            <form action="payProcess.html" class="fform-horizontal" method="post" id="formSubmit" enctype="multipart/form-data">
                                <div id="forms">
                                    <div class="col-md-12">
                                        <div class="col-md-offset-1 col-md-4">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon text-mutex">
                                                        <i> Due Date</i>
                                                    </span>
                                                    <input type="text" name="dateDue" id="dateDue" class="form-control" width="85%" placeholder="03-08-2016" disabled="disabled"/>
                                                    <input type="hidden" name="taxType" id="taxType" value="taxType"/>
                                                    <input type="hidden" name="trans_id" id="trans_id" value="0"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-2">
                                            &nbsp;
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon text-mutex">
                                                     AMOUNT   
                                                    </span>
                                                    <input type="hidden" class="form-control" width="85%" placeholder='' disabled="disabled"/>
                                                    <input type="text" name="amtDue" id="amtDue"  value="0" width="85%" disabled="disabled"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div><br/><br/><br/><br/>
                                    <div class="col-md-12">
                                        <div class="col-md-offset-4 col-md-4">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon text-mutex">
                                                        <i> Amount Being Paid</i>
                                                    </span>
                                                    <input type="number" class="form-control" width="85%" id="amtPaid" name="amtPaid"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div><br/><br/><br/><br/>
                                <div class="row">
                                    <div class="col-md-offset-5 col-md-2">
                                        <button type="submit" class="btn btn-sm btn-primary btn-block"> Submit Payment </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="alertOne" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-danger">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-default" align="center"> WARNING!</h4>
                    </div>
                    <div class="modal-body">
                        <h5 class="text-danger" align="center">
                            <span>
                                PAYMENT AMOUNT IS LESS THAN DUE AMOUNT BY <span id="due" style="color: #29290e; font-weight: bold;"></span><br/><br/>
                                <p>
                                    Do you want to proceed with your payment?
                                </p>
                            </span>
                        </h5><hr>
                            <div class="col-md-offset-9" align="right">
                                <a href="#" id="proceed" class="btn btn-xs btn-primary"><b class="glyphicon glyphicon-ok"></b> Yes</a>
                                <a href="#" data-dismiss="modal" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-remove"></b> No</a>
                            </div>
                    </div>
                </div>
            </div>
        </div>  
        <div class="modal fade" id="alertTwo" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-default" align="center"> ALERT!</h4>
                    </div>
                    <div class="modal-body">
                        <h5 class="text-danger" align="center">
                            <span>
                                PAYMENT AMOUNT EXCEEDED DUE AMOUNT BY <span id="surplus" style="color: #29290e; font-weight: bold"></span><br/><br/>
                                <p>
                                    Do you wish to continue?
                                </p>
                            </span>
                        </h5><hr>
                            <div class="col-md-offset-9" align="right">
                                <a href="#" id="proceed2" class="btn btn-xs btn-primary"><b class="glyphicon glyphicon-ok"></b> Yes</a>
                                <a href="#" data-dismiss="modal" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-remove"></b> No</a>
                            </div>
                    </div>
                </div>
            </div>
        </div> 
        <div class="modal fade" id="incomplete" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-default">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-danger" align="center"> PROCESSING ERROR!</h4>
                    </div><br/><br/>
                    <div class="modal-body">
                        <h5 class="text-primary" align="center"> Please indicate the AMOUNT BEING PAID.</h5><hr>
                            <div class="col-md-offset-6" align="right">
                                <a href="#" data-dismiss="modal" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-ok"></b> Ok</a>
                            </div>
                    </div>
                </div>
            </div>
        </div>  
        <div class="modal fade" id="success" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-default">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-danger" align="center"> PAYMENT SUCCESSFUL!</h4>
                    </div><br/><br/>
                    <div class="modal-body">
                        <h5 class="text-primary" align="center"> Your Payment has been acknowledged. Thank you!</h5><hr>
                            <div class="col-md-offset-6" align="right">
                                <a href="payment.jsp" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-ok"></b> Ok</a>
                                <a href="receiptDetails.html" class="btn btn-xs btn-primary"><b class="glyphicon glyphicon-eye"></b> Generate Receipt</a>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="alertThree" tabindex="-1" aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-primary">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-default" align="center"> PAYMENT SUCCESSFUL!</h4>
                    </div>
                    <div class="modal-body">
                        <h5 class="text-primary" align="center">
                            <span>
                                PAYMENT HAS BEEN ACKNOWLEDGED.<br/><br/>
                                <p>
                                    Your Due Balance is <span id="due1" style="color: #29290e; font-weight: bold;"></span>.
                                </p><br/>
                                <p>
                                    Ensure that the above Balance is paid promptly, Thank you.
                                </p>
                            </span>
                        </h5><hr>
                            <div class="col-md-offset-6" align="right">
                                <a href="payment.jsp" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-ok"></b> Ok</a>
                                <a href="receiptDetails.html" class="btn btn-xs btn-primary"><b class="glyphicon glyphicon-eye"></b> Generate Receipt</a>
                            </div>
                    </div>
                </div>
            </div>
        </div> 
        <div class="modal fade" id="alertFour" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header bg-warning">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                        <h4 class="modal-title text-default" align="center"> PAYMENT SUCCESSFUL!</h4>
                    </div>
                    <div class="modal-body">
                        <h5 class="text-danger" align="center">
                            <span>
                                PAYMENT HAS BEEN ACKNOWLEDGED.<br/><br/>
                                <p>
                                    Your Payment is in excess of <span id="surplus1" style="color: #29290e; font-weight: bold"></span>.
                                </p><br/>
                                <p>
                                    We appreciate your compliance, Thank you.
                                </p>
                            </span>
                        </h5><hr>
                            <div class="col-md-offset-6" align="right">
                                <a href="payment.jsp" class="btn btn-xs btn-info"><b class="glyphicon glyphicon-ok"></b> Ok</a>
                                <a href="receiptDetails.html" class="btn btn-xs btn-primary"><b class="glyphicon glyphicon-eye"></b> Generate Receipt</a>
                            </div>
                    </div>
                </div>
            </div>
        </div> 
        <div class="row col-md-12 text-column-info" align="center" style="color: #fff; padding-top:535px">
            &copy; 2016 Board of Internal Revenue OYO STATE.
        </div>   
    </body>
</html>
