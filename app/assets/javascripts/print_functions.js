 function printDiv(divID, secret_string, user_id) {
 	     var url = "/users/"+user_id+"/diagnostics"
	     var divElements = $(divID).html();
	     document.body.innerHTML =  '<html><head><title>'+secret_string+"</title></head><body>" + divElements + "</body></html>";
  		 window.print();
	     window.location = url
 }

 function printTherapy(user_id){
         var url = "/users/"+user_id+"/diagnostics";
         var content = $('#print_x').html();
 	     document.body.innerHTML = content;
         window.print();
	     window.location = url;
 }

$(document).ready(function(){
$('#print_clinical_history').click(function(){
   var url =  window.location.href;
   var content = $('#clinical-history').html();
   document.body.innerHTML = content;
   window.print();
   window.location = url;
 });
});
