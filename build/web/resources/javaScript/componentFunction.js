/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


var windowObjectReference = null; // global variable

function openFFPromotionPopup(name, url) {
    var strWindowFeatures = "'targetWindow','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=yes,width=1000px,height=600px'";
    if (windowObjectReference === null || windowObjectReference.closed)
    {
        windowObjectReference = window.open(url,
                name, strWindowFeatures);
    }
    else
    {
        windowObjectReference.focus();

    }
    ;
}
/* this method has not be tested and not yet fit for use*/
function prepareSearchPagebanner(searchLoc) {
    alert(PrevousAttri);
    var elements = document.getElementsByClassName('pagebanner');
    var pageLinks = document.getElementsByClassName('pagelinks');
    var returnString;
    var links;
    var currentDisplay;
    if (searchLoc === 'null') {
        searchLoc = '';
    }
    var next = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=next' + searchLoc + '" style="width:70px;"  >Get More</a>';
    var previous = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=previous' + searchLoc + '" style="width:70px;" >Previous</a>';
    for (var i = 0; i < elements.length; i++) {
        returnString = elements[i].innerHTML;
        currentDisplay = returnString.substring(returnString.indexOf("displaying"), returnString.length);
        returnString = '<%=session.getAttribute("banner")%>';

        if (nextAttri !== 'null') {
            returnString = returnString + ' ' + next;
        }
        if (PrevousAttri !== 'null') {
            returnString = returnString + ' ' + previous;
        }

        elements[i].innerHTML = '<b>Overall : </b>' + ' ' + returnString;
    }
    for (var i = 0; i < pageLinks.length; i++) {
        links = pageLinks[i].innerHTML
        links = 'Currently ' + currentDisplay + links;
        pageLinks[i].innerHTML = '<b>Current Display : </b>' + ' ' + links;
    }
}

function loadPhoto(tableId, path) {
    var table = document.getElementById(tableId);
    var inputs = table.getElementsByTagName("img");
    for (var z = 0; z < inputs.length; z++) {
        inputs[z].src = path + inputs[z].id;
    }
}

function nextRoleCreation(autoId, reportId, buttonId, buttonDefaultValue) {
    var autoCheckd = document.getElementById(autoId).checked;
    var reportCheckd = document.getElementById(reportId).checked;
    {
        if (autoCheckd == true || reportCheckd == true) {
            document.getElementById(buttonId).value = 'Next';
        } else if (!autoCheckd == true && !reportCheckd == true) {
            document.getElementById(buttonId).value = buttonDefaultValue;
        }
    }
}

function disableEmpstat(empStat, empStatSub, renderLoc) {
    var empS = document.getElementById(empStat)
    var empStatS = $("#" + empStatSub);
    {
        if (empS.value == 1 || empS.value == 5) {
            empTypeLoader(empStat, renderLoc)
            empStatS.find("input").attr("disabled", false);
            empStatS.find("select").attr("disabled", false);
            empStatS.find("td")["removeClass"]("grayText");
            empStatS.find("input")["removeClass"]("grayOut");
            empStatS.find("select")["removeClass"]("grayOut");
        } else {
            empStatS.find("input").attr("disabled", true);
            empStatS.find("select").attr("disabled", true);
            empStatS.find("td")["addClass"]("grayText");
            empStatS.find("input")["addClass"]("grayOut");
            empStatS.find("select")["addClass"]("grayOut");

        }
    }
}

function closeDialog() {
    $(this).closest('.ui-dialog-content').dialog('close');
}

function displayDialog(name) {
    var disname = '#' + name;
    $(disname).modal({
        keyboard: false,
        backdrop: true
    });
}

function displayDocument(doc_id) {
    var isPdf;
    $.ajax({
        url: '/DocumentManager/CheckDocIdFormat?docId=' + doc_id,
        type: 'get',
        dataType: 'json',
        success: function (response) {
            var len = response.length;
            for (var i = 0; i < len; i++) {
                isPdf = response[i]['doc_format'];
                if (!(isPdf === 'pdf')) {
                    var docu_content = document.getElementById('doc_content');
                    docu_content.innerHTML = '<img src="PDFLoader?view=' + doc_id + '" alt="admin" style="width:100%;"/>';
                    $('#ShowDocument').modal({
                        keyboard: false,
                        backdrop: true
                    });
                } else {
                    var docu_content = document.getElementById('doc_content');
                    docu_content.innerHTML = '<form ="${pageContext.request.contextPath}/PDFLoader" target="_blank" id="openDoc">\n\
                      <input type ="hidden" name = view  value = ' + doc_id + '><Button class="btn btn-success" type="submit"></form>'
                    document.getElementById('openDoc').submit();
                }
            }
        }
    });
}

function displayAllRecords(arg) {
    $('#ShowAllRecords').modal({
        keyboard: false,
        backdrop: true
    });
}

 function ViewDoc(doc_id) {
     var isPdf;
    $.ajax({
        url: '/DocumentManager/CheckDocIdFormat?docId=' + doc_id,
        type: 'get',
        dataType: 'json',
        success: function (response) {
            var len = response.length;
            for (var i = 0; i < len; i++) {
                isPdf = response[i]['doc_format'];
                if (!(isPdf === 'pdf')) {
                    var docu_content = document.getElementById('doc_content');
                    docu_content.innerHTML = '<img src="PDFLoader?fileView=' + doc_id + '" alt="admin" style="width:100%;"/>';
                    $('#ShowDocument').modal({
                        keyboard: false,
                        backdrop: true
                    });
                } else {
                    var docu_content = document.getElementById('doc_content');
                    docu_content.innerHTML = '<form ="PDFLoader" target="_blank" id="openDoc">\n\
                      <input type ="hidden" name = fileView  value = ' + doc_id + '><Button class="btn btn-success" type="submit"></form>'
                    document.getElementById('openDoc').submit();
                }
            }
        }
    });
    
    
    
}

