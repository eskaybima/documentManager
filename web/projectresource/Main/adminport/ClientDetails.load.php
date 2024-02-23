      <script type="text/javascript">
				 $(function(){
					  $('#dashboard').removeClass('active');	
					  $('#vc').addClass('active');				  
				 });
				 
			  </script>

            <!-- START BREADCRUMB -->
					<ul class="breadcrumb">
						<li><a href="#">Home</a></li>                    
						<li class="active">Dashboard</li>
					</ul>
					<!-- END BREADCRUMB -->     
                    
                    <!-- START WIDGETS -->                    
                    <div class="row">
                        <div class="col-md-3">
                            <!-- START WIDGET MESSAGES -->
                            <div class="widget widget-default widget-item-icon" onclick="location.href='pages-messages.html';">
                                <div class="widget-item-left">
                                    <span class="fa fa-balance-scale"></span>
                                </div>                             
                                <div class="widget-data">
                                    <div class="widget-int num-count">32500</div>
                                    <div class="widget-title">Equity Balance</div>
                                    <div class="widget-subtitle">Your Avaliable equity balance</div>
                                </div>   
                            </div>                            
                            <!-- END WIDGET MESSAGES -->
                            
                        </div>
                        <div class="col-md-3">
                            
                            <!-- START WIDGET MESSAGES -->
                            <div class="widget widget-default widget-item-icon" onclick="location.href='pages-messages.html';">
                                <div class="widget-item-left">
                                    <span class="fa fa-line-chart"></span>
                                </div>                             
                                <div class="widget-data">
                                    <div class="widget-int num-count">345866</div>
                                    <div class="widget-title">Profit Balance</div>
                                    <div class="widget-subtitle">Your Avaliable profit balance</div>
                                </div> 
                            </div>                            
                            <!-- END WIDGET MESSAGES -->
                            
                        </div>
                        <div class="col-md-3">
                            
                            <!-- START WIDGET REGISTRED -->
                            <div class="widget widget-default widget-item-icon" onclick="location.href='pages-address-book.html';">
                                <div class="widget-item-left">
                                    <span class="fa fa-bar-chart"></span>
                                </div>
                                <div class="widget-data">
                                    <div class="widget-int num-count">65000</div>
                                    <div class="widget-title">Total Balance</div>
                                    <div class="widget-subtitle">Your available total balance</div>
                                </div>                           
                            </div>                            
                            <!-- END WIDGET REGISTRED -->
                            
                        </div>
                        <div class="col-md-3">
                            
                            <!-- START WIDGET CLOCK -->
                            <div class="widget widget-danger widget-padding-sm">
                                <div class="widget-big-int plugin-clock">00:00</div>                            
                                <div class="widget-subtitle plugin-date">Loading...</div>                           
                                <div class="widget-buttons widget-c3">
                                    <div class="col">
                                        <a href="#"><span class="fa fa-clock-o"></span></a>
                                    </div>
                                    <div class="col">
                                        <a href="#"><span class="fa fa-bell"></span></a>
                                    </div>
                                    <div class="col">
                                        <a href="#"><span class="fa fa-calendar"></span></a>
                                    </div>
                                </div>                            
                            </div>                        
                            <!-- END WIDGET CLOCK -->
                            
                        </div>
                    </div>
                    <!-- END WIDGETS -->                    
                    
					<div class="row">
                        <div class="col-md-12">
                            
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <p>Use search to find Clients. You can search by: name, address, phone. Or use the advanced search.</p>
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
                                    <h3 class="panel-title"><span class="fa fa-users"></span> All Registered Clients</h3>
                                </div>
                                <div class="panel-body"> 
								    <div class="row">
									   <div class="col-md-12">
									     <table class="table table-responsive">
										       <tr>
														     <th><span class="fa fa-sort-numeric-asc"></span> S / N</th>
															 <th><span class="fa fa-credit-card"></span> Account Number</th>
															 <th><span class="fa fa-star-half-o"></span> Account Type</th>
															 <th><span class="fa fa-user"></span> First Name</th>
															 <th><span class="fa fa-user"></span> Last Name</th>
															 <th><span class="fa fa-phone"></span> Phone Number</th>
															 <th><span class="fa fa-envelope-o"></span>  Email</th>
															 <th><span class="fa fa-check-square-o"></span> Action</th>
														  </tr>
													      <tr>
														     <td>1.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>Ibrahimovic</td>
															 <td>08066783465</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="admin.php?pg=ClientConfig" class="btn btn-warning btn-sm" type="button"><span class="fa fa-plus-circle"></span> more details</a></td>
														  </tr>
														  <tr>
														     <td>2.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>Ibrahimovic</td>
															 <td>08066783465</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="admin.php?pg=ClientConfig" class="btn btn-warning btn-sm" type="button"><span class="fa fa-plus-circle"></span> more details</a></td>
														  </tr>
														  <tr>
														     <td>3.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>Ibrahimovic</td>
															 <td>08066783465</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="admin.php?pg=ClientConfig" class="btn btn-warning btn-sm" type="button"><span class="fa fa-plus-circle"></span> more details</a></td>
														  </tr>
														  <tr>
														     <td>4.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>Ibrahimovic</td>
															 <td>08066783465</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="admin.php?pg=ClientConfig" class="btn btn-warning btn-sm" type="button"><span class="fa fa-plus-circle"></span> more details</a></td>
														  </tr>
														  <tr>
														     <td>5.</td>
															 <td>234567890</td>
															 <td>Gold Account</td>
															 <td>Zlantan</td>
															 <td>Ibrahimovic</td>
															 <td>08066783465</td>
															 <td>ibro@yahoo.com</td>
															 <td><a href="admin.php?pg=ClientConfig" class="btn btn-warning btn-sm" type="button"><span class="fa fa-plus-circle"></span> more details</a></td>
														  </tr>
													   </table> 
									         </div>
									     </div>
                                     </div>
                                  </div>
                               </form>			  
						   </div>
					   </div>