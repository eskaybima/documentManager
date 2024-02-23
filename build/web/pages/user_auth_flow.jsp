
<%@page import="com.fasyl.newjobBo.SaveToDb"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE htmlz
    <html>


 <head>
        <title>Configure User Authorization Flow</title>
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


            <%!                String user_id;
                String result;
                String user;
            %>


            <%
                result = (String) request.getAttribute("result") == null ? "" : (String) request.getAttribute("result");
                user = request.getParameter("user");
                user_id = (String) session.getAttribute("user_id");
                List<String> authorizers = new SaveToDb().getList2("select auth_id from users where role_id  = 'authorizer' and not in (select auth_id from user_mandate where initiator = '" + user + "')");
            %>

            <br>
            <table>
                <tr>
                    <td>Authorisation Flow for User: <%= user%>
            </table>
            <br><br>


            <table>
                <tr>
                    <td>Add Authorizer
            </table>
            <table>

                <form action ="${pageContext.request.contextPath}/PDFLoader">

    
                    <tr>     <td>Operator
                        <td>                            
                            <select type="text" value=""  required>
                                <option value="" ></option>
                                <option value="AND">AND</option>
                                <option value="OR">OR</option>
                                <select/>


                                <tr>          
                                    <td>   Authorizer : 
                                        <select type="text" value="<%= authorizers%>"  required>
                                            <option value="" ></option>
                                            <%
                                                for (int i = 0; i < authorizers.size(); i++) {
                                            %>
                                            <option value="<%= authorizers.get(i)%>"><%=authorizers.get(i)%></option>
                                            <%}%>
                                            <select/>


                                              <input type ="submit" class="submitlink" style="padding: 10px;" value="Submit">

                                            </form>           
                                            </div>        
                                            </table>    

                                            <table>
                                                <tr>
                                                    
                                                    
                                                    <td><form action ="${pageContext.request.contextPath}/PDFLoader">
                                                    <input type ="submit" class="submitlink" style="padding: 10px;" value="View Existing Authorizers"></form><br/>
                                                            
                                                            <a/>
                                            </table>





                                            </body>
                                            </html>