function displayDocDetails(ref_id) {
        $.ajax({
            url: 'RightManager?ref_id=' + ref_id,
            type: 'get',
            dataType: 'json',
            success: function (response) {
                var result = response['valid'];
                if (result) {
                    document.getElementById(ref_id).submit();
                } else {
                  alert('You currently do not have right to view this record. Do you want to request access?');
                }
            }
        });
    }
    
    function display(id){
         alert(id);
         $.ajax({
            url: 'Authorize?ref_id='+id+'&new_upload=new',
            type: 'post',
            dataType: 'json',
            success: function (response) {
              
            }
        });            
    }
    

var timeOut = 1000 * 60 * 0.9; // 30 minutes
var lastActivity = new Date().getTime();
var checkTimeout;

checkTimeOut = function () {
    if (new Date().getTime() > lastActivity + timeOut) {
    } else {
        window.setTimeout(checkTimeOut, 1000);
    }
}

var process = true;
function deff(formName, renderLocation) {
    var form = $("#" + formName);
    if (process) {
        form.submit(function () {
            $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function (data) {
                    document.getElementById(renderLocation).innerHTML = data;
                    displayDialog(renderLocation + 'Dialog');
                    process = false;
                }
            });
            return false;
        });
    }
}

function autoformProcess(formName, renderLocation, changeReason) {
    var validate = false;
    {
        if (formName === "residentIfoUpdate") {
            validate = dataCorrectionVal();
        } else if (formName === "demoUpdate") {
            validate = demograpicUpdateChecker()
        }
    }
    {
        if (validate) {
            var form = $("#" + formName);
            $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function (data) {
                    {
                        var print = data.toString();
                        if (print.indexOf('No Changes Made') === -1) {
                            document.getElementById(renderLocation).innerHTML = data
                            document.getElementById(changeReason).style.display = 'block';
                            displayDialog(renderLocation + 'Dialog');
                            process = false;
                        } else {
                            document.getElementById(changeReason).style.display = 'none';
                            document.getElementById(renderLocation).innerHTML = data
                            displayDialog(renderLocation + 'Dialog');
                            process = false;
                        }
                    }

                }
            });
            return false;

        } else {
            validationMessage("kkk", "failed validation please check Fields")
            return false;

        }
    }
    return false;
}

function empTypeLoader(empStatId, renderLoc) {
    var field = document.getElementById(empStatId);
    var value = document.getElementById(empStatId).value.toUpperCase();
    field.value = value;
    document.getElementById('field').innerHTML = '<input type="hidden" name="' + empStatId + '" value="' + value + '"/>';
    document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="loadEmpType"/>';
    var form = $('#geolocator');
    $.ajax({
        type: form.attr('method'),
        url: form.attr('action'),
        data: form.serialize(),
        success: function (data) {
            if (data != "") {
                document.getElementById(renderLoc).innerHTML = data
            }
        }
    });
    return false;
}



var geolocator = true;


function geolocatorProcess(fieldId, requestType, renderLocation) {
    toUppercase(fieldId);
    var field = document.getElementById(fieldId);
    var value = document.getElementById(fieldId).value.toUpperCase();
    field.value = value;
    document.getElementById('field').innerHTML = '<input type="hidden" name="' + fieldId + '" value="' + value + '"/>';
    document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="' + requestType + '"/>';
    var form = $('#geolocator');
    $.ajax({
        type: form.attr('method'),
        url: form.attr('action'),
        data: form.serialize(),
        success: function (data) {
            document.getElementById(renderLocation).innerHTML = data;
            geolocator = false;
        }
    });
    return false;
}

function processStreet(fieldId, requestType, renderLocation) {
    if (validateCityStreet(fieldId, 'validateStreet', 300, 0)) {
        geolocatorProcess2(fieldId, requestType, renderLocation)
    }
}

function processTown(fieldId, requestType, renderLocation) {
    if (validateCityStreet(fieldId, 'validateTown', 200, 0)) {
        geolocatorProcess2(fieldId, requestType, renderLocation)
    }
}
function geolocatorProcess2(fieldId, requestType, renderLocation) {
    toUppercase(fieldId);
    if (document.getElementById('states').value.toString() === "25") {
        var field = document.getElementById(fieldId);
        var value = document.getElementById(fieldId).value.toUpperCase();
        field.value = value;
        document.getElementById('field').innerHTML = '<input type="hidden" name="' + fieldId + '" value="' + value + '"/>';
        document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="' + requestType + '"/>';
        var form = $('#geolocator');
        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function (data) {
                document.getElementById(renderLocation).innerHTML = data;
                geolocator = false;
            }
        });
    }
    return false;
}

function getPrintStreet(streetId) {
    var field = document.getElementById(streetId);
    var value = document.getElementById(streetId).value.toUpperCase();
    field.value = value;
    document.getElementById('field').innerHTML = '<input type="hidden" name="' + streetId + '" value="' + value + '"/>';
    document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="getStreet"/>';
    var form = $('#geolocator');
    $.ajax({
        type: form.attr('method'),
        url: form.attr('action'),
        data: form.serialize(),
        success: function (data) {
            if (data !== "") {
                document.getElementById(streetId).value = data
            }
        }
    });
    return false;
}

function getPrintCity(cityId) {
    var field = document.getElementById(cityId);
    var value = document.getElementById(cityId).value.toUpperCase();
    field.value = value;
    document.getElementById('field').innerHTML = '<input type="hidden" name="' + cityId + '" value="' + value + '"/>';
    document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="getCity"/>';
    var form = $('#geolocator');
    $.ajax({
        type: form.attr('method'),
        url: form.attr('action'),
        data: form.serialize(),
        success: function (data) {
            if (data !== "") {
                document.getElementById(cityId).value = data
            }
        }
    });
    return false;
}

function getPrintLcda(lcdaId) {
    var field = document.getElementById(lcdaId);
    var value = document.getElementById(lcdaId).value.toUpperCase();
    field.value = value;
    document.getElementById('field').innerHTML = '<input type="hidden" name="' + lcdaId + '" value="' + value + '"/>';
    document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="getLcda"/>';
    var form = $('#geolocator');
    $.ajax({
        type: form.attr('method'),
        url: form.attr('action'),
        data: form.serialize(),
        success: function (data) {
            if (data !== "") {
                document.getElementById(lcdaId).innerHTML = data
            }
        }
    });
    return false;
}

