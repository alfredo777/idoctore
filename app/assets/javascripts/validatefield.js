function VAlForValitx(id){
 var message = $('#'+id).data("message");
 var to_target = $('#'+id).data("target");
  $( "form" ).submit(function( event ) {
	if (!$.trim($('#'+id).val())){
 		$('#'+to_target).html(message);
 		$('#'+to_target).show();

	  	return false;
	}else{
		$('#'+to_target).hide();
	}
  });

}
