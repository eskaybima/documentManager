
var access_type = '';
function control(ref_id) {
    $('#restrict_group').hide();
    $('#individual_users').hide();
    $('#role_id_group').hide();
    $('#user_group').hide();
    $('#public_access_div').hide();
    
      $.ajax({
        url: "GetAccessSettings?ref_id=" + ref_id + "",
        type: 'get',
        dataType: 'json',
        success: function (response) {
            var len = response.length;
            for (var i = 0; i < len; i++) {
                var access_key = response[i]['access_key'];
                var access_nature = response[i]['access_nature'];
                if (access_nature === 'individual') {
                     $('#authorised_users').append('<tr><td>' + access_key + '</td><td><a class="btn btn-md btn-danger btnNext">Delete</a></td></tr>')
                }
                if (access_nature === 'role_id') {
                     $('#role_id_group_table').append('<tr><td>' + access_key + '</td><td><a class="btn btn-md btn-danger btnNext">Delete</a></td></tr>')
                }
                if (access_nature === 'user_group') {
                     $('#user_group_table').append('<tr><td>' + access_key + '</td><td><a class="btn btn-md btn-danger btnNext">Delete</a></td></tr>')
                }
                if (access_nature === 'public') {
                    document.getElementById("access_type_radio").checked = true;
                    $('#restrict_panel').hide();
                } else {
                     document.getElementById("res_access_type_radio").checked = true;
                }
            }
        }
    });
}
;

function submitAccessSetting() {
    var checkstr = confirm('are you sure you want to Submit');
    if (checkstr === true) {
        if ( access_type === 'RESTRICTED') {
        var tableDataJson = convertArrayToJSON('authorised_users', 'individual');
        sendAjax(tableDataJson);
        tableDataJson = convertArrayToJSON('role_id_group_table', 'role_id');
        sendAjax(tableDataJson);
        tableDataJson = convertArrayToJSON('user_group_table', 'user_group');
        sendAjax(tableDataJson);
        alert("Setting posted successfully");
        window.location.replace("Authorize?refresh=yes");
         } else if (access_type === 'PUBLIC') {
        tableDataJson = convertArrayToJSON('public_access_table', 'public');
        sendAjax(tableDataJson);
        alert("Setting posted successfully");
        window.location.replace("Authorize?refresh=yes");
         } else {
        alert("Please select an option");
         }
        
        }
}



function showResGroup() {
     access_type = 'RESTRICTED';
    $('#restrict_group').show();
    $('#restrict_panel').show();
    $('#index_panel').hide();
}
;

function showAllusers() {
    $('#individual_users').show();
     $('#individual_users_select').show();
    $('#role_id_group_select').hide(); 
    $('#user_group_select').hide(); 
}
;
//user_group
function showAllRoles() {
    $('#role_id_group').show();
    $('#role_id_group_select').show();
    $('#user_group_select').hide();
    $('#individual_users_select').hide();
}
;
function showAllUserGroups() {
    $('#user_group').show();
     $('#user_group_select').show();
    $('#role_id_group_select').hide();  
    $('#individual_users_select').hide();
}
;

function addUserToTable() {
    var user = $('#individual_users').find('select[name="user_selected"]').val();
    $('#authorised_users').append('<tr><td>' + user + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
}
;

function addRoleToTable() {
    var role_id = $('#role_id_group').find('select[name="role_id_selected"]').val();
    $('#role_id_group_table').append('<tr><td>' + role_id + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
}
;

function addUserGroupToTable() {
    var user_group = $('#user_group').find('select[name="user_group_selected"]').val();
    $('#user_group_table').append('<tr><td>' + user_group + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
}
;

function setAccesType(accessType) {
   access_type =  accessType; 
    $('#public_access_table').append('<tr><td>public</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')

}
;




function convertArrayToJSON(tableId, access_nature)
{
    var TableData;
    TableData = JSON.stringify(storeTblValues(tableId, access_nature));
    return TableData;
}


function storeTblValues(tableId, access_nature)
{
    var TableData = new Array();
    var ref_id = document.getElementById('ref_id').value;
    $('#' + tableId + ' tr').each(function (row, tr) {
        TableData[row] = {
            "access_key": $(tr).find('td:eq(0)').text().trim()
            , "access_nature": access_nature
            , "ref_id": ref_id
        }
    });
    return TableData;
}

   function sendAjax(tableDataJson) {
    var posting_result;
    $.ajax({
        url: "PostAccessSettings",
        type: 'POST',
        dataType: 'json',
        data: tableDataJson,
        contentType: 'application/json',
        mimeType: 'application/json',
        success: function (response) {
            posting_result = response['valid'];
        },
    });
    return posting_result;
}


$(document).ready(function() {
$('table').on('click', ".btnNext", function () {
        var checkstr = confirm('are you sure you want to delete this?'); 
        if (checkstr === true) { 
            $(this).closest('tr').remove();
        } else { 
            return false; 
        }
    });
    
    
 
});
//});