function updateCity(streetId, cityId, lcdaId) {
    if (document.getElementById('states').value.toString() === "25") {
        var field = document.getElementById(streetId);
        var value = document.getElementById(streetId).value.toUpperCase();
        field.value = value;
        document.getElementById('field').innerHTML = '<input type="hidden" name="' + streetId + '" value="' + value + '"/>';
        document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="updateCity"/>';
        var form = $('#geolocator');
        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function (data) {
                getPrintStreet(streetId);
                getPrintCity(cityId);
                getPrintLcda(lcdaId);
            }
        });
    }
    return false;
}

function updateLcda(cityId, lcdaId) {
    if (document.getElementById('states').value.toString() === "25") {
        var field = document.getElementById(cityId);
        var value = document.getElementById(cityId).value.toUpperCase();
        field.value = value;
        document.getElementById('field').innerHTML = '<input type="hidden" name="' + cityId + '" value="' + value + '"/>';
        document.getElementById('requestType').innerHTML = '<input type="hidden" name="requestType" value="updateLcda"/>';
        var form = $('#geolocator');
        $.ajax({
            type: form.attr('method'),
            url: form.attr('action'),
            data: form.serialize(),
            success: function (data) {
                getPrintCity(cityId);
                getPrintLcda(lcdaId);
            }
        });
    }
    return false;
}

var entitiesload = true;

function loadStateLga(formName, renderLocation) {
    var form = $("#" + formName);
    if (entitiesload) {
        form.submit(function () {
            $.ajax({
                type: form.attr('method'),
                url: form.attr('action'),
                data: form.serialize(),
                success: function (data) {
                    document.getElementById(renderLocation).innerHTML = data;
                    entitiesload = false;
                }
            });
            return false;
        });
    }
}

var process2 = true;

function saveMultipartFormParam(ousideformId, renderLocation, thisInputId, ousideInputId) {
    var thisinput = document.getElementById(thisInputId);
    var outinput = document.getElementById(ousideInputId);
    outinput.value = thisinput.value;
    document.getElementById(renderLocation).innerHTML = "got hia"
    var form = $("#" + ousideformId);
    if (process2) {
        form.submit(function () {
            $.ajax({
                type: ousideformId.attr('method'),
                url: ousideformId.attr('action'),
                data: ousideformId.serialize(),
                success: function (data) {
                    document.getElementById(renderLocation).innerHTML = data;
                    process2 = false;
                }
            });
            return false;
        });
    }
}

var cardbatchprocess = true;

function cardBatchProcess(formName, renderLocation) {
    var processNumber = document.getElementById('processNumber').value
    if (processNumber != null && processNumber != "") {
        document.getElementById('processCardBatch').style.display = "block";
        document.getElementById(renderLocation).innerHTML = processNumber + " Cards are being processed";
    }
}

function searcher(returnPage) {
    var print = '<input type="hidden" class="inputtext" name="respdes" value="' + returnPage + '"/>';
    document.getElementById('generalsearch').innerHTML = print;
    document.getElementById('searchByParams').innerHTML = print;
    displayDialog('dialog');
}

function searcherEn(returnPage) {
    var print = '<input type="hidden" class="inputtext" name="respdes" value="' + returnPage + '"/>';
    document.getElementById('generalsearch2').innerHTML = print;
    document.getElementById('searchByParams2').innerHTML = print;
    displayDialog('dialog2');
}

function successMessage(message, status) {
    showNotification({
        message: status,
        type: "success",
        autoClose: true,
        duration: 5
    });
}
function errorMessage(message, status) {
    showNotification({
        message: status,
        type: "error"
    });
}

function validationMessage(message, status) {
    showNotification({
        message: status,
        type: "error",
        autoClose: true,
        duration: 5
    });
}

function warningMessage(message, status) {
    showNotification({
        message: "'" + message + "' " + status,
        type: "warning"
    });
}

function toUppercase(inputname)
{
    var x = document.getElementById(inputname);
    x.value = x.value.toUpperCase();
}

function render(id, inputName) {
    var x = document.getElementById(inputName);
    if (x.value === "Y") {
        //        alert('1st loop'+x.value)
        document.getElementById(id).style.display = "block";
        x.value = "X";

        return;
    } else if (x.value === "X") {
        document.getElementById(id).style.display = "none";
        x.value = "Y";
        return;
    }
}
function renderUpload(id, inputName) {
    var x = document.getElementById(inputName);
    if (x.value === "Y") {
        //        alert('1st loop'+x.value)
        document.getElementById(id).style.display = "block";
        x.value = "X";

        return;
    } else if (x.value === "X") {
        document.getElementById(id).style.display = "none";
        x.value = "Y";
        return;
    }
}

function others(id, inputName) {
    var print = '<i>Please Specify Others</i> <input type="text" class="inputtext" name="Others" value="" required>'
    var x = document.getElementById(inputName);
    if (x.value === "Other") {
        //        alert('1st loop'+x.value)
        document.getElementById(id).style.display = "block";
        document.getElementById(id).innerHTML = print

    } else {
        document.getElementById(id).style.display = "block";
        document.getElementById(id).innerHTML = ""
    }
//    $(this).checked? document.getElementById(id).style.display="hidden":document.getElementById(id).style.display="block";
}

function othersNew(id, inputName, otherReq) {
    //alert('called')

    var x = document.getElementById(inputName);
    //alert(x.value)
    // 
    if (x.value == "Other") {
        //alert('1st loop'+x.value)
        document.getElementById(id).style.display = "block";
        document.getElementById(otherReq).required = true

    } else {
        document.getElementById(id).style.display = "none";
        document.getElementById(otherReq).removeAttribute('required')
        //alert('removed')

    }
//    $(this).checked? document.getElementById(id).style.display="hidden":document.getElementById(id).style.display="block";
}

