     
    function loadValues(template){
      $.ajax({
            url: '/DocumentManager/GetWorkFlow',
            type: 'get',
            //data: {depart:deptid},
            dataType: 'json',
            success:function(response){
                var len = response.length;
                for( var i = 0; i<len; i++){
                    var userId = response[i]['userId'];
                    var authLevel = response[i]['authLevel'];
                    $('#set_up').append('<tr><td>' + userId + '</td><td>' + authLevel + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
                 }
                  $('#set_up').DataTable().draw();
            }
        });  
    }
    
    
//    $.ajax({ url: '/DocumentManager/GetWorkFlow',
//                      type: 'get',
//                      dataType: 'json',
//                      success: function (response) {
//                          var len = response.length;
//                          for (var i = 0; i < len; i++) {
//                      var userId =  response[i]['userId'];
//                      var authLevel =  response[i]['authLevel'];
//                      $('#set_up').DataTable().destroy();
//                      $("#set_up > tbody").append('<tr><td>' + userId + '</td><td>' + authLevel + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
//                      }
//        }
//                          });
    
    