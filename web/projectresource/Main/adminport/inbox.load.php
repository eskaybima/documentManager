       
	         <script type="text/javascript">
				 $(function(){
					  $('#dashboard').removeClass('active');	
					  $('#msg').addClass('active');				  
				 });
				 
			  </script>
	<!-- START BREADCRUMB -->
                <ul class="breadcrumb push-down-0">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Pages</a></li>
                    <li><a href="#">Mailbox</a></li>
                    <li class="active">Inbox</li>
                </ul>
                <!-- END BREADCRUMB -->                
                                
                <!-- START CONTENT FRAME -->
                <div class="content-frame">                                    
                    <!-- START CONTENT FRAME TOP -->
                    <div class="content-frame-top">                        
                        <div class="page-title">                    
                            <h2><span class="fa fa-inbox"></span> Inbox <small>(3 unread)</small></h2>
                        </div>                                                                                
                        
                        <div class="pull-right">                            
                            <button class="btn btn-default"><span class="fa fa-cogs"></span> Settings</button>
                            <button class="btn btn-default content-frame-left-toggle"><span class="fa fa-bars"></span></button>
                        </div>                        
                    </div>
                    <!-- END CONTENT FRAME TOP -->
                    
                    <!-- START CONTENT FRAME LEFT -->
                    <div class="content-frame-left">
                        <div class="block">
                            <a href="#" class="btn btn-danger btn-block btn-lg" id="compose"><span class="fa fa-edit"></span> COMPOSE</a>
                        </div>
                        <div class="block">
                            <div class="list-group border-bottom">
                                <a href="#" class="list-group-item active"><span class="fa fa-inbox"></span> Inbox <span class="badge badge-success">3</span></a>
                                <a href="#" class="list-group-item"><span class="fa fa-star"></span> Starred <span class="badge badge-warning">6</span></a>
                                <a href="#" class="list-group-item"><span class="fa fa-rocket"></span> Sent</a>
                                <a href="#" class="list-group-item"><span class="fa fa-flag"></span> Flagged</a>
                                <a href="#" class="list-group-item"><span class="fa fa-trash-o"></span> Deleted <span class="badge badge-default">1.4k</span></a>                            
                            </div>                        
                        </div>
                        <div class="block">
                            <h4>Labels</h4>
                            <div class="list-group list-group-simple">                                
                                <a href="#" class="list-group-item"><span class="fa fa-circle text-success"></span> Clients</a>
                                <a href="#" class="list-group-item"><span class="fa fa-circle text-warning"></span> Social</a>
                                <a href="#" class="list-group-item"><span class="fa fa-circle text-danger"></span> Work</a>
                                <a href="#" class="list-group-item"><span class="fa fa-circle text-info"></span> Family</a>
                                <a href="#" class="list-group-item"><span class="fa fa-circle text-primary"></span> Friends</a>
                            </div>
                        </div>
                    </div>
                    <!-- END CONTENT FRAME LEFT -->
                    
                    <!-- START CONTENT FRAME BODY -->
                    <div class="content-frame-body">
                        
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <label class="check mail-checkall">
                                    <input type="checkbox" class="icheckbox"/>
                                </label>
                                <div class="btn-group">
                                    <button class="btn btn-default"><span class="fa fa-mail-reply"></span></button>
                                    <button class="btn btn-default"><span class="fa fa-mail-reply-all"></span></button>
                                    <button class="btn btn-default"><span class="fa fa-mail-forward"></span></button>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-default"><span class="fa fa-star"></span></button>                                    
                                    <button class="btn btn-default"><span class="fa fa-flag"></span></button>
                                </div>                                
                                <button class="btn btn-default"><span class="fa fa-warning"></span></button>
                                <button class="btn btn-default"><span class="fa fa-trash-o"></span></button>                                                                    
                                <div class="pull-right" style="width: 150px;">
                                    <div class="input-group">
                                        <div class="input-group-addon"><span class="fa fa-calendar"></span></div>
                                        <input class="form-control datepicker" type="text" data-orientation="left"/>                                    
                                    </div>
                                </div>
                            </div>
                            <div class="panel-body mail">
                                
                                <div class="mail-item mail-unread mail-info">                                    
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Dmitry Ivaniuk</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">Product development</a>                                    
                                    <div class="mail-date">Today, 11:21</div>
                                </div>
                                
                                <div class="mail-item mail-unread mail-danger">                                    
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">John Doe</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">New Windows 9 App</a>                                    
                                    <div class="mail-date">Today, 10:36</div>
                                </div>
                                
                                <div class="mail-item mail-success">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Nadia Ali</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">Check my new song</a>                                    
                                    <div class="mail-date">Yesterday, 20:19</div>
                                </div>
                                
                                <div class="mail-item mail-warning">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star starred">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Brad Pitt</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">How are you? Need some work?</a>                                    
                                    <div class="mail-date">Sep 15</div>
                                </div>
                                
                                <div class="mail-item mail-info">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Dmitry Ivaniuk</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">Can you check this docs?</a>                                    
                                    <div class="mail-date">Sep 14</div>
                                    <div class="mail-attachments">
                                        <span class="fa fa-paperclip"></span> 11Kb
                                    </div>
                                </div>
                                
                                <div class="mail-item">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star starred">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">HTC</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">New updates on your phone HD7</a>
                                    <div class="mail-date">Sep 13</div>
                                    <div class="mail-attachments">
                                        <span class="fa fa-paperclip"></span> 58Mb
                                    </div>
                                </div>
                                
                                <div class="mail-item mail-unread">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Unknown</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">You won $15,000,000</a>
                                    <div class="mail-date">Sep 13</div>
                                </div>
                                
                                <div class="mail-item mail-success">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Nadia Ali</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">Your tickets</a>
                                    <div class="mail-date">Sep 11</div>
                                    <div class="mail-attachments">
                                        <span class="fa fa-paperclip"></span> 1.2Mb
                                    </div>
                                </div>
                                
                                <div class="mail-item mail-info">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Dmitry Ivaniuk</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">New bug founded</a>
                                    <div class="mail-date">Sep 11</div>
                                </div>
                                
                                <div class="mail-item">
                                    <div class="mail-checkbox">
                                        <input type="checkbox" class="icheckbox"/>
                                    </div>
                                    <div class="mail-star">
                                        <span class="fa fa-star-o"></span>
                                    </div>
                                    <div class="mail-user">Darth Vader</div>                                    
                                    <a href="pages-mailbox-message.html" class="mail-text">Where drawings of the new spaceship?</a>
                                    <div class="mail-date">Sep 10</div>
                                </div>                                
                                
                            </div>
                            <div class="panel-footer">                                
                                <div class="btn-group">
                                    <button class="btn btn-default"><span class="fa fa-mail-reply"></span></button>
                                    <button class="btn btn-default"><span class="fa fa-mail-reply-all"></span></button>
                                    <button class="btn btn-default"><span class="fa fa-mail-forward"></span></button>
                                </div>
                                <div class="btn-group">
                                    <button class="btn btn-default"><span class="fa fa-star"></span></button>                                    
                                    <button class="btn btn-default"><span class="fa fa-flag"></span></button>
                                </div>
                                
                                <button class="btn btn-default"><span class="fa fa-warning"></span></button>
                                <button class="btn btn-default"><span class="fa fa-trash-o"></span></button>                                    
                                
                                <ul class="pagination pagination-sm pull-right">
                                    <li class="disabled"><a href="#">«</a></li>
                                    <li class="active"><a href="#">1</a></li>
                                    <li><a href="#">2</a></li>
                                    <li><a href="#">3</a></li>
                                    <li><a href="#">4</a></li>                                    
                                    <li><a href="#">»</a></li>
                                </ul>
                            </div>                            
                        </div>
                        
                    </div>
                    <!-- END CONTENT FRAME BODY -->
                </div>
                <!-- END CONTENT FRAME -->
				
		   <!-- Modal box for message-->
		   <div class="modal fade" id="message-modal" tabindex="-1"  aria-labelledby="modallabel" role="dialog" data-backdrop="static">
			<div class="modal-dialog">
				<div class="modal-content">
					<form class="form-horizontal">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
							<h4 class="modal-title text-success" id="modallabel">SEND US A MESSAGE</h4>
						</div>
						<div class="modal-body" id="add-modal-result">
							<div class="form-group">
								<label for="subject" class="col-md-3 control-label">Subject:</label>
								<div class="col-md-8">
									<input type="text" class="form-control" id="subject" placeholder="Subject">
								</div>
							</div>
							<div class="form-group">
								<label for="messagebody" class="col-md-3 control-label">Message:</label>
								<div class="col-md-8">
									<textarea id="messagebody" class="form-control" rows="4" placeholder="Compose a message"></textarea>
								</div>
							</div>
						</div>
						<div class="modal-footer" id="add-result-close">
							<button class="btn btn-primary" id="send-msg" type="submit"><b class="fa fa-send-o"></b> Send</button>
							<a href="#" class="btn btn-danger" data-dismiss="modal" id="closemsg"><b class="fa fa-remove"></b> Cancel</a>
						</div>
					</form>
				</div>
			</div>
		</div>