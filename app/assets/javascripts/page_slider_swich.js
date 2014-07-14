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