 <%@page import="java.sql.Date"%>
<style>
	  .mandatory {
	     color: #FF0000
	  }
	  </style>
 <div class="row">
         <div class="col-md-12">
			<div class="panel-body">
				<div class="row">
					<div class="well">
						<div class="row">
						<div class="panel-body">
							<div class="row">
								<div class="well"  style="background: #dfffbf; color:  #800080;">
									<div class="row">
										<div class="col-md-12">
								<!-- START DEFAULT DATATABLE -->
											<div class="panel panel-default">
												<div class="panel-body">
													<!--------------------------------------->
												
												     <div class="row">
														<div class="col-md-12">
															
															<form class="form-horizontal">
															<div class="panel panel-default">
																<div class="panel-heading" style="background: #dfffbf; color:  #800080;">
																	<div class="page-title " align="right"><br>		
																		<a href="#">   <img src="${pageContext.request.contextPath}/img/nigeria-coat-of-arms.png"></a>
																		<div class="col-md-offset-7 col-md-5"> 
																			<table width="10%" class="table" border="1" >
																				<tbody>
																					<tr>
																					<td valign="top" width="2%"> Valid For:</td>
																					<td valign="top" width="2%"><span id=""><input type="text" id="" name="" class="form-control"></span>
																					</td>
																					</tr>
																					<tr>
																					<td valign="top" width="7%"> Effective Date:</td>
																					<td valign="top" width="25%"><span id=""><input type="date" id="" name="" class="form-control"  /></span></td>
																					</tr>
																					<tr>
																					<td valign="top" width="7%"> Payment Date:</td>
																					<td valign="top" width="5%"><span id=""><input type="date" id="" name="" class="form-control"  /></span></td>
																					</tr>
																				</tbody>
																			</table>
																		</div>
																	</div>
																	
																	<div class="row" >
																			<h3 class="page-title" align="center">INDEPENDENT ELECTORAL COMMISSION
																			(INEC)</h3> <br><span class="page-title" align="center">(Decree No 70, 1979)(amended by Decree No. 82, 1992)</span><br>
																			
																			 <h3 class="page-title" align="center">Payment Authorization Reciept</h3><br>
																			 <h3 class="page-title" align="center">THE HOD FINANCE DEPARTMENT OF THE INDEPENDENT ELECTORAL COMMISSION (INEC),<br> by the powers and
																			 authority conferred on him under Decree NO.70 dated 24th September, 1979, hereby AUTHORIZES that:</h3><br>
																	</div>		
																</div>
																<br/>
																<br/>
																<br/>
																<div class="panel-body">                                                                        
																	
																	<div class="form-group">
																		<label class="col-md-3 col-xs-12 control-label">Client</label>
																		<div class="col-md-6 col-xs-12">                                            
																			<div class="input-group">
																				<span class="input-group-addon"><span class="fa fa-pencil"></span></span>
                                                                                                                                                                <input type="text" class="form-control" value="<%=(String)request.getAttribute("name_of_company")%>"  readonly="readonly"/>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-3 col-xs-12 control-label">To Supply</label>
																		<div class="col-md-6 col-xs-12">                                            
																			<div class="input-group">
																				<span class="input-group-addon"><span class="fa fa-pencil"></span></span>
																				<input type="text" class="form-control" value="PRODUCT/SERVICE NAME"  readonly="readonly"/>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-3 col-xs-12 control-label">Sum Amount</label>
																		<div class="col-md-6 col-xs-12">                                            
																			<div class="input-group">
																				<span class="input-group-addon"><span class="fa fa-pencil"></span></span>
																				<input type="text" class="form-control" value="&#8358;5600000"  readonly="readonly"/>
																			</div>
																		</div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-3 col-xs-12 control-label">Budget Code</label>
																		<div class="col-md-6 col-xs-12">                                            
																			<div class="input-group">
																				<span class="input-group-addon"><span class="fa fa-pencil"></span></span>
																				<input type="text" class="form-control" value="668231"  readonly="readonly"/>
																			</div>
																		</div>
																	</div>
																	
																		<br><br>
																	<div class="mandatory">
																	The parties to the Agreement and all the persons to whom it may concern will duly execute the Agreement referred to above according to the terms and conditions in
																	which it had been approved otherwise they will be guilty of an offence and liable to be prosecuted and punished for all offence in the manner prescribed by the law of the country.<br>
																	<br>
																	</div>
																	<div class="col-md-4">
																	Made at Abuja, this day <input type="date" id="day" name="day"  value="<%= new Date(System.currentTimeMillis()) %>" /></div> <br>
																	<br><br><br>
														<div class="page-title" align="right" >
															<h5 >The HOD Accounting/Finance <br/>
																INDEPENDENT ELECTORAL COMMISSION (INEC)</h5>
															<hr>
														</div>
																</div>
																<div class="panel-footer">
																	<button class="btn btn-default">Save</button>                                    
																	<button class="btn btn-success pull-right">Genarate Receipt</button>
																</div>
															</div>
															</form>
															
														</div>
													</div> 
												<!--------------------------------------->
												</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		</div>
	