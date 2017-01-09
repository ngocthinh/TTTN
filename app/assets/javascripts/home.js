$(document).on('turbolinks:load', function (){

   $pri = $("#priceproduct").val()
  $("#count").bind('keyup change click',function(){
     $("#price").text($pri*this.value);
  });

   for(var i = 1; i <= 9; i++) {
   	$("#"+i).mouseenter(function(){
    $(this).css({ 'color': 'red', 'font-size': '170%' });
    });

    $("#"+i).mouseleave(function(){
    $(this).css({ 'color': '#3366ff', 'font-size': '100%' });
    });
    };

    $("#btn_delete").click(function(){
        $(this).html('Save');
    });
    
});
