(function() {
  var source;
  source = new EventSource('/messages/events');
  source.addEventListener('messages.create', function(e) {
     var m = $.parseJSON(e.data).message_act;
     var message = $.parseJSON(m);
     var u = $.parseJSON(e.data).user_x;
     var user = $.parseJSON(u);
     var avatar = user.avatar;

     if (avatar.url != null){
     		var avatar = '/uploads/user/avatar/'+user.id+ '/modern_avatar.jpg'
    	 }else{
     		var avatar = '/assets/users/avatar_chat.png'
     }
    
     var message_s = $('#new_messages_'+message.cite_doctor_id).size();
     
     if (message_s == 0){
     	 $('#chat_notice_'+message.to_user_id).show();
	     var identiter = 'notify_div_'+message.cite_doctor_id;
	     var notice_url = "/options_change_cite?ident_i="+message.cite_doctor_id+"&amp;type=messages";
	     var link_notice = '<div class="panel callout radius '+ identiter +' " id='+identiter+'><a data-remote="true" href='+ notice_url + '>Has recivido un nuevo mensaje --></a></div>';
	      $('#chat_notice_'+message.to_user_id).prepend(link_notice);
	     setTimeout(function(){
	     	     $('#chat_notice_'+message.to_user_id).hide();
	     }, 6000);

	     $('#'+identiter).click(function(){
	         $('.'+identiter).remove();
	     });
     }
  
     var message_ty =  '<div class="row"> <div class="left"><div class="left" style="margin-left:20px; width:55px;"><img alt="Modern avatar" class="th" src='+avatar+' ><div style="font-size:6px;">'+user.name+'</div></div> <div class="left" style="margin-left:14px; min-width:220px; max-width:340px; text-align:justify;"><div class="lef">' +message.message + '</div></div></div></div><hr>';
     var new_messsge = $('#new_messages_'+message.cite_doctor_id).prepend(message_ty);
  });

}).call(this);
