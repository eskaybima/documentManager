/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$(function(){




		 //------------radio check button--------//
			
			$('#checkboxSuccess1').click(function(){
				$('#checkboxSuccess11').prop('checked', false);
			});
			 
			 $('#checkboxSuccess11').click(function(){
				$('#checkboxSuccess1').prop('checked', false);
			});
		$('#checkboxSuccess12').click(function(){
				$('#checkboxSuccess13').prop('checked', false);
			});
			 
			 $('#checkboxSuccess13').click(function(){
				$('#checkboxSuccess12').prop('checked', false);
			});
		



   $('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		
 var count = $('#count').val();	 
  var onugu =  count;
  $('#onugu').val(onugu);	
	
  $('#docs').change(function(){
	         var allsigne = [];
			 var checkbo = [];
			for(i=0;i <onugu;i++){
			if($('#checkbox'+(i+1)).is(':checked')){
			checkbo.push($('#checkbox'+(i+1)).is(':checked'));
			}

			allsigne.push(true);
			}
			
			if(checkbo.length==allsigne.length){ 
			$('#signoff').removeAttr('disabled').addClass('btn-success');
			} else {
				$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
			}
  });
	
	
	//-------------VALIDATE BUTTON------------//
				
				$('#confirm-validate').click(function(){
			var projectid = $('#projectid').val();
			var projectname = $('#projectname').val();
			var client = $('#clientname').val();
			var projIDencode = $('#projIDencode').val();
			//alert(projIDencode); return false;

			var details = 'projectname1='+projectname+'&projectid1='+projectid+'&client1='+client;
			var commonValue = [];
			var allsigned = [];
			 var checkbox = [];
			for(i=0;i <onugu;i++){
			if($('#checkbox'+(i+1)).is(':checked')){
			checkbox.push($('#checkbox'+(i+1)).is(':checked'));
			}

			allsigned.push(true);
			}





			if(checkbox.length==allsigned.length ){ 
			$(this).attr({disabled:'disabled'}).html('please wait...');
					   $.ajax({
			url:'validate.php',
						   type:'POST',
						   data:details,
						   success: function(data){
			if (data == 100){
			$('#modal-pmo').html('<div><span class="text-success h4"><i class="icon-thumbs-up"></i> Project Signed - Off!</span> <a href="Pmo.php?collector=EditProjectmile&projectid='+projIDencode+'" class="btn btn-sm btn-success"><b class="glyphicon glyphicon-ok"></b> OK</a></div>');
			}else{
			$('#modal-pmo').html('<div><span class="text-danger h4"><i class="icon-thumbs-down"></i> ERROR TRY AGAIN</span><a href="Pmo.php?collector=EditProjectmile&projectid='+projIDencode+'" class="btn btn-sm btn-danger"><b class="glyphicon glyphicon-remove"></b> EXIT</a></div>');
			}
							   
			}
					   });

			}else{
			 $('#modal-pmo').html('<h4 class="text-danger h5"><i class="icon-thumbs-down"></i> Kindly Sign Off shareholders!</h4><div class="col-md-offset-4"><a href="Pmo.php?collector=EditProjectmile&projectid='+projIDencode+'" class="btn btn-sm btn-danger"><b class="glyphicon glyphicon-remove"></b> EXIT</a></div>');
			 return false;
				}
			// }
			});
	
		
	//-----------add new shareholder row----//
	$(document).on('click','#addrow11',function(){
		onugu++;
		var shareholder ="shareholder1"+onugu;
		var percentage= "percentage1"+onugu;
		var row1 = "row11"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile11').append('<tr id="'+row1+'"><td><textarea type="text" class="form-control input-sm" name="'+shareholder+'" id="'+shareholder+'" rows=2 placeholder="Enter name od shareholder(s)"></textarea></td><td><textarea type="text" class="form-control input-sm" name="'+percentage+'" id="'+percentage+'" rows=2 placeholder="--Enter equity percentage--"></textarea></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow11').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	
	});
	
	
			//-----------remove shareholder row----//
	$(document).on('click','#minusrow11',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow11').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row11'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
		
			
	//-----------add new shareholder row----//
	$(document).on('click','#addrow',function(){
		onugu++;
		var shareholder ="shareholder"+onugu;
		var percentage= "percentage"+onugu;
		var row = "row"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile').append('<tr id="'+row+'"><td><textarea type="text" class="form-control input-sm" name="'+shareholder+'" id="'+shareholder+'" rows=2 placeholder="Enter name od shareholder(s)"></textarea></td><td><textarea type="text" class="form-control input-sm" name="'+percentage+'" id="'+percentage+'" rows=2 placeholder="--Enter equity percentage--"></textarea></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	
	});
	
	
			//-----------remove shareholder row----//
	$(document).on('click','#minusrow',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
		
		
	//-----------add new shareholder row----//
	$(document).on('click','#addrow112',function(){
		onugu++;
		var shareholder ="shareholder2"+onugu;
		var percentage= "percentage2"+onugu;
		var row2 = "row112"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile112').append('<tr id="'+row2+'"><td><textarea type="text" class="form-control input-sm" name="'+shareholder+'" id="'+shareholder+'" rows=2 placeholder="Enter name od shareholder(s)"></textarea></td><td><textarea type="text" class="form-control input-sm" name="'+percentage+'" id="'+percentage+'" rows=2 placeholder="--Enter equity percentage--"></textarea></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow112').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	
	});
	
	
			//-----------remove shareholder row----//
	$(document).on('click','#minusrow112',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow112').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row112'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
		
		
		
	//-----------add new milestone row----//
	$(document).on('click','#addrow2',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row2 = "row2"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile2').append('<tr id="'+row2+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow2').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow2',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow2').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row2'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
	//-----------add new milestone row----//
	$(document).on('click','#addrow3',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row3 = "row3"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile3').append('<tr id="'+row3+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow3').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow3',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow3').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row3'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
	
	
	//-----------add new milestone row 4----//
	$(document).on('click','#addrow4',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row4 = "row4"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile4').append('<tr id="'+row4+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow4').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow4',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow4').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row4'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
		
		
	//-----------add new milestone row----//
	$(document).on('click','#addrow22',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row22 = "row22"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile22').append('<tr id="'+row22+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow22').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow22',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow22').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row22'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
	//-----------add new milestone row----//
	$(document).on('click','#addrow33',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row33 = "row33"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile33').append('<tr id="'+row33+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow33').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow33',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow33').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row33'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
	
	
	//-----------add new milestone row 4----//
	$(document).on('click','#addrow44',function(){
		onugu++;
		var milestone ="milestone"+onugu;
		var startdate="startdate"+onugu;
		var enddate="enddate"+onugu;
		var comment= "comment"+onugu;
		var row44 = "row44"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile44').append('<tr id="'+row44+'"><td><textarea type="text" class="form-control input-sm" name="'+milestone+'" id="'+milestone+'" rows=2 placeholder="input year here"></textarea></td><td><input type="text" class="form-control input-sm "  name="'+startdate+'" id="'+startdate+'" placeholder="Enter emploment level"></td><td><input type="text" class="form-control input-sm "  name="'+enddate+'" id="'+enddate+'" placeholder="Input year here"></td><td><input type="text" class="form-control input-sm" name="'+comment+'" id="'+comment+'" rows=2 placeholder=" Enter emploment level" ></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow44').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	

	});
	
	
			//-----------remove milestone row----//
	$(document).on('click','#minusrow44',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow44').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#row4'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
	
	
	//-----------add new shareholder row----//
	$(document).on('click','#addrow1',function(){
		onugu++;
		var shareholder ="shareholder"+onugu;
		var percentage= "percentage"+onugu;
		var row = "rowQ"+onugu;
		
		$('#signoff').attr({disabled:'disabled'}).removeClass('btn-success');
		  
		$('#table_mile1').append('<tr id="'+row+'"><td><textarea type="text" class="form-control input-sm" name="'+shareholder+'" id="'+shareholder+'" rows=2 placeholder="Enter name od shareholder(s)"></textarea></td><td><textarea type="text" class="form-control input-sm" name="'+percentage+'" id="'+percentage+'" rows=2 placeholder="--Enter equity percentage--"></textarea></td></tr>');
	
	$('#onugu').val(onugu);
	$('#minusrow').removeAttr('disabled').removeClass('btn-default').addClass('btn-danger');
	
	});
	
	
			//-----------remove shareholder row----//
	$(document).on('click','#minusrow1',function(){
		//var onugu1 = $('#onugu').val() ;
		
		//alert(onuogu); return false;
		
		if(count == onugu){
			$('#minusrow1').attr({'disabled':'disabled'}).removeClass('btn-danger').addClass('btn-default');
			
		} else{
			$('#rowQ'+onugu).remove();
			
		
				onugu--;
				$('#onugu').val(onugu);
				
				
			 
				
		}
		
	});
		
		
		
		
		
		
	  //---------fetch project id------//
 $('#projectname').change(function(){
            $('#projectid').hide();
            var projectid;
			projectid = $(this).val();
            $('.param').hide();
			getprojectid(projectid);
            $('.param').fadeIn(200);
        });
		
		
	
	 
                $('#projectname').change(function(){
                   $('#clientname').hide();
                   var clientname; 
                               clientname = $(this).val();
                   $('.param1').hide();
                               getclientname(clientname);
                   $('.param1').fadeIn(200);
               });
	
              
           $('#formss').hide();
	  $('#form2').hide();
	  $('.pid').tooltip({placement:'top',title:'click on project id to edit project'});
	  
	  $('#yes').click(function(){
		 $('#formss').show(); 
		  $('#form2').hide();
		   $('#').hide(); 
		  $('#no').prop('checked', false);
	  });
	  $('#no').click(function(){
		 $('#formss').hide(); 
		  $('#').hide(); 
		  $('#form2').show();
		  $('#yes').prop('checked', false);
	  });     
                
	 });