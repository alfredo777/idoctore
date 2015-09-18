
$(document).ready(function(){
  var offset = $('#container-img').offset();
  $( '#container-img' ).click( "mousemove", function( event ) {
    if($(this).hasClass('acupunture')){
      if($(this).hasClass('act-calculus')){
      var xcd = offset.left + 170;

      var calculusY =  event.pageY - 980;
      var calculusX =  event.pageX - xcd;
      }else{
      var calculusY = event.pageY - offset.top;
      var calculusX = event.pageX - offset.left;  
      }
      var widhtxcv =  $( '#container-img' ).width();
      var heighycv = $( '#container-img' ).height();
      var widhtxcvm = widhtxcv/2;
      var heighycvm = heighycv/2;

      $( "#log" ).text( "pageX: " + calculusX + ", pageY: " + calculusY +  '[' + offset.left + 'px,' +  offset.top + 'px]' + '-<' + widhtxcv + '-<' + heighycv);
      var mRand =  Math.floor((Math.random() * 1012) + 1111111111);
      var strRand = Math.floor((Math.random() * 42422) + 102481204);
      var singleDivId = mRand + strRand; 

     
      if (calculusX < widhtxcvm) {
        if ( calculusY < heighycvm){
        var calculusZ  = calculusY + 5;
        var calculusV  = calculusX + 5;
        } else {
        var calculusZ  = calculusY + -248;
        var calculusV  = calculusX + 5;  
        }
      } else {
        if ( calculusY < heighycvm){
        var calculusZ  = calculusY + 5;
        var calculusV  = calculusX - 248;
        } else {
        var calculusZ  = calculusY - 248;
        var calculusV  = calculusX - 248;  
        }
      }
      
      
      var div = '<div id="'+singleDivId+'" class="point" style="margin-top:'+calculusY+'px; margin-left:'+calculusX+'px;"></div>';
      var container = '<div id="light-'+singleDivId+'" class="pointopen" style="margin-top:'+calculusZ+'px; margin-left:'+calculusV+'px;">Cargando ...</div>';


      $(this).append(div);
      $(this).append(container);

      var url = "/acupuntures/generate_point?id="+ singleDivId + "&container=light-"+singleDivId+"&x_axis="+ calculusX + "&y_axis="+calculusY;
      $.get(url)
    }
  });


});

