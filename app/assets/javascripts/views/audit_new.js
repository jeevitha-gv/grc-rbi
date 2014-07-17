  function standard_display(getStandardVal)
  {
      if(getStandardVal == 'Compliance')
        {
          $('#standard-compliance').show();
          $('#standard-compliance  select').attr('name', 'audit[standard_id]');
          $('#standard-topic  select').attr('name', '');
          $('#standard-topic').hide();
        }
        else if(getStandardVal == 'NonCompliance')
        {
          $('#standard-topic').show();
          $('#standard-topic  select').attr('name', 'audit[standard_id]');
          $('#standard-compliance  select').attr('name', '');
          $('#standard-compliance').hide();
        }
        else if(getStandardVal=='')
        {
          $('#standard-compliance').hide();
          $('#standard-topic').hide();
        }
  }

 $(document).ready(function(){
    standard_display($("#audit_compliance_type").val());
    $("#audit_compliance_type").change(function () {
      $('#standard-compliance  select').attr('name', '');
      $('#standard-topic  select').attr('name', '');
      standard_display(this.value)
    });

    function startChange() {
      var startDate = start.value();

      if (startDate) {
          startDate = new Date(startDate);
          startDate.setDate(startDate.getDate() + 1);
          end.min(startDate);
      }
  }

  function endChange() {
      var endDate = end.value();

      if (endDate) {
          endDate = new Date(endDate);
          endDate.setDate(endDate.getDate() - 1);
          start.max(endDate);
      }
  }
    var temp_start = $(".datepicker").val()
    var start = $(".datepicker").kendoDatePicker({
      change: startChange,
      min: new Date(),
      value: new Date(2011, 0, 1),
      format: "dd/MM/yyyy"
  }).data("kendoDatePicker");

  var end = jQuery(".datepicker1").kendoDatePicker({
      change: endChange,
      format: "dd/MM/yyyy"
  }).data("kendoDatePicker");

  start.max(end.value());
  end.min(start.value());

    $(".datepicker").bind("focus", function() {
      $(this).data("kendoDatePicker").open();
    });
    $('.datepicker').attr('readonly', true);

    $(".datepicker1").bind("focus", function() {
      $(this).data("kendoDatePicker").open();
    });
    $('.datepicker1').attr('readonly', true);

    $(".datepicker").val(temp_start)

    $('.add-risk').click(function(){
      var check = $('#risk_value:checked').val();
      if(check.length > 0)
      {
        $('#audit_title').val('');
        var riskSubject = $('#risk_subject_'+check).text();
        $('#audit_title').val(riskSubject);
      }
    })
  });

	 function get_departments(element){
    var location_id = $(element).val();
    if(location_id.length>0){
      $('.ajax-loader').show();
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"location_id" : location_id}
      });
    }
    else{
      $('#department-dropdown').hide();
      $('#teams-dropdown').hide();
    }
  }

  function get_teams(element){
    var department_id = $(element).val();
    if(department_id.length>0){
      $('.ajax-loader-department').show();
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"department_id" : department_id}
      });
    }
    else {
      $('#teams-dropdown').hide();
    }
  }

  function get_auditee_users(element){
    var team_id = $(element).val();
    if(team_id.length>0){
      $('.ajax-loader-team').show();
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"team_id" : team_id}
      });
    }
    else {
      $('#teams-dropdown').hide();
    }
  }