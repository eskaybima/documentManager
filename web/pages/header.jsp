<%-- 
    Document   : header
    Created on : Sep 9, 2013, 11:18:19 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.fasyl.newjobBo.ValidateUser"%>
     <html>
    <head>       
               <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery_notification.css" />
                  <script src="${pageContext.request.contextPath}/resources/javaScript/componentFunction.js"></script>
                  <script src="${pageContext.request.contextPath}/resources/javaScript/jquery_notification_v.1.js"></script>
                      
    <body>
        

                <!-- START X-NAVIGATION VERTICAL -->
                <ul class="x-navigation x-navigation-horizontal x-navigation-panel">
                    <!-- TOGGLE NAVIGATION -->
                    <li class="xn-icon-button">
                        <a href="#" class="x-navigation-minimize"><span class="fa fa-dedent"></span></a>
                    </li>
                    <!-- END TOGGLE NAVIGATION -->
                    <li class="xn-text">
                        <a href="#"><span class="fa fa-briefcase"></span> Document Management System</a>
                    </li>
                    <li class="xn-text">
                        <a href="#"><span class="fa fa-user"></span> <%= session.getAttribute("welcomeName")%></a>
                    </li>
                    <!-- SIGN OUT -->
                    <li class="xn-text pull-right dropdown">
                        <a class="brand" id="dropdownMenu2" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><b class="fa fa-user"></b> PROFILE<span class="caret"></span>
			</a>
			<ul class="dropdown-menu" aria-labelledby="dropdownMenu2">
                            <li><a href="#"> Edit Profile</a></li>
                            <li><a href="#"> Change Password</a></li>
                            <li><a href="${pageContext.request.contextPath}/InvalidateUser"><span class="fa fa-power-off"></span> Sign Out</a></li>
			</ul>
                    </li> 
                    <!-- END SIGN OUT -->
                    <li class="xn-text pull-right">
                        <a href="#"><span class="fa fa-clock-o"></span> Last Login: <%= new java.util.Date()%></a>
                    </li>
                    <li class="xn-text pull-right">
                        <a href="#"><span class="fa fa-map-marker"></span> Location: <%= session.getAttribute("location")%></a>
                    </li>
                </ul>
                                
                <!-- END X-NAVIGATION VERTICAL --> 
             <%if (request.getAttribute("status") != null) {%>
                <%if (request.getAttribute("status").toString().trim().equalsIgnoreCase("success")) {%>
                <script type="text/javascript">
                    $(document).ready(function() {
                            successMessage('<%=request.getAttribute("status").toString().trim()%>', '<%=request.getAttribute("message").toString().trim()%>')
                    });
                </script>
                <%}
                    if (request.getAttribute("status").toString().trim().equalsIgnoreCase("error")) {%>
                <script>
                    errorMessage('<%=request.getAttribute("status").toString().trim()%>', '<%=request.getAttribute("message").toString().trim()%>')
                </script>

                <%}%>
                <%}%>
                
                <script type="text/javascript">
                    $(function() {
                        if (typeof window.event != 'undefined') {
                            document.onkeydown = function()
                            {
                                if (event.srcElement.tagName.toUpperCase() != 'INPUT' && event.srcElement.tagName.toUpperCase() != 'TEXTAREA') {
                                    return (event.keyCode != 8);
                                }

                            }
                        } else {
                            document.onkeypress = function(e)
                            {
                                if (e.target.nodeName.toUpperCase() != 'INPUT' && e.target.nodeName.toUpperCase() != 'TEXTAREA') {
                                    return (e.keyCode != 8);
                                }
                            }
                        }
                    });
                    // window.onbeforeunload = function() { return "You work will be lost."; };
                    //window.history.forward();
                    //function noBack() { window.history.forward(); }

                </script>
      </body>
     </html>