function none(inputName, id) {
    var x = document.getElementById(inputName);
    if (x.checked == true) {
        document.getElementById(id).style.display = "none";
    } else if (x.checked == false) {
        document.getElementById(id).style.display = "table";
    }
}

function subFunction(id, inputName) {
    var x = document.getElementById(inputName);
    if (x.value == "Y") {
        //alert('1st loop'+x.value)
        document.getElementById(id).style.display = "table";
        x.value = "X";
        return;
    } else if (x.value != "Y") {
        // alert('2nd loop'+x.value)
        document.getElementById(id).style.display = "none";
        x.value = "Y";
        return;
    }
}

function subDisplayFunction(id, inputName, checked) {
    var a = checked.toString();
    var x = document.getElementById(inputName);
    if (a == "checked" && x.value == "Y" && document.getElementById(id).style.display.toString() == "table") {
        document.getElementById(id).style.display = "none";
        x.value = "X";
    }
    if (x.value == "Y") {
        document.getElementById(id).style.display = "table";
        x.value = "X";
        return;
    } else if (x.value == "X") {
        document.getElementById(id).style.display = "none";
        x.value = "Y";
        return;
    }
}

function otherLan(id, inputName) {
    var x = document.getElementById(inputName);
    //alert('1st loop'+x.value)
    if (x.value == "OTHER") {
        //alert('1st loop'+x.value)
        document.getElementById(id).style.display = "block";
        document.getElementById(id).innerHTML = 'Other Primary Language:<input type="text" name="primaryLanguageOther" id="primaryLanguageOther" onchange="toUppercase("primaryLanguageOther")"  class="inputtext" value="" required/>'

        return;
    } else {
        document.getElementById(id).style.display = "none";
        return;
    }
//    $(this).checked? document.getElementById(id).style.display="hidden":document.getElementById(id).style.display="block";
}

function visible(id) {
    $("td").click(function () {
        document.getElementById(id).style.display = "block";

    });
}

function selectedMarrital() {
    return "selected";
}


var fullDate = new Date();
var maxdate = fullDate.getMonth() + "/" + fullDate.getDate() + "/" + fullDate.getFullYear()

var twoDigitMonth = ((fullDate.getMonth().length + 1) === 1) ? (fullDate.getMonth() + 1) : '0' + (fullDate.getMonth() + 1);

$('#startdate').datepicker({
    maxDate: twoDigitMonth + "/" + fullDate.getDate() + "/" + fullDate.getFullYear(),
    beforeShowDay: disableSpecificWeekDays
});


function disableSpecificWeekDays(date) {
    if (date.getDay() == 0) {
        return [true];
    } else {
        return [false];
    }
}

function passwordChecker(passwo, checkerId, buttonid) {
    var password = document.getElementById(passwo).value.toString();
    if (password.length < 6) {
        document.getElementById(checkerId).innerHTML = '<i style="color:red;">Most not be less than six Characters</i>'
        document.getElementById(buttonid).innerHTML = '<input type="submit" disabled value="create user" style="padding: 5px; float: right;" required />'
    } else {
        document.getElementById(checkerId).innerHTML = ''
    }
}

function passwordCheckerEd(passwo, checkerId, buttonid) {
    var password = document.getElementById(passwo).value.toString();
    if (password.length < 6) {
        document.getElementById(checkerId).innerHTML = '<i style="color:red;">Most not be less than six Characters</i>'
        document.getElementById(buttonid).innerHTML = '<input align="center" type="submit" disabled value="create user" style="float: right;" required>'
    } else {
        document.getElementById(checkerId).innerHTML = ''
    }
}

function resetpasswordChecker(passwo, checkerId, buttonid) {
    var password = document.getElementById(passwo).value.toString();
    if (password.length < 6) {
        document.getElementById(checkerId).innerHTML = '<i style="color:red;">Most not be less than six Characters</i>'
        document.getElementById(buttonid).innerHTML = '<input type="submit" disabled value="ChangePassword" style="padding: 10px; float: right;" required />'
    } else {
        document.getElementById(checkerId).innerHTML = ''
    }
}

function resetpasswordConfirm(pass, passConfirm, check2, butid) {
    var password = document.getElementById(pass).value.toString();
    var confirmpassword = document.getElementById(passConfirm).value.toString();
    if (password != confirmpassword || password.length < 6) {
        document.getElementById(butid).innerHTML = '<input type="submit" disabled value="ChangePassword" style="padding: 10px; float: right;" required />'
        document.getElementById(check2).innerHTML = '<i style="color:red;">password fields Do not Match</i>'
    } else {
        document.getElementById(check2).innerHTML = ''
        document.getElementById(butid).innerHTML = '<input type="submit" value="ChangePassword" style="padding: 10px; float: right;" required />'
    }
}

function passwordConfirm(passwo, passwordConfirm, checker2, buttonid) {
    var password = document.getElementById(passwo).value.toString();
    var confirmpassword = document.getElementById(passwordConfirm).value.toString();
    if (password != confirmpassword || password.length < 6) {
        document.getElementById(buttonid).innerHTML = '<input type="submit" disabled value="create user" style="padding: 5px; float: right;" required />'
        document.getElementById(checker2).innerHTML = '<i style="color:red;">password fields Do not Match</i>'
    } else {
        document.getElementById(checker2).innerHTML = ''
        document.getElementById(buttonid).innerHTML = '<input type="submit" value="create user" style="padding: 5px; float: right;" required />'
    }
}

function passwordConfirmEd(passwo, passwordConfirm, checker2, buttonid) {
    var password = document.getElementById(passwo).value.toString();
    var confirmpassword = document.getElementById(passwordConfirm).value.toString();
    if (password != confirmpassword || password.length < 6) {
        document.getElementById(buttonid).innerHTML = '<input align="center" id="edbuttonsubit" disabled type="submit" value="Submit" style="float: right; padding: 20px;">'
        document.getElementById(checker2).innerHTML = '<i style="color:red;">password fields Do not Match</i>'
    } else {
        document.getElementById(checker2).innerHTML = ''
        document.getElementById(buttonid).innerHTML = '<input align="center" id="edbuttonsubit" type="submit" value="Submit" style="float: right; padding: 20px;">'
    }
}



