$(document).ready(function() {
    document.getElementById('templateName').value = '';
     document.getElementById('description').value = '';
    $('#templateConfig').bootstrapValidator({         
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            templateName: {
                validators: {
                    notEmpty: {
                        message: 'Template name is required and cannot be empty'
                    },
                     remote: {
                        url: '/DocumentManager/CheckFormName',
                        data: function(validator, $field, value) {
                            return {
                                templateName: validator.getFieldElements('templateName').val()
                            };
                        },			
                        message: '<span style="color: #ff0000;">This template name is already registered</span>',
                        type: 'POST'
                    },
                }
            },
       
						
	description: {
                validators: {
                    notEmpty: {
                        message: 'Description is required and cannot be empty'
                    },
                     remote: {
                        url: '/DocumentManager/CheckFormName',
                        data: function(validator, $field, value) {
                            return {
                                description: validator.getFieldElements('description').val()
                            };
                        },			
                        message: 'This description name exist. Please choose another one',
                        type: 'POST'
                    },
                }
            }	
        }
    });
    
     $('#set_up').on('click', ".btnNext", function () {
        var checkstr = confirm('are you sure you want to delete this?'); 
        if (checkstr === true) { 
            $('#set_up').DataTable().row($(this).parents('tr')).remove().draw();
        } else {
            return false;
        }
    });
    
      $('#add_form_field').on('click', function (e) {
        e.preventDefault();
        var parameter = $('#set_up_form').find('input[name="parameter"]').val();
        var dataType = $('#set_up_form').find('select[name="dataType"]').val();
        document.getElementById('parameter').value = '';
        $('#set_up').append('<tr><td>' + parameter + '</td><td>' + dataType + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
         var selectController = document.getElementById('selectController');
          selectController.innerHTML = '';
          selectController.innerHTML = '<select class="form-control select" data-live-search="true" name="dataType" value=""  \n\
                                         autocomplete="off" id="dataType" onchange="renderElseWhere2(\'dataType\', \'loghc\')"/>\n\
                                         <option value="">Nothing Selected</option>\n\
                                         <option value="SUBHEAD">SUB HEAD</option>\n\
                                         <option value="STRING">FORM FIELD</option>\n\
                                         <option value="DROP_DOWN">DROP DOWN</option>\n\
                                         <option value="DOCUMENT">DOCUMENT</option>\n\\n\
                                          <option value="DATE">DATE</option>\n\
                                       </select>'
        //
        //$('#set_up_form').find('select[name="dataType"]'). 
    });
    
    
     function convertArrayToJSON()
    {
        var TableData;
        TableData = JSON.stringify(storeTblValues2());
        return TableData;
    }

    
    function storeTblValues2()
    {
        var TableData = new Array();
        $('#set_up tr').each(function (row, tr) {
            TableData[row] = {
                "parameterName": $(tr).find('td:eq(0)').text().trim()
              , "datatype": $(tr).find('td:eq(1)').text().trim()
            }
        });
        TableData.shift();  // first row will be empty - so remove
        //  $('#tbServerResponseArray').val(TableData);
        return TableData;
    }
    
    $('#sendajax').on('click', function () {
            var checkstr = confirm('are you sure you want to Submit');
             if (checkstr === true) { 
                  sendAjax();
             }
    }); 
    
    function sendAjax() {
        var tableDataJson = convertArrayToJSON();
        $.ajax({
            url: "ReadJsonData",
            type: 'POST',
            dataType: 'json',
            data: tableDataJson,
            contentType: 'application/json',
            mimeType: 'application/json',
            success: function (response) {
                 var result = response['valid'];
                if (result) {
                    window.location.replace("pages/loadDropDownValues.jsp");
                } else {
                    window.location.replace("pages/homepage.jsp");
                }
            },
            error: function (data, status, er) {
                //          alert("error: "+data+" status: "+status+" er:"+er);
            }
        });
    }



    
});

