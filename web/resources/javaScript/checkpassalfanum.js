function alphanumeric(inputtxt)  
{   

var letters =/[a-dA-D][0-5]/;
if(inputtxt.value.match(letters))  
{  
alert('Your passport  number have been accepted : you can try another');  
//document.getElementById("wpm").value = "";
return true;  
}  
else  
{  
//var enteredVal = document.scanForm.passportNumber.value ;    
//alert('Please input alphanumeric characters only , you have entered'    + enteredVal +'This is not correct for a passport number' );
 //Alert.render('Please input alphanumeric characters only , you have entered'    + enteredVal +'This is not correct for a passport number');
//document.scanForm.passportNumber.value="";
return false;  
}  

           
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