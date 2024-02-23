<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
<%@page import="com.fasyl.vo.LoaderVo"%>
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">

<html>
    <head>
        <title>Details</title>
        <%
            int timeout = session.getMaxInactiveInterval();
            response.setHeader("Refresh", timeout + "; URL =" + request.getContextPath() + "/Login.jsp");
        %>
        <jsp:include page="/pages/pagesimport.jsp"></jsp:include>
            <script>
                $(function() {
                    $("#accord").accordion();
                });
            </script>
        </head>
        <body id="background">
        <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
            <div class="page-content">
            <jsp:include page="header.jsp"></jsp:include>

            <div id="bodyhold">
                <div id="bodycon">  
  <%!
  List<String[]> data = null;
  %>
                    
     <%
      data = (List<String[]>)request.getAttribute("data");
     %>          
  
     
     <form action="${pageContext.request.contextPath}/Statistic" method="get">
         
                    <input type="hidden" name="repType" value="rangeReport"/>
                    <table>
                        <tr>
                            <td><input class="inputtext" type="hidden" name="start_date" value ="<%= (String)request.getAttribute("start_date")%>"/>
                                <input class="inputtext" type="hidden" name="end_date" value ="<%= (String)request.getAttribute("end_date")%>"/>
                                <input type="submit" class="submitlink" value="Download" style="padding: 5px;">
                            </td>
                        </tr>
                    </table> <br/>
                </form>
     
     <p class="tabheader"><label >Range Report Between :</label><label style="color: #ffffff;" for="date"><%= (String)request.getAttribute("start_date")%></label><label> and </label><label style="color: #ffffff;" for="date"><%= (String)request.getAttribute("end_date")%></label></td>
                 <table class="table">
                     <tr>
                     <td> Location  
                     <td> Total      
                     </tr>   
                   
                    <% for(int i = 0; i < data.size(); i++) { %>
                     <tr>
                    <td> <%=data.get(i)[0]%>
                    <td> <%=data.get(i)[1]%>    
                    </tr>
                    <%}%>
                    
                  </table> </br> 
                <p id="loghc" style="height: 10px;"> </p>
            </div>
        </div>  
      </div>
     </div>               
    </body>
</html>
