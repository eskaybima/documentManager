function checkFile(){
     var control = document.getElementById("filebayo");
     //  control.addEventListener("change", function(event) {

                                    // When the control has changed, there are new files

              var i = 0,
              files = control.files,
              len = files.length;
              var fileSize =  (files[i].size  / 1048576 );
               for (; i < len; i++) {
               //  alert("Filename: " + files[i].name);
                // alert("Type: " + files[i].type);
               //  Alert.render("Size: " + files[i].size + " bytes");
                 
                // Alert.render("Size: " + files[i].size + " bytes");
                // Alert.render("The Size in Megabytes: " + fileSize + "MB");
                 //console.log("Filename: " + files[i].name);
                // console.log("Type: " + files[i].type);
                // console.log("Size: " + files[i].size / 1048576  + " bytes");
 if(files[i].size > 31457280 ){ 
  alert("Uploaded file is :" +  files[i].size + "MB" + "bigger than allowed size of 30 MB")

 document.getElementById("filebayo").value = "";
    }
  };
             
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