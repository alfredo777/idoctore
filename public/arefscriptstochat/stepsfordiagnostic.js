  
  $('#prev').click(function(){
        var target = $(this).data('target');

        if (target == 'step-1'){
        TargetTo(this, 'interrogation', target, 'step-1', 'step-2', false, 'prev');
        }
        if (target == 'step-2'){
        TargetTo(this, 'diagnostic_or_clinical_problem', target, 'step-1', 'step-3', false, 'prev');
        }
        if (target == 'step-3'){
        TargetTo(this, 'suggested_treatments', target, 'step-2', 'step-4', true, 'prev');
        }

   });

  $('#next').click(function(){
        var target = $(this).data('target');

        if (target == 'step-2'){
        TargetTo(this, 'interrogation', target, 'step-1', 'step-3', false, 'next');
        }

        if (target == 'step-3'){
        TargetTo(this, 'diagnostic_or_clinical_problem', target, 'step-2', 'step-4', false, 'next');
        }

        if (target == 'step-4'){
        TargetTo(this, 'suggested_treatments', target, '' , '', true, 'next');
        }
   });

   $('.link_to_t').click(function() {
    var target = $(this).data('target');
    var to = '#'+target;
    $(to).toggle();
   });

   function TargetTo(targ, validates, target, prev, next, finalx, typee){
        console.log(target);
        console.log(targ)
        if (!$.trim($('#'+validates).val())){
            alert('Campo Vacio No puede continuar');
          }else{
           $('.PageForm').hide();
           $('#' + target).show();
           if (typee == 'prev'){
             $('#prev').data('target', prev);
             $('#next').data('target', next);
              if (finalx == true){
                $('#next').show();
                $('#create').hide();
              }
           }
           if (typee == 'next') {
             $('#prev').data('target', prev);
             $('#next').data('target', next);
              if (finalx == true){
                $('#next').hide();
                $('#prev').data('target', 'step-3');
                $('#create').show();
              }
          }

        }
   }