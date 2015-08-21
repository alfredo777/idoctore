$(document).ready(function(){
  $('.single-tooth').click(function(){
    var target = $(this).data('target');
    $('.tooth-options').hide();
    $('#'+target).toggle('fast');
  });
   $('.closer-t').click(function(){
    var target = $(this).data('target');
    $('#'+target).toggle('fast');
  });

  $('.top-part').click(function(){
      if( $(this).attr('style') == null) {
        $(this).css("border-top", "50px solid #FACC2E");

      }else{
        $(this).attr('style', null);
      }
  });

  $('.left-part').click(function(){
      if( $(this).attr('style') == null) {
        $(this).css("border-left", "50px solid #FACC2E");

      }else{
        $(this).attr('style', null);
      }
  });

  $('.right-part').click(function(){
      if( $(this).attr('style') == null) {
        $(this).css("border-right", "50px solid #FACC2E");

      }else{
        $(this).attr('style', null);
      }
  });

  $('.bottom-part').click(function(){
      if( $(this).attr('style') == null) {
        $(this).css("border-bottom", "50px solid #FACC2E");

      }else{
        $(this).attr('style', null);
      }
  });

  $('.center-part').click(function(){
      if( $(this).attr('style') == null) {
        $(this).css("background", "#FACC2E");

      }else{
        $(this).attr('style', null);
      }
  });

});
