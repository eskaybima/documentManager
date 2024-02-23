function ajaxFunction() {
                var ajaxRequest;  // The variable that makes Ajax possible!

                try {
                    // Opera 8.0+, Firefox, Safari
                    ajaxRequest = new XMLHttpRequest();
                } catch (e) {
                    // Internet Explorer Browsers
                    try {
                        ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            // Something went wrong
                            alert("Your browser broke!");
                            return false;
                        }
                    }
                }
                // Create a function that will receive data sent from the server
                ajaxRequest.onreadystatechange = function() {
                    if (ajaxRequest.readyState == 4) {
                        if (ajaxRequest.status == 200) {
                            var ajaxDisplay = document.getElementById('ajaxDiv');
                            if (ajaxRequest.responseText.replace(/\s+/g, '') == "Exits") {
                              // Alert.render('The passport number you entered already exist on the system');
                              //  document.getElementById('passportNumberVGUVGUIS').value = "";       
                          }
                           //alert('This is  value of pass' +chkalfanum);
                           var inputtxt = document.getElementById('passportNumber').value;
                          // var letters =/[a-d][0-5]/;
                          var letters =/[a-zA-Z][0-9]/;
                             if(inputtxt.match(letters) == null) {
                               //  alert('The passport number you entered does not match standard passport number, you have entered' +inputtxt + 'Please correct it' );
                                 // Alert.render('The passport number you entered does not match standard passport number, you have entered' +inputtxt + 'Please correct it');
                                 // document.getElementById('passportNumber').value = "";
                             } 
                             
                       
                        }
                    }
                }
                var age = document.getElementById('passportNumber').value;
                var queryString = "?age=" + age;
                ajaxRequest.open("GET", "checkPassportNum" + queryString, true);
                ajaxRequest.setRequestHeader('Content-Type','plain/text;charset=UTF-8');
                ajaxRequest.send(null);
                
 function CustomAlert(){
	this.render = function(dialog){
		var winW = window.innerWidth;
	    var winH = window.innerHeight;
		var dialogoverlay = document.getElementById('dialogoverlay');
	    var dialogbox = document.getElementById('dialogbox');
		dialogoverlay.style.display = "block";
	    dialogoverlay.style.height = winH+"px";
		dialogbox.style.left = (winW/2) - (550 * .5)+"px";
	    dialogbox.style.top = "100px";
	    dialogbox.style.display = "block";
	   document.getElementById('dialogboxhead').innerHTML = "Acknowledge This Message";
	   document.getElementById('dialogboxbody').innerHTML = dialog;
           document.getElementById('dialogboxfoot').innerHTML = '<button  class="submitlink" onclick="ok();">OK</button>';
	}
	ok = function(){
		document.getElementById('dialogbox').style.display = "none";
		document.getElementById('dialogoverlay').style.display = "none";
	}
        

        
        
}
var Alert = new CustomAlert();


          
}
