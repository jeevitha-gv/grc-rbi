	$(document).ready(function(){
	 $("#auditees-users option").each(function( index ) {
    var user_value = ($(this).attr('class'))
    if(user_value!=""){$(this).attr('selected', true)}
  });
	});
	
	function auditee_add()
	{
    var size = $('#auditee-list').find('.auditee-rows').size();
    $("#auditee-list").append(""+"<div class='form-group clearfix auditee-dropdown'>"+$(".auditee-dropdown").html().replace('audit[audit_auditees_attributes][0][user_id]','audit[audit_auditees_attributes]['+size+'][user_id]')+"</div>"+"")//.replace(, ''); ;
  }

	
 $(document).ready(function(){
    $("#audit_compliance_type").change(function () {
      $('#standard-compliance  select').attr('name', '');
      $('#standard-topic  select').attr('name', '');
      var getStandardVal = this.value;
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
    });

    $(".datepicker").kendoDatePicker({
      format: "dd/MM/yyyy"
    });
    $(".datepicker1").kendoDatePicker({
      format: "dd/MM/yyyy"
    });


    // $('#add_auditee').click(function(){
    //   var size = $('#auditee-list').find('.auditee-rows').size();

    //   // console.log(cd append)
    //   $("#auditee-list").append(""+"<div class='form-group clearfix auditee-dropdown'>"+$(".auditee-dropdown").html().replace('audit[audit_auditees_attributes][0][user_id]','audit[audit_auditees_attributes]['+size+'][user_id]')+"</div>"+"");
    // });

    $(".next-phase").click(function(){
      // new Messi('Planned for further phases.', {autoclose: '5000'});
      new Messi('Planned for further phases.', {title: 'Warning', titleClass: 'warning', autoclose: 2000});
    });
  });
	
	 function get_departments(element){
    var location_id = $(element).val();
    if(location_id.length>0){
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