<%-- 
   Document   : detail
   Created on : Sep 17, 2013, 10:51:03 AM
   Author     : admin
--%>
<%@page import="com.fasyl.newjobBo.PageUtil"%>
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
        <title>Authorize Update</title>
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
        < <div class="page-container">
            <jsp:include page="leftMenu.jsp"></jsp:include>
            <div class="page-content">
            <jsp:include page="header.jsp"></jsp:include>

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
                    String applicationId;
                    List<String> imageList;  
                    List<String> imageUpdate;
                    String[] values;
                    String doc_type;
                    String doc_path;
                    String doc_id;
                    LoaderVo lv;
                    String mar_status;
                    public SaveToDb sb = new SaveToDb();
                    boolean isdocAvailable;
                %>



                <%
                    values = (String[]) request.getAttribute("values");
                    applicationId = values[9];
                    lv = (LoaderVo) request.getAttribute("valueHolder");
                    imageUpdate =  (List<String>)request.getAttribute("imageUpdate");
                    passportNumber = values[0];
                    surname = values[1];
                    firstname = values[2];
                    middlename = values[3];
                    state = values[4];
                    dob = values[5];
                    sex = values[6];
                    country = values[7];
                    mar_status = values[13];
                    
                %>
                 <p class="tabheader"> Authorize Updates for <%=applicationId%></p>
                <table class="table">
                    <tr>
                        <td> <label style="color:orangered" for="Item">Item</label>
                        <td> <label style="color:orangered" for="Old Value">Old Value</label>
                        <td> <label style="color:orangered" for="New Value">New Value</label>
                    </tr>
                    
                        </tr>
                        <% if (!(lv.getPassNo().equalsIgnoreCase("null")) & !lv.getPassNo().equalsIgnoreCase(passportNumber)) {%>
                        <tr>
                            <td> Passport Number: 
                            <td><%=passportNumber%></td>
                            <td><%=lv.getPassNo()%>
                        </tr>
                        <% }  if (!(lv.getSurname().equalsIgnoreCase("null")) & !lv.getSurname().equalsIgnoreCase(surname)) {%>
                        <tr>
                            <td> Surname: 
                            <td><%=surname%></td>
                            <td><%=lv.getSurname()%>
                        </tr>
                         <% }  if (!(lv.getFirstname().equalsIgnoreCase("null")) & !lv.getFirstname().equalsIgnoreCase(firstname)) {%>
                        <tr>
                            <td> First Name: 
                            <td><%=firstname%></td>
                            <td><%=lv.getFirstname()%>
                        </tr>
                        <% }  if (!(lv.getMiddlename().equalsIgnoreCase("null")) & !lv.getMiddlename().equalsIgnoreCase(middlename)) {%>
                        <tr>
                            <td> Middlename: 
                            <td><%=middlename%></td>
                            <td><%=lv.getMiddlename()%>
                        </tr>
                         <% }  if (!(lv.getDob().equalsIgnoreCase("null")) & !lv.getDob().equalsIgnoreCase(dob)) {%>
                        <tr>
                            <td>Date of Birth: 
                            <td><%=dob%></td>
                            <td><%=lv.getDob()%>
                        </tr>
                        <% }  if (!(lv.getState().equalsIgnoreCase("null")) & !lv.getState().equalsIgnoreCase(state)) {%>
                        <tr>
                            <td>State of Origin: 
                            <td><%=state%></td> 
                            <td><%=lv.getState()%>
                        </tr>
                        
                        <% }  if (!(lv.getSex().equalsIgnoreCase("null")) & !lv.getSex().equalsIgnoreCase(sex)) {%>
                        <tr>
                            <td>Sex: 
                            <td><%=sex%></td> 
                            <td><%=lv.getSex()%>
                       </tr
                       <% }  if (!(lv.getCountry().equalsIgnoreCase("null")) & !lv.getCountry().equalsIgnoreCase(country)) {%>
                        <tr>
                            <td>Country: 
                            <td><%=country%></td> 
                            <td><%=lv.getCountry()%>
                        </tr>
                        <% } if (!(lv.getMarital_status().equalsIgnoreCase("null")) & !lv.getMarital_status().equalsIgnoreCase(mar_status)) {%>
                        <tr>
                            <td>Marital Status: 
                            <td><%=mar_status%> 
                            <td><%=lv.getMarital_status()%>
                        </tr>
                        <% } %>
                       <br/> 
                        <p id="loghc" style="height: 10px;"> </p>
                </form>
                    </table>   
                    <p class="tabheader">New Documents</p>
                   
                 <table class="table">
                        <tr>
                        <%
                            List<LoaderVo> l = sb.getImageUpdateList(applicationId);
                            for (int k = 0; k < l.size(); k++) {
                                doc_type = l.get(k).getType();
                                doc_id = l.get(k).getDoc_id();
                                isdocAvailable = PageUtil.isDocAvailable(doc_id);
                        %>
             
                        <td><%= doc_type%></td>
                        <td>
                            <% if (isdocAvailable) { %>
                            <form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank"><input type ="hidden" name ="view"  value = "<%=doc_id%>" >
                                <input type ="submit" class="submitlink" style="padding: 10px;" value="View"></form><br/> 
                                <%} else {%>
                                <label style="color: #ffffff;" for="NotAvailable">Not Available</label>
                                <%}%>
                      <!--
                            <form action ="${pageContext.request.contextPath}/PDFLoader" target="_blank">
                                <input type ="hidden" name ="view"  value = "<%= doc_id%>" >
                                <input type ="hidden" name ="type"  value = "update" >
                             <td><input type ="submit" class="submitlink" style="padding: 10px;" value="New Document">
                            </form><br/>
                      -->
                    </tr>
                <%}%>
                  </table><br/>
                 
                        <form action ="${pageContext.request.contextPath}/Authorize">
                            <input type ="hidden" name ="transactionNumber"  value = "<%= lv.getTrans_no()%>" >
                            <td><select type="text" class="inputtext" name="authorizeUpdate" required>
                                    <option value="">Select</option>
                                    <option value="authorize">Authorize</option>
                                    <option value="decline">Decline</option>
                                </select>
                            <td><input type ="submit" class="submitlink" style="padding: 10px;" value="submit">
                        </form> 
               
                </div>
            </div>    
          </div>
        </div>                   
    </body>
</html>



