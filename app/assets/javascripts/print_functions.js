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
 	     document.body.innerHTML = '<html><head><title>IDoctore</title></head><body><div style="width:100%; height:100px; font-size:30px; ">Receta Médica</div>'+content+'<div style=" background-color: #BDBDBD !important; color:#ffffff !important; padding:10px !important; margin-top:150px; -webkit-print-color-adjust: exact;"><i>'+privacidad+'</i></div> </body><footer style="background-color: #F3F3F3; padding-top: 10px; padding-bottom: 0px; position:fixed; bottom:0; width:100%;"><div style="width:80%; float:left;">'+ user_name_c+ '<p style="font-size:7px;">' + user_token_c + '</p></div><div style="float:left; width:20%;"><center>' + qr_c +'</center></div></footer></html>';
 	     window.print();
	     window.location = url;
 }