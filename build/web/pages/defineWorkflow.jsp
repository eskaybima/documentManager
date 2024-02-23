
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="com.fasyl.vo.ParameterValues"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create/Modify User Group</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>
        <script type="text/javascript" src="js/defineWorkflow.js"></script>
        </head>
        <body id="background" onload="loadValues('template')">
            <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
                <div class="page-content">
                <jsp:include page="header.jsp"></jsp:include>

                    <div class="page-content-wrap">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">

                            <%!
                                List<String> allUsers;
                                SaveToDb sb = new SaveToDb();
                                List<String> authorizers;
                                String template;
                                String taskType;
                            %>                      

                            <%

                                template = (String) session.getAttribute("template");
                                allUsers = sb.getList2("select user_id from fas_mst_users");
                                authorizers = (List<String>) request.getAttribute("authorizers");

                                if (authorizers.isEmpty()) {
                                    taskType = "Define";
                                } else {
                                    taskType = "Modify";
                                }
                            %>

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title text-primary"><%=taskType%> Work Flow </h4>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="well well-lg">

                                            <table align = "centered"  class="table table-bordered">
                                                <thead>
                                                    <tr>

                                                        <th width="90%"><Strong><%="TEMPLATE                        " + template.toUpperCase()%></strong></th>
                                                        <th width="10%"></th>
                                                    </tr>
                                                </thead>
                                               
                                             
                                            </table>


                                            <div id="set_up_form"> 
                                                <table align ="center" class="table table-bordered"  id="set_up">
                                                    <thead>
                                                        <tr>
                                                            <th align ="center" width="50%">User Id</th>
                                                            <th align ="center" width="40%">Authorisation Level</th>  
                                                            <th align ="center" width="10%">DELETE</th>  
                                                        </tr>
                                                    </thead>
                                                    </table>




                                                    <table align ="center" class="table table-striped table-bordered table-hover">
                                                        <thead>
                                                            <tr>
                                                                <th align ="center" width="50%"></th>
                                                                <th align ="center" width="40%"></th>  
                                                                <th align ="center" width="10%"></th>  
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                               <td> 
                                                                    <input type="hidden" name ="control" value ="addParameter"/>
                                                                        <select class="form-control select" data-live-search="true" name="dataType" value=""  autocomplete="off" id="dataType"/>
                                                                        <option value="Select"></option>
                                                                        <% for (int i = 0; i < allUsers.size(); i++) {
                                                                                if (!authorizers.contains(allUsers.get(i))) {
                                                                        %>
                                                                        <option value="<%= allUsers.get(i)%>"><%= allUsers.get(i)%></option>
                                                                        <%   }
                                                                            }%>
                                                                        </select>
                                                                </td>
                                                                <td>
                                                                    <input type="number" class="form-control" placeholder="parameter" id="parameter" autocomplete="off" name="parameter" value=""/></td>
                                                                </td>
                                                                <td>
                                                                    <button class="btn btn-success btn-block"  id="add_form_field"  type="submit"></b>Add</button>
                                                               </td>
                                                            </tr>
                                                            <tr>
                                                             <td></td><td></td><td><button class="btn btn-success btn-block" id="sendajax" type="submit"></b>Submit</button></td>   
                                                            </tr>
                                                        </tbody>
                                                    </table>  
                                            </div>



                                            <br><br><br>



                                        </div>
                                    </div>
                                </div> --
                            </div>
                        </div>
                    </div>
                </div>
                <p id="loghc" style="height: 10px; display: none;"> </p>   

              
                
                <script>
                 $('#add_form_field').on('click', function (e) {
        e.preventDefault();
        var parameter = $('#set_up_form').find('input[name="parameter"]').val();
        var dataType = $('#set_up_form').find('select[name="dataType"]').val();
        document.getElementById('parameter').value = '';
        $('#set_up').append('<tr><td>' + dataType + '</td><td>' + parameter + '</td><td>' + '<a class="btn btn-md btn-danger btnNext">  Delete</a>' + '</td></tr>')
       });   
                
       $('#set_up').on('click', ".btnNext", function () {
        var checkstr = confirm('are you sure you want to delete this?'); 
        if (checkstr === true) { 
            $('#set_up').DataTable().row($(this).parents('tr')).remove().draw();
        } else {
            return false;
        }
    });
    
      
       
        $('#sendajax').on('click', function () {
            var checkstr = confirm('are you sure you want to Submit');
             if (checkstr === true) { 
                  sendAjax();
             }
    });
    
    
     function convertArrayToJSON()
    {
        var TableData;
        TableData = JSON.stringify(storeTblValues());
        return TableData;
    }

    
    function storeTblValues()
    {
        var TableData = new Array();
        $('#set_up tr').each(function (row, tr) {
            TableData[row] = {
                "userId": $(tr).find('td:eq(0)').text().trim()
              , "authLevel": $(tr).find('td:eq(1)').text().trim()
            }
        });
        TableData.shift();  // first row will be empty - so remove
        //  $('#tbServerResponseArray').val(TableData);
        return TableData;
    }
    
    function sendAjax() {
        var tableDataJson = convertArrayToJSON();
    $.ajax({
        url: "DefineWorkFlow",
        type: 'POST',
        dataType: 'json',
        data: tableDataJson,
        contentType: 'application/json',
        mimeType: 'application/json',
        success: function (response) {
                 var result = response['valid'];
                    window.location.replace("pages/homepage.jsp");
            },
            error: function (data, status, er) {
                //          alert("error: "+data+" status: "+status+" er:"+er);
            }
    });
    return posting_result;
    }
                
                
                
                </script>
  
                
                </body>
                </html>
