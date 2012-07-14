// This contains all base javascript (e.g. siFR, swfobject calls, etc)

//  base.js
//  
//  Created by Matt Dills on 2011-02-24.
//  Copyright 2010 Scully Group. All rights reserved.
// 

$(document).ready(function() {
  
  //preload the background images
  $.preLoadImages(
    "/images/titles/atv.png",
    "/images/titles/bike.png",
    "/images/titles/hiking.png",
    "/images/titles/kayak.png",
    "/images/titles/surfing.png",
    "/images/titles/ride.png",
    "/images/bike-background.jpg",
    "/images/bike-background.jpg",
    "/images/atv-background.jpg",
    "/images/kayak-background.jpg",
    "/images/stream-background.jpg",
    "/images/surfing-background.jpg",
    "/images/diy-background.jpg",
    "/images/road-bike.jpg"
  );
  
  // /////////////////////////////////////////////////////////////// cufon
  // 
  // Ank Font
  // Cufon.replace('.nav ul li a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('h1', {hover:true, fontFamily: 'ank'});
  Cufon.replace('h2', {hover:true, fontFamily: 'ank'});
  Cufon.replace('h4', {hover:true, fontFamily: 'ank'});
  // Cufon.replace('#ticker #ticker-content a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('#footer-left ul.footer-nav li a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('#interior-left ul li a', {color: '-linear-gradient(#010101, #010101)', hover:{color: '-linear-gradient(white, white)'}, fontFamily: 'ank'});
  Cufon.replace('#footer-content p.stay', {hover:true, fontFamily: 'ank'});
  
  
  //////////////////////////////////////////////////////////////// add dividers to navigation elements
  $('#footer-left ul.footer-nav li:not(:first)').before('<li><img src="/images/footer-nav-divider.png" /></li>');
  $('#footer-left ul.footer-subnav1 li:not(:first)').before('<li>:</li>');
  $('#footer-left ul.footer-subnav2 li:not(:first)').before('<li>:</li>');

  
  //////////////////////////////////////////////////////////////// dropdowns
  $('.nav ul li').each(function() {
    $(this).hover(function() {
      $(this).addClass('nav-on');
    }, function() {
      $(this).removeClass('nav-on');
    });
  });
  
  
  ////////////////////////////////////////////////////////////// rounded corners on subnav
  $('#interior-left ul li').each(function() {
    $(this).hover(function() {
      $(this).addClass('nav-on');
    }, function() {
      $(this).removeClass('nav-on');
    });
  });
  
  $('#interior-left ul li').append('<span></span>');
  
  $('img.mediaLeft').each(function() {
    $(this).parent().addClass('media');
  });
  
  //////////////////////////////////////////////////////////////// home page scrollbox
   
  //arrow click events
  $("#previous a").click(function(){
    scrollRight(false);
    return false;
  });
  $("#next a").click(function(){
    scrollLeft(false);
    return false;
  });

   //create variable for the logo scroller
 	var features = $("#content-slider");
 	var animating = false;
 	var scrollTime = 1200;
 	var backgrounds = ["surfing", "hiking", "atv", "bike", "kayak"];
  
 	$(".switch a").click(function(){
 	  if($("#content-slider ul").length){ 	    
 	    scrollLeft(false, true);
 	  }else{
 	    var index = $.inArray($("body").attr("class"), backgrounds);
 	    if(!$("body").attr("class")){
 	      index = 0;
 	    }
 	    if(index != -1){
 	      index++;
 	      if(index == backgrounds.length){
 	        index = 0;
 	      }
 	      
 	      //set the next index
 	      $("body").attr("class", backgrounds[index]);
 	      
 	      //set the session setting
 	      setSessionClass(backgrounds[index]);
 	    }
 	  }
 	  return false;
 	});
  
  if($('#content-slider ul li').length < 4){
    $('#content-slider ul li').each(function(index){
      var clone = $(this).clone();
      $('#content-slider ul').append(clone);
    });
  }

  //iterate through li's
  $('#content-slider ul li').each(function(index){
    if(index != 1){
      $(this).fadeTo(0, 0.5);
    }
  });
  
  // function to show the information box for each item
  function addClick(){
    $('.crosshairs').click(function(){
      $(this).parent().find('.info').fadeIn(300);
      return false;
    });
  
    $('.close').click(function(){
      $(this).parent().fadeOut(300);
      return false;
    });
    
    //cufon replace
    Cufon.replace('h2', {hover:true, fontFamily: 'ank'});
  }
  
  function setBodyClass(title){
    $("body").attr("class", title);
    $("#headline-right img").attr("src", "/images/titles/" + title + ".png");
  }
  
  function setSessionClass(title){
    $.ajax( "/session-setting/update/" + title );
  }
  
   //function to scroll logos left
 	function scrollLeft(clear, setting){
 		//stop the timer
 		if(!clear){
 			features.stopTime("slider");
 		}
    
 		if(!animating){
 			animating = true;
 			
 			// hide any showing info boxes
      $('.info').fadeOut(300);
      var first = $("#content-slider ul li:first");
      
      // code for the selected item
      var current = $('#content-slider ul li:nth-child(3)');
      var last = $('#content-slider ul li:nth-child(2)');
      
      current.fadeTo(250, 1);
      last.fadeTo(250, 0.5);
      $(".crosshairs").hide();
      
      if(setting){
        setSessionClass(current.attr("class"));
      }
      
 			$("#content-slider ul").animate({"marginLeft":"-" + first.width() + "px"}, scrollTime, function(){
        var clone = $("#content-slider ul li:first").clone();
 				$("#content-slider ul li:first").remove();

 				//set the margin left
 				$("#content-slider ul").css("marginLeft", "0px");

 				//append the cloned element to the end
 				$("#content-slider ul").append(clone);		
        
        //show the crosshairs
        current.find(".crosshairs").fadeIn(150);
        
 				//set the animating to false
 				animating = false;
 				
 				//set the body class
 				setBodyClass(current.attr("class"));
 				
 				//re-add the click events
 				addClick();
 			});
 		}
 	}

 	function scrollRight(clear){
 		//stop the timer
 		if(!clear){
 			features.stopTime("slider");
 		}
    
 		if(!animating){
 			animating = true;
 			
 			// hide any showing info boxes
      $('.info').fadeOut(300);
 			
 			// code for the selected item
      var current = $('#content-slider ul li:nth-child(1)');
      var last = $('#content-slider ul li:nth-child(2)');

      current.fadeTo(250, 1);
      last.fadeTo(250, 0.5);
      $(".crosshairs").hide();
 			
      var clone = $("#content-slider ul li:last").clone();
 			$("#content-slider ul li:last").remove();

       //append the cloned element to the end
 			$("#content-slider ul").prepend(clone);
      $("#content-slider ul").css("marginLeft", "-" + clone.width() + "px");
 			$("#content-slider ul").animate({"marginLeft":"0px"}, scrollTime, function(){
 			  current.find(".crosshairs").fadeIn(150);
 				animating = false;
 				
 				//re-add the click events
 				addClick();
 				
 				//add the bg class
 				setBodyClass(current.attr("class"));
 			});
 		}
 	}
 	
 	//initially add clicks
 	addClick();
 	
 	//////////////////////////////////////////////////////////////// clear stay informed input box in footer
 	
 	var focused = false;
  
  $("#footer-left input").focus(function(){
    if(!focused){
      $(this).val("");
      focused = true;
    }
  });
 	
  //////////////////////////////////////////////////////////////// footer tabs
  $(function() {
		$('#footer-tabs').tabs();
	});
  
  //////////////////////////////////////////////////////////////// fancybox
  $(".flickr-gallery a").fancybox({
  		'transitionIn'	:	'elastic',
  		'transitionOut'	:	'elastic',
  		'overlayOpacity': 0.5,
  		'overlayColor' : '#000',
  		'speedIn'		:	600, 
  		'speedOut'		:	200, 
  		'titleShow' : true,
  		'titlePosition' : 'inside',
  		'overlayShow'	:	true
  });
  
  $("#vimeo-tab a.vimeo").fancybox({
  		'transitionIn'	:	'elastic',
  		'transitionOut'	:	'elastic',
  		'overlayOpacity': 0.5,
  		'overlayColor' : '#000',
  		'speedIn'		:	600, 
  		'speedOut'		:	200, 
  		'titleShow' : true,
  		'titlePosition' : 'inside',
  		'overlayShow'	:	true
  });
  
  $(".vimeo").click(function() {
		$.fancybox({
			'padding'		: 0,
			'autoScale'		: false,
			'transitionIn'	: 'none',
			'transitionOut'	: 'none',
			'overlayOpacity': 0.5,
  		'overlayColor' : '#000',
			'title'			: this.title,
			'width'			: 640,
			'height'		: 360,
			'href'			: this.href.replace(new RegExp("([0-9])","i"),'moogaloop.swf?clip_id=$1'),
			'type'			: 'swf'
		});

		return false;
	});
  
  $(".youtube").click(function() {
  	$.fancybox({
  			'padding'		: 0,
  			'autoScale'		: false,
  			'transitionIn'	: 'none',
  			'transitionOut'	: 'none',
  			'overlayOpacity': 0.5,
    		'overlayColor' : '#000',
  			'title'			: this.title,
  			'width'		: 680,
  			'height'		: 495,
  			'href'			: this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
  			'type'			: 'swf',
  			'swf'			: {
  			   	 'wmode'		: 'transparent',
  				'allowfullscreen'	: 'true'
  			}
  		});

  	return false;
  });
  
  // function scrollInterval(){
  //   timer = setTimeout(function() {
  //       scrollTicker();
  //   }, 4000);
  // }
  
  // function onTickers(data){
  //   if(data.length == 0){
  //     $("#ticker").hide();
  //   }else{
  //     //alert("loaded ticker");
  //     $("#ticker-content").empty();
  //     $("#ticker-content").append('<div id="ticker-scroller"></div>');
  //   
  //     var totalWidth = 0;
  //     $.each(data, function(key, value){
  //       $("#ticker-scroller").append('<a href="' + value.url + '">' + value.title + "</a>");
  //       totalWidth += $("#ticker-scroller a:last").outerWidth();
  //     });
  //   
  //     while(totalWidth < $("#ticker-content").width() + $("#ticker-scroller a:first").outerWidth()){//if we're not covering the total distance scrolling keep duplicating
  //       $("#ticker-scroller a").each(function(index){
  //         totalWidth += $(this).outerWidth(); //keep track of the current width
  //       });
  //       $("#ticker-scroller").append($("#ticker-scroller").html()); //duplicate itself so all the entries are in order
  //     }
  //   
  //     //after all that we set the scroll interval
  //     scrollInterval();
  //   }
  // }
  // 
  // function scrollTicker(){
  //   var first = $("#ticker-scroller a:first");
  //   var clone = $("#ticker-scroller a:first").clone();
  //   $("#ticker-scroller").animate({marginLeft: - first.outerWidth() + "px"}, 2000, "easeInOutQuad", function(){
  //     $("#ticker-scroller a:first").remove();
  //     $("#ticker-scroller").append(clone);
  //     $("#ticker-scroller").css("margin-left", 0); //reset the margin
  //   });
  //   
  //   scrollInterval();
  // }
  // 
  // //call the json load
  // $.getJSON('/tickers/json', onTickers);
  
}); //end document.ready