<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Upload New Job</title>
               <script>
                    function clickButton()
                      {
                      document.getElementById('button1').click()
                      }
                      function alertMsg()
                      {
                      displayDialog('QuitOrMore')
                      }
                </script>
        <jsp:include page="pagesimport.jsp"></jsp:include>
        </head>
        <body onload="renderElseWhere()">
          <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
            <div class="page-content">
            <jsp:include page="header.jsp"></jsp:include>
            <!-- START BREADCRUMB -->
            <ul class="breadcrumb">
                <li><a href="${pageContext.request.contextPath}/pages/homepage.jsp">Home</a></li>
                <li><a href="#">Upload Operations</a></li>
                <li class="active">Scan New Jobs</li>
            </ul>
            <!-- END BREADCRUMB -->
            <div id="bodyhold">
                <div id="bodycon">  

                    <form>
                        <input type="button" id="button1" onclick="alertMsg()" value="Button 1">
                    </form>
                    <!--       <table class="table">
                        <form action ="${pageContext.request.contextPath}/ImageUpload">

                        <input type ="hidden" name ="uploadType"  value ="scanner">
                        <tr> 
                            <td><input type ="submit" class="submitlink" style="padding: 10px;" value="MORE">
                        </tr>

                        <p id="loghc" style="height: 10px;"> </p>
                    </form>

                    <form action ="${pageContext.request.contextPath}/pages/homepage.jsp">

                        <tr> 
                            <td><input type ="submit" class="submitlink" style="padding: 10px;" value="QUIT">
                        </tr>

                        <p id="loghc" style="height: 10px;"> </p>
                    </form>
                </table>   -->
              </div>
          </div>   
       </div>
     </div>
  
     <script>
    function renderElseWhere() {
        document.getElementById("button1").click();
    }
    </script>
                    
    </body>
</html>
