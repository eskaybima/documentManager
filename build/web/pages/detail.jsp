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
                    String category = "";
                    String offset = null;
                    List<String> imageList;
                    List<String[]> values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                   String  cre_dated ;
                    SaveToDb sb = new SaveToDb();
                %>

<%if (session.getAttribute("banner") != null) {%>
        <script type="text/javascript">
            $(document).ready(function() {
                var elements = document.getElementsByClassName('pagebanner');
                var pageLinks = document.getElementsByClassName('pagelinks');
                var returnString;
                var links;
                var currentDisplay;
                var next = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=next" style="width:70px;"  >Get More</a>';
                var previous = '<a href="${pageContext.request.contextPath}/MultiSearcher?SearchType=previous" style="width:70px;" >Previous</a>';
                for (var i = 0; i < elements.length; i++) {
                    returnString = elements[i].innerHTML
                    currentDisplay = returnString.substring(returnString.indexOf("displaying"), returnString.length);
                    returnString = '<%=session.getAttribute("banner")%>';
            <%if (session.getAttribute("next") != null) {%>
                    returnString = returnString + ' ' + next;
            <%}%>
            <%if (session.getAttribute("previous") != null) {%>
                    returnString = returnString + ' ' + previous;
            <%}%>
                    elements[i].innerHTML = '<b>Overall : </b>' + ' ' + returnString;
                }
                for (var i = 0; i < pageLinks.length; i++) {
                    links = pageLinks[i].innerHTML
                    links = 'Currently ' + currentDisplay + links;
                    pageLinks[i].innerHTML = '<b>Current Display : </b>' + ' ' + links;
                }
            });
        </script>
        <%}%>
                

                <%
                    values = (List<String[]>) request.getAttribute("searchList");
                    imageList = (List<String>) request.getAttribute("documents");
                    for (int i = 0; i < values.size(); i++) {
                        passportNumber = values.get(i)[0];
                        surname = values.get(i)[1];
                        firstname = values.get(i)[2];
                        middlename = values.get(i)[3];
                        state = values.get(i)[4];
                        dob = values.get(i)[5];
                        sex = values.get(i)[6];
                        country = values.get(i)[7];
                        
                 cre_dated = sb.getValue2("select cre_date from fas_int_doc where passport_no = '" + passportNumber + "'");
                %>
           <table class="table">
                    <tr>
                        <td> Passport Number: 
                        <td><%=passportNumber%></td>
                    </tr>
                    <tr>
                        <td> Surname: 
                        <td><%=surname%></td>
                    </tr>
                    <tr>
                        <td> First Name: 
                        <td><%=firstname%></td>
                    </tr>
                    <tr>
                        <td> Middlename: 
                        <td><%=middlename%></td>
                    </tr>
                    <tr>
                        <td>Date of Birth: 
                        <td><%=dob%></td>
                    </tr>
                    <tr>
                        <td>State of Origin: 
                        <td><%=state%></td> 
                    </tr>
                    <tr>
                        <td>Sex: 
                        <td><%=sex%></td> 
                    </tr>
                    <tr>
                        <td>Country: 
                        <td><%=country%></td> 
                    </tr>
                    <tr>
                        <td>Creation Date: 
                        <td><%=cre_dated%></td> 
                    </tr>
                    
                    <tr>
                        <%
                            List<LoaderVo> l = sb.getLoaderList(values.get(i)[8]);
                            for (int k = 0; k < l.size(); k++) {
                                doc_type = l.get(k).getType();
                                doc_id = l.get(k).getDoc_id();
                        %>

                        <td><%= doc_type%></td>
                        <td><form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank"><input type ="hidden" name ="view"  value = "<%= doc_id%>" >
                                <input type ="submit" class="submitlink" style="padding: 10px;" value="View Document"></form><br/>
                    </tr>
                    <%}%>
                  </table>  </br></br>
                <%}%>   
                
                <p id="loghc" style="height: 10px;"> </p>
            </div>
        </div>         
    </body>
</html>
