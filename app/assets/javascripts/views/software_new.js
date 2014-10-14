 $(document).ready(function(){
    
    var temp_start = $(".datepicker").val()
    var start = $(".datepicker").kendoDatePicker({
      format: "dd/MM/yyyy"
  }).data("kendoDatePicker");
 

    $(".datepicker").bind("focus", function() {
      $(this).data("kendoDatePicker").open();
    });
    $('.datepicker').attr('readonly', true);

    $(".datepicker1").bind("focus", function() {
      $(this).data("kendoDatePicker").open();
    });
    $('.datepicker1').attr('readonly', true);

    $(".datepicker").val(temp_start)
  });