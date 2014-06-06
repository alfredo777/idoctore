// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

 $(document).ready(function() {

	 $('.nav-doctor a').click(function (e){
	 	e.preventDefault();
	 	var target = $(this).data('target'),
	 		 offset = $('#' + target).offset(),
	 		 top = offset.top;
	 	//console.log(top);
	  $('html, body').animate({
	  	scrollTop: top - 50
	  })
	 });

 });

 function printDiv(divID, secret_string, user_id) {
 	     var url = "/users/"+user_id+"/diagnostics"
	     var divElements = $(divID).html();
	     document.body.innerHTML =  '<html><head><title>'+secret_string+"</title></head><body>" + divElements + "</body></html>";
  		 window.print();
	     window.location = url
 }

 function printTherapy(qr, treatments, user_id, general_d, user_name, user_token){
 	 	 var url = "/users/"+user_id+"/diagnostics"
         var qr_c =  $(qr).html();
         var general_d_c = $(general_d).html();
         var treatments_c =  $(treatments).html();
         var user_name_c = $(user_name).html();
         var user_token_c = $(user_token).html();
 	     var content =  general_d_c + treatments_c ;
 	     var privacidad = 'Queda prohibido replicar, clonar o intercambiar esta receta. Esta receta esta registrada electrónicamente por IDoctore.'
 	     document.body.innerHTML = '<html><head><title>IDoctore</title></head><body><div style="width:100%; height:100px; font-size:30px; ">Receta Médica</div>'+content+'<div style=" background-color: #BDBDBD !important; color:#ffffff !important; padding:10px !important; margin-top:150px; -webkit-print-color-adjust: exact;"><i>'+privacidad+'</i></div></body><footer style="background-color: #F3F3F3; padding-top: 10px; padding-bottom: 0px; position:fixed; bottom:0; width:100%;"><div style="width:80%; float:left;">'+ user_name_c+ '<p style="font-size:7px;">' + user_token_c + '</p></div>' + '<div style="float:left; width:20%;"><center>' + qr_c +'</center></div>'+'</footer></html>';
 	     window.print();
	     window.location = url;
 }

 function add_to_diagnostic(identifier_c , name){
 	     var id = identifier_c;
 	     var n = name;

 	     var paragraph = ' '+ 'CIE10:['+ id + ']-'+ n + ' / ' ;

 	     var finder = $('#diagnostic_or_clinical_problem').val();
 	     var loker = $('#diagnostic_or_clinical_problem').val( finder +  paragraph);

 }



 function clear_div(div_c){
 	 $("."+div_c).html('');
 }

 function fetchHTML(url){
  $( "#mresult" ).load( url );
 }

 function RemoveAccents(strAccents) {
		var strAccents = strAccents.split('');
		var strAccentsOut = new Array();
		var strAccentsLen = strAccents.length;
		var accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
		var accentsOut = "AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz";
		for (var y = 0; y < strAccentsLen; y++) {
			if (accents.indexOf(strAccents[y]) != -1) {
				strAccentsOut[y] = accentsOut.substr(accents.indexOf(strAccents[y]), 1);
			} else
				strAccentsOut[y] = strAccents[y];
		}
		strAccentsOut = strAccentsOut.join('');
		return strAccentsOut;
 }

$(document).ready(function(){
  $('.slide-p').click(function(){
     $('#close_page_slider').show();
  });
  $('#close_page_slider').click(function(){
     $('#close_page_slider').hide();
  });

	$( "#create_diagnostic" ).submit(function( event ) {
	   document.getElementById('pageslide').remove();
	   $(this).submit();
	});

});

function SelfSlider(id_s, id_in){
        $('#'+id_s).on('change', function() {
           $('input#'+id_in).val($(this).attr('data-slider'));
        });

        $('input#'+id_in).change(function() {
           $('#'+id_s).foundation('slider', 'set_value', $(this).val());
        });

           $('input#'+id_in).val(20);
           $('#'+id_s).foundation('slider', 'set_value', 20);

            $('#'+id_s).click(function(){
              $('#'+id_s).foundation('slider', 'set_value', 20);
            });
}  

function ValidateFormIn(id, validate_ids){
   
    $('#'+id).bind("keyup keypress", function(e) {
	  var code = e.keyCode || e.which; 
	  if (code  == 13) {               
	    e.preventDefault();
	    return false;
	  }
	});

   $("#"+id+" :input").each(function(){
    var input = $(this);
    var clases = $(input).attr('class');

    if(clases == 'required'){
    	 //console.log(clases);
         //console.log($(input).attr('id'));
         
         var value = $(input).val();
         if (value == null){

         }

    } 
   
   });

 }




//= require websocket_rails/main