function validateName(Id, validatorId) {
    var name = document.getElementById(Id);
    var checker = 0;
    var message = "";
    //alert(name.value)
    name.value = name.value.toUpperCase();
    // alert(name.value)
    var iChars = "!@#$€%^&*()+=£`€¦¬~_[]\\\';,./{}|\":<>?";
    //alert(name.value)
    var numbers = "1234567890";
    var hyphenCount = 0;
    for (var i = 0; i < name.value.length; i++) {
        //  alert(name.value)
        if (iChars.indexOf(name.value.charAt(i)) != -1) {
            //alert("checking")
            message = "Special Characters are not allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }

        else if (numbers.indexOf(name.value.charAt(i)) != -1) {
            //            alert("checking")
            message = "Numbers not allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }
        else if ("-".indexOf(name.value.charAt(i)) != -1) {
            ++hyphenCount;
            if ("-".indexOf(name.value.charAt(i + 1)) != -1) {
                message = "hyphen not allowed at the end of a name";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
            if ("-".indexOf(name.value.charAt(i)) == name.length) {
                message = "hyphen not allowed at the end of a name";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
        }
        else if (hyphenCount > 1) {
            message = "hyphen could only be used Once";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }
        else if (name.value.charAt(i) == '\u0020') {
            message = "Space is not allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }
    }
    document.getElementById(validatorId).innerHTML = message
    if (checker == 0) {
        // alert(true)
        return valLength(Id, validatorId, 50, 0);
    } else {
        name.focus();
        //alert(false)
        return false;
    }
}

function validateMobileNo(Id, validatorId) {
    var name = document.getElementById(Id);
    var checker = 0;
    var message = "";
    name.value = name.value.toUpperCase();
    var iChars = "+-()";
    var numbers = "1234567890";
    if (name.value.length > 0) {
        for (var i = 0; i < name.value.length; i++) {
            if ((iChars.indexOf(name.value.charAt(i)) == -1) && (numbers.indexOf(name.value.charAt(i)) == -1)) {
                //  alert("checking...1")
                message = "Invalid Phone Number";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
        }
        if (checker == 0) {
            // alert(name.value.length)
            {
                if (name.value.length < 11) {
                    // alert('comparing ' +name.value.length+' with ' + 11)
                    message = "Must not be less than 11 Characters";
                    document.getElementById(validatorId).innerHTML = message
                    ++checker;
                }
                else if (name.value.length == 11) {
                    //alert('was equals to 11')
                    {
                        if (name.value.charAt(0) == '0') {
                            name.value = '+234' + name.value.substr(1, name.value.toString().length)
                        } else {
                            message = "Valid format +23480XXXXXXXX and 80XXXXXXXX";
                            document.getElementById(validatorId).innerHTML = message
                            ++checker;
                        }
                    }
                }
                else if (name.value.length == 10) {
                    name.value = '+234' + name.value
                }
                else if (name.value.length < 10) {
                    message = "Must not be less than 11 Characters";
                    document.getElementById(validatorId).innerHTML = message
                    ++checker;
                }
                else if (name.value.length > 11) {
                    //alert('greater than 11 ****** ' +name.value.length)
                    {
                        if (name.value.length == 14) {
                            // alert('equal to 14 **** ')
                            var val = name.value.toString()
                            if (!val.substring(0, 4) == '+234') {
                                message = "Country code must begin Phone Number";
                                document.getElementById(validatorId).innerHTML = message
                                ++checker;
                                message = "Invalid Phone Number";
                                document.getElementById(validatorId).innerHTML = message
                                ++checker;
                            }
                        } else if (name.value.length < 14) {
                            message = "Valid format +23480XXXXXXXX and 80XXXXXXXX";
                            document.getElementById(validatorId).innerHTML = message
                            ++checker;
                        } else if (name.value.length > 14) {
                            message = "Invalid format";
                            document.getElementById(validatorId).innerHTML = message
                            ++checker;
                        }
                    }
                }

            }
        }
    }

    if (checker == 0) {
        //alert('true')
        message = "";
        document.getElementById(validatorId).innerHTML = message
        return true;
    } else {
        name.focus();
        return false;
    }
}

function validatePhoneNo(Id, validatorId) {
    var name = document.getElementById(Id);
    var checker = 0;
    var message = "";
    name.value = name.value.toUpperCase();
    var iChars = "+-()";
    var numbers = "1234567890";
    if (name.value.length > 0) {
        for (var i = 0; i < name.value.length; i++) {
            if ((iChars.indexOf(name.value.charAt(i)) == -1) && (numbers.indexOf(name.value.charAt(i)) == -1)) {
                //  alert("checking...1")
                message = "Valid formats 01xxxxxx and 08080xxxxxxxx";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
        }
        if (checker == 0) {
            //alert('true')
            message = "";
            document.getElementById(validatorId).innerHTML = message
            return valLength(Id, validatorId, 14, 8);
        } else {
            name.focus();
            return false;
        }
    } else {
        return true;
    }
}

function validateEmployer(Id, validatorId) {
    var emp = document.getElementById(Id);
    var val = valLength(Id, validatorId, 100, 0)
    if (val) {
        if (emp.value.length < 5) {
            document.getElementById(validatorId).innerHTML = 'Abbreviation is not allowed';
            return false;
        } else {
            document.getElementById(validatorId).innerHTML = '';
            return true;
        }
    } else {
        return val;
    }
}

function validateCityStreet(Id, validatorId, maxNum, minNum) {
    var name = document.getElementById(Id);
    var checker = 0;
    var message = "";
    //alert(name.value)
    name.value = name.value.toUpperCase();
    // alert(name.value)
    var iChars = "!@#$€%^&*()+=£`€¦¬~_[]\\\';./{}|\":<>?";
    //alert(name.value)
    var numbers = "1234567890";
    var hyphenCount = 0;
    for (var i = 0; i < name.value.length; i++) {
        //  alert(name.value)
        if (iChars.indexOf(name.value.charAt(i)) != -1) {
            //alert("checking")
            message = "Special Characters are not allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }

        else if (numbers.indexOf(name.value.charAt(i)) != -1) {
            //            alert("checking")
            message = "Numbers not allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }
        else if ("-".indexOf(name.value.charAt(i)) != -1) {
            ++hyphenCount;
            if ("-".indexOf(name.value.charAt(i + 1)) != -1) {
                message = "hyphen not allowed at the end of a name";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
            if ("-".indexOf(name.value.charAt(i)) == name.length) {
                message = "hyphen not allowed at the end of a name";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
        }
        else if (hyphenCount > 1) {
            message = "hyphen could only be used Once";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }

    }
    document.getElementById(validatorId).innerHTML = message
    if (checker == 0) {
        // alert(true)
        return valLength(Id, validatorId, maxNum, minNum);
    } else {
        name.focus();
        //alert(false)
        return false;
    }
}

function valHouseNum(Id, validatorId, maxlenght, minlenght) {
    var name = document.getElementById(Id);
    var checker = 0;
    var message = "";
    //alert(name.value)
    name.value = name.value.toUpperCase();
    // alert(name.value)
    var iChars = "!@#$€%^&*()+=£`€¦¬~[]\\\';,.{}|\":<>?";
    //alert(name.value)

    var hyphenCount = 0;
    for (var i = 0; i < name.value.length; i++) {
        //  alert(name.value)
        if (iChars.indexOf(name.value.charAt(i)) != -1) {
            //alert("checking")
            message = "Alphanumeric, '-' and '/' allowed";
            document.getElementById(validatorId).innerHTML = message
            ++checker;
        }
        else if ("-/".indexOf(name.value.charAt(i)) != -1) {
            ++hyphenCount;
            if ("-/".indexOf(name.value.charAt(i + 1)) != -1) {
                message = " invalid usage of '-' and '/'";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
            if (i == 1) {
                message = " '-' and '/' not allowed at the begining";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
            if (i == name.value.length) {
                message = " '-' and '/' not allowed at the end";
                document.getElementById(validatorId).innerHTML = message
                ++checker;
            }
        }
    }


    document.getElementById(validatorId).innerHTML = message
    if (checker == 0) {
        // alert(true)
        return valLength(Id, validatorId, maxlenght, minlenght);
    } else {
        name.focus();
        //alert(false)
        return false;
    }
}


function checkdate(dateI, messageloc) {
    var validformat = /^\d{4}\-\d{2}\-\d{2}$/ //Basic check for format validity
    var returnval = false
    var valDate = document.getElementById(dateI)
    {
        if (!validformat.test(valDate.value) || valDate.value.length == 0) {
            // alert(' *** true *** ')
            document.getElementById(messageloc).innerHTML = "Invalid Date Format, Please use Datepicker";
            returnval = false
        } else {
            //alert(' *** loop 2 *** ')
            var yearfield = valDate.value.split("-")[0]
            var monthfield = valDate.value.split("-")[1]
            var dayfield = valDate.value.split("-")[2]
            var dayobj = new Date(yearfield, monthfield - 1, dayfield);
            var today = new Date();
            {
                if (parseInt(monthfield) > 12) {
                    document.getElementById(messageloc).innerHTML = "Invalid Month";
                }
                else if (parseInt(dayfield) > 31) {
                    document.getElementById(messageloc).innerHTML = "Invalid Day";
                    returnval = false
                } else if (parseInt(yearfield) < 1850) {
                    document.getElementById(messageloc).innerHTML = "Invalid Year";
                    returnval = false
                }
                else if ((dayobj.getMonth() + 1 != monthfield) || (dayobj.getDate() != dayfield) || (dayobj.getFullYear() != yearfield)) {
                    document.getElementById(messageloc).innerHTML = "Invalid Day, Month, or Year range detected. Please correct and submit again.";
                }
                else if (monthfield > 12) {
                    document.getElementById(messageloc).innerHTML = "Invalid Month";
                }
                else if (dayfield > 31) {
                    document.getElementById(messageloc).innerHTML = "Invalid Day";
                }
                else if (dayobj > today) {
                    document.getElementById(messageloc).innerHTML = "Future date not allowed";
                }
                else if (dayfield > 31) {
                    document.getElementById(messageloc).innerHTML = "Invalid Day";
                }
                else {
                    document.getElementById(messageloc).innerHTML = "";
                    returnval = true

                }
            }

        }
    }
    if (returnval == false) {
        valDate.focus();
    }

    return returnval
}


function checkAdultDate(dateId, messageloc) {
    var validformat = /^\d{4}\-\d{2}\-\d{2}$/ //Basic check for format validity
    var returnval = false
    var input = document.getElementById(dateId)
    if (!validformat.test(input.value)) {
        document.getElementById(messageloc).innerHTML = "Invalid Date Format, Please use Datepicker";
    }
    else {
        var yearfield = input.value.split("-")[0]
        var monthfield = input.value.split("-")[1]
        var dayfield = input.value.split("-")[2]
        var dayobj = new Date(yearfield, monthfield - 1, dayfield);
        var today = new Date();
        if ((dayobj.getMonth() + 1 != monthfield) || (dayobj.getDate() != dayfield) || (dayobj.getFullYear() != yearfield)) {
            document.getElementById(messageloc).innerHTML = "Invalid Day, Month, or Year range detected. Please correct and submit again.";
        }
        if (dayobj > today) {
            document.getElementById(messageloc).innerHTML = "Future date not allowed";
        }
        else if ((today.getYear() - dayobj.getYear()) < 16) {
            document.getElementById(messageloc).innerHTML = "Date below adult age range";
        }
        else if ((today.getYear() - dayobj.getYear()) == 16) {
            if (today.getMonth() < dayobj.getMonth()) {
                document.getElementById(messageloc).innerHTML = "Date below adult age range";
            } else if (today.getMonth() == dayobj.getMonth()) {
                if (today.getDate() < dayobj.getDate()) {
                    document.getElementById(messageloc).innerHTML = "Date below adult age range";
                } else if (today.getDate() >= dayobj.getDate()) {
                    document.getElementById(messageloc).innerHTML = "";
                    returnval = true
                }
            } else {
                document.getElementById(messageloc).innerHTML = "";
                returnval = true
            }
        }
        else {
            document.getElementById(messageloc).innerHTML = "";
            returnval = true
        }
    }
    if (returnval == false)
        input.focus();
    return returnval
}
//function trim(inputname){
//     var x=document.getElementById(inputname);
//     if(x.value.toString().contains(" ")){
//     x.value = x.value.toString().replac
//     }
// }



//function Redirect()
//{
//    window.location="Login.jsp";
//}
//
//document.write("You will be redirected to main page in 10 sec.");
//setTimeout('Redirect()', 10000);


//var oReq = new XMLHttpRequest();
//
//oReq.addEventListener("progress", updateProgress, false);
//oReq.addEventListener("load", transferComplete, false);
//oReq.addEventListener("error", transferFailed, false);
//oReq.addEventListener("abort", transferCanceled, false);
//
//oReq.open();
//
//// ...
//
//// progress on transfers from the server to the client (downloads)
//function updateProgress (oEvent) {
//  if (oEvent.lengthComputable) {
//    var percentComplete = oEvent.loaded / oEvent.total;
//    // ...
//  } else {
//    // Unable to compute progress information since the total size is unknown
//  }
//}
//
//function transferComplete(evt) {
//  alert("The transfer is complete.");
//}
//
//function transferFailed(evt) {
//  alert("An error occurred while transferring the file.");
//}
//
//function transferCanceled(evt) {
//  alert("The transfer has been canceled by the user.");
//}



function nameChanged()
{

    var ret = false;

    if (checkdate('dateofChange', 'd_o_c'))
    {
        if (validateName('firstName', 'val_f_n'))
        {
            if (validateName('middleName', 'val_m_n'))
            {
                if (validateName('lastName', 'val_l_n'))
                {
                    if (valLengthAlleters('OthersReq', 'val_other', 50, 0))
                    {
                        ret = valLength('reference', 'val_ref', 50, 3);
                    }
                }
            }
        }
    }
    return ret;
}


function addressChanged()
{
    //alert("about to")
    var ret = false;

    if (checkdate('dateofChange', 'd_o_c'))
    {
        if (valHouseNum('houseNumber', 'validateHouseNumber'))
        {
            if (alphanumericOptional('flatNumber', 'validateFlatNumber'))
            {
                //                if(valHouseNum('street','validateStreet'))  
                //                {
                //                    ret = valHouseNum('currentTown','validateTown');
                //                }
                if (alphanumericOptional('flatNumber', 'validateFlatNumber', 150, 0)) {
                    if (valLengthAlleters('OthersReq', 'val_other', 50, 0))
                    {
                        ret = valLength('reference', 'val_ref', 50, 3);
                    }
                }
            }
        }
    }
    return ret;
}

function validateUserCreation() {
    var ret = false;
    if (alphanumeric('userNameCu', 'usrNamVal'))
    {
        if (allLetter('firstNameCu', 'usrfsVal'))
        {
            if (allLetter('lastNameCu', 'usrlsVal'))
            {
                if (ValidateEmail('usremail', 'usremVal'))
                {
                    ret = alphanumeric('usrPhone', 'usrPnVal');
                }
            }
        }
    }
    return ret;
}

function maritalChanged()
{
    //alert("about to")
    var ret = false;
    if (checkdate('dateofChange', 'd_o_c')) {
        if (valLengthAlleters('OthersReq', 'val_other', 50, 0))
        {
            ret = valLength('reference', 'val_ref', 50, 3);
        }
    }
    return ret;
}


function genderChanged()
{
    var ret = false;
    if (checkdate('dateofChange', 'd_o_c')) {
        if (valLengthAlleters('OthersReq', 'val_other', 50, 0))
        {
            ret = valLength('reference', 'val_ref', 50, 3);
        }
    }
    return ret;
}

function dobChanged()
{
    var ret = false;
    if (checkdate('dateOfChange', 'd_o_c'))
    {
        if (checkAdultDate('dateOfbirth', 'd_o_b'))
        {
            if (valLengthAlleters('OthersReq', 'val_other', 50, 0))
            {
                ret = valLength('reference', 'val_ref', 50, 3);
            }
        }
    }
    return ret;
}

function lostCards()
{
    //alert("about to")
    var dateOfLost = document.lostcard.lostDate;
    var lostLoc = document.lostcard.location;
    var ret = false;
    if (allLetter(lostLoc, 'l_o_l'))
    {
        if (checkdate(dateOfLost, 'd_o_l'))

        {
            ret = checkdate(dateOfLost, 'd_o_l');
        }
    }
    return ret;
}

function demograpicUpdateChecker()
{
    var ret = false;
    if (validateName('maidenName', 'val_mdn_n')) {
        if (validateName('previousName', 'val_prevN')) {
            if (valLengthAlleters('placeOfBirth', 'p_o_b', 120, 1)) {
                if (validateMobileNo('phone', 'val_phone')) {
                    if (validateMobileNo('otherPhone', 'val_other_phone')) {
                        if (ValidateEmail('Uemail', 'e_mail')) {
                            if (validateEmployer('employer', 'emp')) {
                                if (valLength('officeAddress', 'empAddress', 100, 0)) {
                                    if (validatePhoneNo('officePhone', 'empPhone')) {
                                        if (alphanumericOptional('nationalId', 'val_natn_Id', 80, 0)) {
                                            if (alphanumericOptional('passportNo', 'val_pass_No', 50, 0)) {
                                                ret = alphanumericOptional('driversLicenseNumber', 'val_driv_lic', 150, 0)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    // alert("done ret is **** " + ret)
    return ret;

}

function dataCorrectionVal()
{
    var ret = false;
    if (validateName('firstName', 'val_f_n')) {
        if (validateName('middleName', 'val_m_n')) {
            if (validateName('lastName', 'val_l_n')) {
                if (validateName('maidenName', 'val_mdn_n')) {
                    if (validateName('previousName', 'val_prevN')) {
                        if (valLengthAlleters('placeOfBirth', 'p_o_b', 120, 1)) {
                            if (checkAdultDate('dateOfbirth', 'd_o_b')) {
                                if (valHouseNum('houseNumber', 'validateHouseNumber', 50, 0)) {
                                    if (alphanumericOptional('flatNumber', 'validateFlatNumber', 150, 0)) {
                                        if (validateCityStreet('street', 'validateStreet', 300, 0)) {
                                            if (validateCityStreet('currentTown', 'validateStreet', 200, 0)) {
                                                if (validateMobileNo('phone', 'val_phone')) {
                                                    if (validateMobileNo('otherPhone', 'val_other_phone')) {
                                                        if (ValidateEmail('Uemail', 'e_mail')) {
                                                            if (validateEmployer('employer', 'emp')) {
                                                                if (valLength('officeAddress', 'empAddress', 100, 0)) {
                                                                    if (validatePhoneNo('officePhone', 'empPhone')) {
                                                                        if (alphanumericOptional('nationalId', 'val_natn_Id', 80, 0)) {
                                                                            if (alphanumericOptional('passportNo', 'val_pass_No', 50, 0)) {
                                                                                ret = alphanumericOptional('driversLicenseNumber', 'val_driv_lic', 150, 0)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }


    // alert("done ret is **** " + ret)
    return ret;
}


function userid_validation(uid, mx, my)
{
    var uid_len = uid.value.length;
    if (uid_len == 0 || uid_len >= my || uid_len < mx)
    {
        alert("User Id should not be empty / length be between " + mx + " to " + my);
        uid.focus();
        return false;
    }
    return true;
}

function allLetter(uname, messageloc)
{
    var val = document.getElementById(uname)
    var vali = val.value
    var letters = /^[A-Za-z\s]+$/;

    if (vali.length > 0)
    {
        if (vali.match(letters))
        {
            document.getElementById(messageloc).innerHTML = "";
            return true;
        } else
        {
            //alert('Username must have alphabet characters only');
            document.getElementById(messageloc).innerHTML = "Alphabet characters only";
            val.focus();
            return false;
        }

    }

    else
    {
        return true;
    }
}

function valLength(id, renderLoc, maxLenght, minlength) {
    toUppercase(id)
    var val = document.getElementById(id)
    var valvalue = val.value
    if (valvalue.length < minlength) {
        document.getElementById(renderLoc).innerHTML = 'Must be more than ' + minlength + ' Characters'
        val.focus();
        return false;
    }
    if (valvalue.length > maxLenght) {
        document.getElementById(renderLoc).innerHTML = 'Must not be more than ' + maxLenght + ' Characters'
        val.focus();
        return false;
    }
    document.getElementById(renderLoc).innerHTML = ''
    return true
}

function valLengthAlleters(id, renderLoc, maxLenght, minlength) {
//alert('next')
    toUppercase(id)
    if (allLetter(id, renderLoc)) {
        var val = document.getElementById(id)
        var valvalue = val.value
        if (valvalue.length == 0) {
            //alert('true')
            if (valvalue.length < minlength) {
                document.getElementById(renderLoc).innerHTML = 'Must be more than ' + minlength + ' Characters'
                val.focus();
                return false;
            }
            if (valvalue.length > maxLenght) {
                document.getElementById(renderLoc).innerHTML = 'Must not be more than ' + maxLenght + ' Characters'
                val.focus();
                return false;
            }
            document.getElementById(renderLoc).innerHTML = ''
            return true
        }
        return true
    }
    return false;
}

function alphanumeric(uadd, renderLoc, maxlenght, minlenght)
{  //alert("alphanumeric true.....")
    var value = document.getElementById(uadd).value
    var letters = /^[0-9a-zA-Z]+$/;
    if (value.match(letters))
    {
        //alert("alphanumeric true.....")
        document.getElementById(renderLoc).innerHTML = "";
        return valLength(uadd, renderLoc, maxlenght, minlenght);
    }
    else
    {  //alert("alphanumeric false.....")
        document.getElementById(renderLoc).innerHTML = "Field is alphanumeric ";
        uadd.focus();
        return false;
    }
}

function alphanumericOptional(uadd, renderLoc, maxlenght, minlenght)
{
    var value = document.getElementById(uadd).value
    var letters = /^[0-9a-zA-Z]+$/;
    {
        if (value.length > 0) {
            if (value.match(letters))
            {
                //alert("alphanumeric true.....")
                document.getElementById(renderLoc).innerHTML = "";
                return valLength(uadd, renderLoc, maxlenght, minlenght);
            }
            else
            {  //alert("alphanumeric false.....")
                document.getElementById(renderLoc).innerHTML = "Field is alphanumeric ";
                uadd.focus();
                return false;
            }
        } else {
            return true;
        }
    }
}



function ValidateEmail(email, messageLoc)
{
    var uemail = document.getElementById(email);
    if (uemail.value.length > 0) {
        var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        if (uemail != null && uemail.value.match(mailformat))
        {
            document.getElementById(messageLoc).innerHTML = "";
            return true;
        }
        else
        {
            document.getElementById(messageLoc).innerHTML = "invalid email address!";
            //        alert("You have entered an invalid email address!");  
            uemail.focus();
            return false;
        }
    } else {
        document.getElementById(messageLoc).innerHTML = "";
        return true;
    }
}

function ValidateUpdateEmail(uemail, messageLoc)
{
    var emailval = document.getElementById(uemail)
    if (emailval.value.length == 0)
    {
        document.getElementById(messageLoc).innerHTML = "";
        return true;
    }
    var mailformat = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (emailval != null && emailval.value.match(mailformat))
    {
        document.getElementById(messageLoc).innerHTML = "";
        return true;
    }
    if (emailval.value.length == 0)
    {
        document.getElementById(messageLoc).innerHTML = "";
        return true;
    }
    else
    {
        document.getElementById(messageLoc).innerHTML = "invalid email address!";
        //        alert("You have entered an invalid email address!");  
        emailval.focus();
        return false;
    }
}  