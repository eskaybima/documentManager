<%-- 
    Document   : errorpage
    Created on : Sep 30, 2013, 3:50:14 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error!</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
       
    </head>
    <body style='font-family: "Segoe WP", "Segoe UI Light", "Segoe UI", "Helvetica Neue", "Arial", sans-serif; background-color: #e0e0b0;'>
        <div style="float: left; padding-left: 35%; padding-top: 10%;">
            <h1>Something went wrong!!!!</h1>
           <br/>
      <br/> <br/><br/><br/><br/><p>An Error Occurred While trying to process your request, Please try again.</p>
      <p><li class="li"><a href="${pageContext.request.contextPath}/Login.jsp" class="a" style="text-decoration: none; color: white; background-color: #60601c; padding: 10px;">Immigration Archive Home</a></li><br/></p>
        </div>
    </body>
</html>
