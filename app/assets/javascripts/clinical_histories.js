$(document).ready(function(){
  $('.uppart').click(function(){
    var target = $(this).data('target');
    if ($('#'+target).css('display') == 'none'){
      $('.uppart').html('<h6 style="color:#ffffff;">Abrir <i class="fa fa-chevron-down"></i></h6>');
      $(".body-ax").hide();
      $('#'+target).slideToggle('slow');
      $(this).html('<h6 style="color:#ffffff;">Cerrar <i class="fa fa-chevron-up"></i></h6>');

    }else{
      $('#'+target).slideToggle('slow');
      $(this).html('<h6 style="color:#ffffff;">Abrir <i class="fa fa-chevron-down"></i></h6>');
    }
  });

});
