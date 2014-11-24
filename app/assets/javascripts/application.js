//= require jquery
//= require jquery_ujs
//= require foundation
//= require highcharts
//= require highcharts/highcharts-more
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree .

$(function(){ $(document).foundation(); });

 $(document).ready(function() {
   

    getLocation();

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

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else { 
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
    $.get( '/static_views/create_location', { latitude: position.coords.latitude, longitude: position.coords.longitude }, function( data ) {
     var findToAccesString = ['Acapulco', 'Guerrero', 'Mexico', 'México', 'Federal District', 'Distrito Federal']
       $.each(data, function(i, item) {
        $.each(findToAccesString, function(i, wordtofind) {
         var str = item.data.formatted_address;
         var n = str.search(wordtofind);
           if(n > 0){
              alert('open prices');
              $('#cont_price').show();
              return false;
           } 
        });
      });

    });
}

 function add_to_diagnostic(identifier_c , name){
 	     var id = identifier_c;
 	     var n = name;

 	     var paragraph = ' '+ 'CIE10:['+ id + ']-'+ n + ' / ' ;

 	     var finder = $('#diagnostic_or_clinical_problem').val();
 	     var loker = $('#diagnostic_or_clinical_problem').val( finder +  paragraph);
       alert('Has agregado al campo de problema clínico:'+paragraph)
       clear_div('cie');
       $('#rescue_name').val('Ingrese la enfermedad...');

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

function readURL(input) {
   if (input.files && input.files[0]) {
       var reader = new FileReader();
       reader.onload = function(e) {
           $('#blah').attr('src', e.target.result);
       }

       reader.readAsDataURL(input.files[0]);
   }
}

