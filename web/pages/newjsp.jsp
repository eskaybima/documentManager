<div id="QuitOrMore" class="ui-dialog" title="QuitMore" style=" display:none;">  
    <div style="padding-left: 30px;">
        
            <tr> 
            <form action="${pageContext.request.contextPath}/ImageUpload">
                <input type ="hidden" name ="uploadType"  value ="scanner">
                    <td><input type ="submit" class="submitlink" style="padding: 10px;" value="MORE">
            </form>
          </tr>
            <form action ="${pageContext.request.contextPath}/pages/homepage.jsp">
                <tr> 
                    <td><input type ="submit" class="submitlink" style="padding: 10px;" value="QUIT">
                </tr>
                <p id="loghc" style="height: 10px;"> </p>
            </form>
        </table>
    </div> 
</div>            

                
           <form action="${pageContext.request.contextPath}/ImageUpload">
             <input type ="hidden" name ="uploadType"  value ="scanner">
           
                 <td><input type ="submit" class="submitlink" style="padding: 10px;" value="MORE">
            
            <input type="submit" value="search"/>
        </form>
            