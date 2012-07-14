// This contains all base javascript (e.g. siFR, swfobject calls, etc)

//  base.js
//  
//  Created by Matt Dills on 2011-02-24.
//  Copyright 2010 Scully Group. All rights reserved.
// 

$(document).ready(function() {
  
  // /////////////////////////////////////////////////////////////// cufon
  // 
  // Ank Font
  // Cufon.replace('.nav ul li a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('h1', {hover:true, fontFamily: 'ank'});
  Cufon.replace('h2', {hover:true, fontFamily: 'ank'});
  Cufon.replace('#footer-left ul.footer-nav li a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('#interior-content ul li a', {hover:true, fontFamily: 'ank'});
  Cufon.replace('#footer-content p.stay', {hover:true, fontFamily: 'ank'});
  
  
  //////////////////////////////////////////////////////////////// add dividers to navigation elements
  $('#footer-left ul.footer-nav li:not(:first)').before('<li><img src="images/footer-nav-divider.png" /></li>');
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
 	var scrollWidth = "360";
 	
  // css variables for scroller ... controls transparency
 	var trans = {
    'filter' : 'alpha(opacity=50)',
    '-moz-opacity' : '0.5',
    '-khtml-opacity' : '0.5',
    'opacity': '0.5'
	}
	
	var opaque = {
    'filter' : 'alpha(opacity=100)',
    '-moz-opacity' : '1',
    '-khtml-opacity' : '1',
    'opacity': '1'
	}

  // function to show the information box for each item
  function showInfo(){
    $('#content-slider ul li a.crosshairs').click(function(){
      jQuery(this).parent().find('.info').show();
      return false;
    });
    
    $('#content-slider ul li .close').click(function(){
      jQuery(this).parent().hide();
      return false;
    });
  }
  showInfo();
  
  $('#content-slider ul li:nth-child(2) img').css(opaque);
  $('#content-slider ul li:nth-child(2) .crosshairs').show();

   //function to scroll logos left
 	function scrollLeft(clear){
    // hide any showing info boxes
    $('.info').hide();
 		//stop the timer
 		if(!clear){
 			features.stopTime("slider");
 		}

 		if(!animating){
 			animating = true;	

 			$("#content-slider ul").animate({"marginLeft":"-" + scrollWidth + "px"}, 360, function(){
         var clone = $("#content-slider ul li:first").clone();
 				$("#content-slider ul li:first").remove();

 				//set the margin left
 				$("#content-slider ul").css("marginLeft", "0px");

 				//append the cloned element to the end
 				$("#content-slider ul").append(clone);			

 				//set the animating to false
 				animating = false;
 			});
 		}

    $('#content-slider ul li:nth-child(2) img').css(trans);
    $('#content-slider ul li:nth-child(2) .crosshairs').hide();
    $('#content-slider ul li:nth-child(3) img').css(opaque);
    $('#content-slider ul li:nth-child(3) .crosshairs').show();
    
    showInfo();
    // $('#content-slider ul li').click(function(){
    //   jQuery(this).find('.info').show();
    //   return false;
    // });
    // 
    // $('#content-slider ul li .close').click(function(){
    //   jQuery(this).parent().hide();
    //   return false;
    // });
 	}

 	function scrollRight(clear){
 	  // hide any showing info boxes
    $('.info').hide();
 		//stop the timer
 		if(!clear){
 			features.stopTime("slider");
 		}

 		if(!animating){
 			animating = true;
 			
      var clone = $("#content-slider ul li:last").clone();
 			$("#content-slider ul li:last").remove();

       //append the cloned element to the end
 			$("#content-slider ul").prepend(clone);
 			
      $("#content-slider ul").css("marginLeft", "-" + scrollWidth + "px");
 			
 			$("#content-slider ul").animate({"marginLeft":"0px"}, 360, function(){
 				animating = false;
 			});		

 		}

    $('#content-slider ul li:nth-child(3) img').css(trans);
    $('#content-slider ul li:nth-child(3) .crosshairs').hide();
    $('#content-slider ul li:nth-child(2) img').css(opaque);
    $('#content-slider ul li:nth-child(2) .crosshairs').show();
    showInfo();
    
 	}
 	
  //////////////////////////////////////////////////////////////// footer tabs
  $(function() {
		$('#footer-tabs').tabs();
	});
	
 	

  
}); //end document.ready