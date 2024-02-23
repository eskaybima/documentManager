<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
          <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Upload New Job</title>
        <jsp:include page="pagesimport.jsp"></jsp:include>
        </head>
        <body id="background">
        <jsp:include page="header.jsp"></jsp:include>   
        <jsp:include page="leftMenu.jsp"></jsp:include> 

            <div id="bodyhold">
                <div id="bodycon">  

                <%!
                    String passportNumber = "";
                    String surname = "";
                    String firstname = "";
                    String middlename = "";
                    String state = "";
                    String dob = "";
                    String sex = "";
                    String country = "";
                    String offset = null;
                    List<String> imageList;
                %>



                <% 
                    
                    imageList = (List<String>) request.getAttribute("documents");
                    if (imageList == null) {
                        imageList = new ArrayList<String>();
                    }
                    if ((String) request.getAttribute("offset") != null) {
                        passportNumber = (String) request.getAttribute("passportNumber");
                        surname = (String) request.getAttribute("surname");
                        firstname = (String) request.getAttribute("firstname");
                        middlename = (String) request.getAttribute("middlename");
                        state = (String) request.getAttribute("state");
                        sex = (String) request.getAttribute("sex");
                        country = (String) request.getAttribute("country");
                        dob = (String) request.getAttribute("dob");
                     }
                     if ((String) request.getAttribute("start") != null) {
                        passportNumber = "";
                        surname = "";
                        firstname = "";
                        middlename = "";
                        state = "";
                        dob = "";
                        country = "";
                        sex = "";
                     }

                %>

                <form action ="${pageContext.request.contextPath}/ImageUpload" method ="post" enctype="multipart/form-data">
                    <table class="table">
                        
                        <tr>
                            <td> Reference Id:  
                            <td><%= session.getAttribute("applicationId")%>
                        </tr>
                        
                        <tr>
                            <td> Passport Number: 
                            <td><input type="text" maxlength="10" name="passportNumber" value="<%=passportNumber%>" id="passportNumber" onchange="renderElseWhere('passportNumber', 'loghc')" required/> 
                        </tr>
                        <tr>
                            <td> Surname: 
                            <td><input type="text" name="surname" value="<%=surname%>" id="surname" onchange="renderElseWhere1('surname', 'loghc')" required/>
                        </tr>
                        <tr>
                            <td> First Name: 
                            <td><input type="text" name="firstname" value="<%=firstname%>" id="firstname" onchange="renderElseWhere2('firstname', 'loghc')" required/>
                        </tr>
                        <tr>
                            <td> Middlename: 
                            <td><input type="text" name="middlename" value="<%=middlename%>" id="middlename" onchange="renderElseWhere3('middlename', 'loghc')" required/>
                        </tr>
                        <tr>
                            <td>Date of Birth: 
                                 <td><input readonly="true" class="inputtext" type="text" name="dob" value="<%=dob%>" id="onrp_dob" onchange="renderElseWhere4('onrp_dob', 'loghc')" required/>
                           <!-- <td><input type="text" name="dob" value="<%=dob%>" id="dob" onchange="renderElseWhere4('dob', 'loghc')" required/> -->
                        </tr>
                        <tr>
                            <td>State of Origin: 
                            <td><input type="text" class="inputtext" name="state" value="<%=state%>" id="state" onchange="renderElseWhere5('state', 'loghc')" required/> 
                        </tr>
                        
                        <tr>
                            <td>Sex: 
                          <!--  <td><input type="text" name="sex" value="<%=sex%>" id="sex" onchange="renderElseWhere7('sex', 'loghc')" required/> -->
                            
                            <td> <select type="text" class="inputtext" name="sex" value="<%=sex%>" id="sex" onchange="renderElseWhere7('sex', 'loghc')" required/>
                                <option value="">select sex</option>
                                <% if (sex.equalsIgnoreCase("")) {%>     
                                 <option value="MALE">MALE</option>
                                 <option value="FEMALE">FEMALE</option>
                                </select>
                                      <% } else {%>
                                      <td><input type="text" class="inputtext" name="sex" value="<%=sex%>" id="sex" onchange="renderElseWhere7('state', 'loghc')" required/> 
                                       <%}%>
                        </tr>
                        
                        <tr>
                            <td>Country: 
                            <td><input type="text" name="country" value="<%=country%>" id="country" onchange="renderElseWhere8('country', 'loghc')" required/> 
                        </tr>
                        
                        <tr>
                            <td>Select Image Type: 
                            <td><select type="text" class="inputtext" name="jobType" id="selectaJob" onchange="renderElseWhere6('selectaJob', 'loghc')" required>
                                    <option value="">SELECT DOCUMENT TYPE</option>
                                    <% if (!imageList.contains("PHOTO")) {%>
                                    <option value="PHOTO">PASSPORT PHOTOGRAPH</option>
                                    <% }
                                        if (!imageList.contains("FORM")) {%>
                                    <option value="FORM">APPLICATION FORM</option>
                                    <%}
                                        if (!imageList.contains("BIRTH")) {%>
                                    <option value="BIRTH">BIRTH CERTIFICATE</option>
                                    <%}
                                        if (!imageList.contains("STATE")) {%>
                                    <option value="STATE">STATE OF ORIGIN</option>
                                    <%}
                                        if (!imageList.contains("DATA")) {%>
                                    <option value="DATA">PASSPORT DATA PAGE</option>
                                    <%}%>

                                </select>
                        </tr>
                        <tr>  
                            <td><input type="file" class="submitlink" style="width: 200px;" name ="file0" required/>
                            <td><input type ="submit" class="submitlink" style="padding: 10px;" value="Upload image">
                        </tr>
                    </table>
                    <p id="loghc" style="height: 10px;"> </p>
                </form>


                <script>
                    function renderElseWhere(id, loc) {
                        var pNumber = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?passportNumber=' + pNumber + '&onset=yes";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere1(id, loc) {
                        var firstname = document.getElementById(id).value;
                       var print = '<a href="${pageContext.request.contextPath}/Initiator?surname=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere2(id, loc) {
                        var firstname = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?firstname=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere3(id, loc) {
                        var firstname = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?middlename=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere4(id, loc) {
                        var dob = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?dob=' + dob + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere5(id, loc) {
                        var firstname = document.getElementById(id).value;
                       var print = '<a href="${pageContext.request.contextPath}/Initiator?state=' + firstname + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>


                <script>
                    function renderElseWhere6(id, loc) {
                        var jobType = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?jobType=' + jobType + '&passportNumber=<%=passportNumber%>&imagecontrol=imageselect";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>

                <script>
                    function renderElseWhere7(id, loc) {
                        var sex = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?sex=' + sex + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>
               
                 <script>
                    function renderElseWhere8(id, loc) {
                        var country = document.getElementById(id).value;
                        var print = '<a href="${pageContext.request.contextPath}/Initiator?country=' + country + '&passportNumber=<%=passportNumber%>&control=one";">';
                        document.getElementById(loc).innerHTML = print
                    }
                </script>
                
      <script>      
  $(function() {
        $("#onrp_dob").datepicker({maxDate: "+0M +0D", changeMonth: true, dateFormat: "yy-mm-dd",
            changeYear: true, buttonImage: "/resources/images/icons/calendar.gif", buttonImageOnly: true});
    });
          </script>
                <%
                    String user = (String) session.getAttribute("username");
                    List<String> list = (List<String>) request.getAttribute("documents");
                    List<String> doc_ids = (List<String>) request.getAttribute("doc_ids");
                    if (list != null) {
                        if (list.size() > 0) {%>
                <p class="tabheader"> Uploaded Files</p>
                <table class="table">

                    <%for (int i = 0; i < list.size(); i++) {
                            String documents = list.get(i);
                            String doc_id = "";
                            if (doc_ids != null) {
                                doc_id = doc_ids.get(i);
                            }
                            //  String jobType = list.get(i)[0];
                            if (documents != null) {
                    %>

                    <tr>  
                        <td> <%= documents%></td>
                <!--    <td><img src="${pageContext.request.contextPath}/PhotoLoader2?document=<%= documents%>"  alt="" class="photo" align="top" border="0" style="width:100px;height:100px;"> 
                        <td><img src="${pageContext.request.contextPath}/PhotoLoaderFile?document=<%= documents%>"  alt="" class="photo" align="top" border="0" style="width:300px;height:300px;">  -->
                        <td><form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank"><input type ="hidden" name ="view"  value = "<%=doc_id%>" >
                                <input type ="submit" class="submitlink" style="padding: 10px;" value="View Document"></form><br/> 
                        <td>
                            <form action ="${pageContext.request.contextPath}/ImageUpload" >
                                <input type ="hidden" name ="delete"  value ="delete2">
                                <input type ="hidden" name ="jp"  value ="newJob">
                                <input type ="hidden" name ="document_type"  value ="<%=documents%>">
                                <input type ="submit" class="submitlink" style="padding: 10px;" value="Delete">
                            </form>
                        </td>
                    </tr>
                    <%}
                        }%>
                </table><br/>
                <form action ="${pageContext.request.contextPath}/ImageUpload" method="post">
                    <input type ="hidden" name ="done"  value ="yes">
                    <input type ="submit" class="submitlink"  style="padding: 10px;" value="Submit">
                </form>   

                <%}

                    }%>
            </div>
        </div>         

    </body>
</html>
