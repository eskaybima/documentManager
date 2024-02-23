
 <script type="text/javascript">
				 $(function(){
					  $('#dashboard').removeClass('active');	
					  $('#wr').addClass('active');	
                      $('.btn').click(function(){
					      $('#WithdrawalRequest-modal').modal('show');
				      });					  
				 });
				 
			  </script>
<!-- START BREADCRUMB -->
					<ul class="breadcrumb">
						<li><a href="#">Home</a></li>                    
						<li class="active">Dashboard</li>
					</ul>
					<!-- END BREADCRUMB -->   
                    
					<div class="row">
                        <div class="col-md-12">
                            
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <p>Use search to find Clients Deposit.</p>
                                    <form class="form-horizontal">
                                        <div class="form-group">
                                            <div class="col-md-8">
                                                    <input type="text" class="form-control" placeholder="Who are you looking for?"/>
                                            </div>
                                            <div class="col-md-2">
                                                <button class="btn btn-success btn-block"><span class="fa fa-search"></span> Search</button>
                                            </div>
                                        </div>
                                    </form>                                    
                                </div>
                            </div>
                            
                        </div>
                    </div>
							<div class="row">
							   <div class="col-md-12">
									<form class="form-horizontal">
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h3 class="panel-title"><span class="fa fa-download"></span> All Withdrawal Request From Clients</h3>
                                </div>
                                <div class="panel-body"> 
								    <div class="row">
									   <div class="col-md-12">
									     <table class="table table-responsive">
										       <tr>
														     <th><span class="fa fa-sort-numeric-asc"></span> S / N</th>
															 <th><span class="fa fa-credit-card"></span> Account Number</th>
															 <th><span class="fa fa-star-half-o"></span> Account Type</th>
															 <th><span class="fa fa-user"></span> Full Name</th>
															 <th><span class="fa fa-money"></span> Withdrawal Amount</th>
															 <th><span class="fa fa-envelope-o"></span>  Email</th>
															 <th><span class="fa fa-check-square-o"></span> Action</th>
														  </tr>
													      <tr>
														     <td>1.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>3750</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="#" class="btn btn-success btn-sm"><span class="fa fa-cog"></span> Process</a></td>
														  </tr>
														  <tr>
														     <td>2.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>3750</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="#" class="btn btn-success btn-sm"><span class="fa fa-cog"></span> Process</a></td>
														  </tr>
														  <tr>
														     <td>3.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>3750</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="#" class="btn btn-success btn-sm"><span class="fa fa-cog"></span> Process</a></td>
														  </tr>
														  <tr>
														     <td>4.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>3750</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="#" class="btn btn-success btn-sm"><span class="fa fa-cog"></span> Process</a></td>
														  </tr>
														  <tr>
														     <td>5.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>3750</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="#" class="btn btn-success btn-sm"><span class="fa fa-cog"></span> Process</a></td>
														  </tr>
													</table> 
									         </div>
									     </div>
                                     </div>
                                  </div>
                               </form>			  
						   </div>
					   </div>
					   
					   
   <!--my modal dialog box to withdraw-->
   <div class="modal fade" id="WithdrawalRequest-modal" tabindex="-1"  aria-labelledby="modallabel" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <form class="form-horizontal">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><b class="glyphicon glyphicon-remove"></b></button>
                    <h4 class="modal-title" id="modallabel4"><span class="fa fa-random"></span> Withdrawal Request</h4>
                </div>
                <div class="modal-body">
				<table class="table table-responsive">
						<tr>
							<td><p><small>Name</small><br/><span  class="h3 text-danger">ChiBleme bleme</span></p></td>
							<td><p><small>Account Number</small><br/><span  class="h3 text-danger">34837648734</span></p></td>
						</tr>
						<tr>
							<td><p><small>Bal</small><br/><span  class="h3 text-danger">4500</span></p></td>
							<td><p><small>Equity</small><br/><span  class="h3 text-danger">600</span></p></td>
						</tr>
						  <tr>
							<td><p><small>Date of Payment</small><br/><span  class="h3 text-danger">24/09/2015</span></p></td>
							<td><p><small>Withdraw</small><br/><span  class="h3 text-danger">700</span></p></td>
						  </tr>
				 </table>
				 
                 </div>
                <div class="modal-footer" id="add-cust">
				    <button class="btn btn-success" id="add-cust-save" type="submit"><b class="fa fa-check-square-o"></b> Approve</button>
                    <a href="#" class="btn btn-danger" data-dismiss="modal"><b class="fa fa-remove"></b> Cancel</a>
                </div>
            </form>
        </div>
    </div>
 </div>			   