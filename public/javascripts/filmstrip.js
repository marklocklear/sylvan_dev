$(document).ready(function() {
  // put all your jQuery goodness in here.
	var filmstrip = $("#filmstrip-holder");
	var animating = false;
	
	//create the automatic animation
	function startTimer(){
  	filmstrip.everyTime(6000, "slider", function() {
  		scrollLeft(true);
  	});
  }
	
	function scrollLeft(looping){
		//stop the timer
		if(looping === true){
      //nothing
		}else{
		  filmstrip.stopTime("slider");
			$("#fs-pause").addClass("play");
		}
		
		if(!animating){
			animating = true;
		  
		  $("#filmstrip-controls p").fadeOut(600, function(){
		    var newtext = $("#filmstrip-images li:eq(1) span").text();
		    
		    $(this).text(newtext);
		    
		    $(this).fadeIn(600);
		  });
		  
		  var first = $("#filmstrip-images li:first");
		  
			$("#filmstrip-images").animate({"marginLeft":"-" + first.width() + "px"}, 3000, function(){
				//clone the element so we can add it to the end
        var clone = $("#filmstrip-images li:first").clone();
			
				//remove the element
				$("#filmstrip-images li:first").remove();
			
				//set the margin left
				$("#filmstrip-images").css("marginLeft", "0px");

				//append the cloned element to the end
				$("#filmstrip-images").append(clone);
			  
				//set the animating to false
				animating = false;
			});
		}
		
		return false;
	}
	
	function scrollRight(){
		//stop the timer
		filmstrip.stopTime("slider");
		$("#fs-pause").addClass("play");
		
		if(!animating){
			animating = true;
		  
		  $("#filmstrip-controls p").fadeOut(600, function(){
		    var newtext = $("#filmstrip-images li:eq(" + ($("#filmstrip-images").size() - 1) + ") span").text();
		    
		    $(this).text(newtext);
		    
		    $(this).fadeIn(600);
		  });
		  
			//set the margin left to the negative value
			$("#filmstrip-images").css("marginLeft", "-" + filmstrip.width() + "px");
		
			//clone the last in the dive
			var clone = $("#filmstrip-images li:last").clone();
		
			//remove the element
			$("#filmstrip-images li:last").remove();

			//prepend the cloned element to the begining so it looks right
			$("#filmstrip-images").prepend(clone);
		
			//animate it back to 0p
			$("#filmstrip-images").animate({"marginLeft":"0px"}, 1200, function(){
				//set the animating to false
				animating = false;
				
				//replace cufon
			});
		}
		
		return false;
	}
	
	function scrollPause(){
	  if ($(this).hasClass("play")){
	    startTimer();
	    
	    //do a scroll on play out of good faith
	    scrollLeft(true);
	    
	    //remove the play class
	    $("#fs-pause").removeClass("play");
	  }else{
	    filmstrip.stopTime("slider");
  	  
  	  //remove the play class
	    $("#fs-pause").addClass("play");
	  }
	  
	  return false;
	}
	
	
	$("#fs-forward").click(scrollLeft);
	$("#fs-back").click(scrollRight);
	$("#fs-pause").click(scrollPause);
	
	startTimer();
});