

$(document).ready(function () {
    
    $('table').on('click', ".btnNext", function () {
        alert('First btnnext');
        var checkstr = confirm('are you sure you want to delete this?'); // Addede by Adebayo
        if (checkstr === true) { // Addede by Adebayo
            $(this).closest('tr').remove(); // more simple
        } else { 
            return false; 
        }
    });


    $('#upload-button').on('click', function () {
        UploadFile();
    });


  $.ajax({
        url: '/DocumentManager/GetDocumentsDetails',
        type: 'get',
        dataType: 'json',
        success: function (response) {
            var len = response.length;
            $("#jobType").empty();
            $("#jobType").append("<option value=''>----select---</option>");
            for (var i = 0; i < len; i++) {
                var docType = response[i]['docType'];
                $("#jobType").append("<option value='" + docType + "'>" + docType + "</option>");
            }
        }
    });


    function UploadFile() {
        var fileSelect = document.getElementById('file-select');
        var uploadButton = document.getElementById('upload-button');
        var selectController = document.getElementById('select-controller');
        event.preventDefault();
        var files = fileSelect.files;
        var formData = new FormData();
        for (var i = 0; i < files.length; i++) {
            var file = files[i];
            formData.append('photos[]', file, file.name);
        }
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/DocumentManager/TestAjaxUpload', true);
        xhr.onload = function () {
            if (xhr.status === 200) {
                uploadButton.innerHTML = 'Upload';
                //  new new new new
                selectController.innerHTML = '';
                selectController.innerHTML = '<input class="fileinput btn-default"  type="file"  id="file-select" title="Choose File From Disk"/>';
                //  new new  new  new
            } else {
                alert('An error occurred!');
            }
        };
        xhr.send(formData);
       
        $.ajax({
            url: '/DocumentManager/ExtractDocDetails',
            type: 'get',
            dataType: 'json',
            success: function (response) {
                var len = response.length;
                var colController;
                for (var i = 0; i < len; i++) {
                    var docId = response[i]['doc_id'];
                    var docName = response[i]['docType'];
                    $('#applDocuments').DataTable().destroy();
//                    $("#applDocuments > tbody").append('<tr><td data-desc=' + docName + '>' + docName + '</td><td><form ="${pageContext.request.contextPath}/UpdateHandler" target="_blank">\n\
//                      <input type ="hidden" name ="fileView"  value = ' + docId + ' ><Button class="btn btn-success" type="submit">\n\
//                        <span class="fa fa-file-pdf-o"></span> View Document</Button></form></td>\n\
//                        <td><button id="addButton" class="btn btn-md btn-danger btnNextdoc">Delete</button></td></tr>');
                    $("#applDocuments > tbody").append('<tr><td data-desc=' + docName + '>' + docName + '</td><td><a href="#"  onclick="ViewDoc(\''+docId+'\')">View Document</a></li></td>\n\
                    <td><button id="addButton" class="btn btn-md btn-danger btnNextdoc">Delete</button></td></tr>');
                    $('#applDocuments').DataTable().draw();
                    $("#jobType").find("option[value='" + docName + "']").remove();
                }
            }
        });

    }

    $('#addButton5_4').on('click', function () {
        var checkstr = confirm('do you want to delete this document?');
        if (checkstr === true) {
            //$(this).closest('tr').remove();
            $('#sec5_4Doc').DataTable().row($(this).parents('tr')).remove().draw();
        } else {
            return false;
        }
    });

    $('#applDocuments').on('click', ".btnNextdoc", function () {
        var checkstr = confirm('are you sure you want to delete this?'); 
        if (checkstr === true) { 
            $('#applDocuments').DataTable().row($(this).parents('tr')).remove().draw();
            var docType = $(this).closest('tr').children('[data-desc]').data("desc");
            $("#jobType").append("<option value='" + docType + "'>" + docType + "</option>");
        } else {
            return false;
        }
    });
    
   

});

  

  

   

   




   
   







