//= require jquery
//= require jquery_ujs
//= require foundation
//= require highcharts
//= require highcharts/highcharts-more
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require cocoon
//= require_tree .

$(function(){ $(document).foundation(); });

 $(document).ready(function() {
   

    //getLocation();

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
   $('.long_list').click(function(){
    var ToxList = $(this).data('target');
    var Whheight = $( window ).height();
    $('.option_list').hide();
    $('.option_list').height(Whheight);
    $('#'+ToxList).show('slide');
   });

   $('.cancel-user').click(function(){
    $('.option_list').hide('slide');
   });

   $('.function-landing').click(function(){
    $('.function-landing').removeClass('select');
    $(this).addClass('select');
    var target = $(this).data('target');
    $('.class-h-functions').hide();
    $('#'+target).show();
   });

   $('.icon-section').click(function(){
    var target = $(this).data('target');
    $(this).hide();
    $('#'+target).show();
   });
   $('.section-read').click(function(){
    var target = $(this).data('target');
    $(this).hide();
    $('#'+target).show();
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
     var findToAccesString = ['Acapulco', 'Guerrero']
       $.each(data, function(i, item) {
        $.each(findToAccesString, function(i, wordtofind) {
         var str = item.data.formatted_address;
         var n = str.search(wordtofind);
           if(n > 0){
              $('#pricemsf').show();
              $('#cont_price').hide();
              $('#button_prices').hide();
              $('#register_link').hide();
              $('#prices_link_head').hide();
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

function changeTab(tab){
  
  // cambio de tab
  var actual_tab = $('.active').attr('id');
  $('#'+actual_tab).addClass('unactive');
  $('#'+actual_tab).removeClass('active');
  $('.arrow-down').remove();
  $('#'+tab).removeClass('unactive');
  $('#'+tab).addClass('active');
  $('#'+tab).append('<div class="arrow-down"></div>');

  // cambio de contenido
  var closeTab = 'to-' + actual_tab;
  var oppTab = 'to-' + tab;
  $('#'+closeTab).hide();
  $('#'+oppTab).show();

}
