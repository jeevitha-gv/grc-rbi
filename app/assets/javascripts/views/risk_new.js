function get_compliance_libraries(element) {
  $('.ajax-loader').show();
  var compliance_id = $(element).val();
  if(compliance_id.length > 0) {
    $.ajax({
      url: "/risks/department_teams_users",
      type: "GET",
      data: {"compliance_id" : compliance_id}
    });
  }
}

function get_departments(element){
  $('.ajax-loader').show();
  var location_id = $(element).val();
  if(location_id.length>0){
    $.ajax({
      url: "/risks/department_teams_users",
      type: "GET",
      data: {"location_id" : location_id}
    });
  }
}

function get_teams(element){
  $('.ajax-loader-department').show();
  var department_id = $(element).val();
  if(department_id.length>0){
    $.ajax({
      url: "/risks/department_teams_users",
      type: "GET",
      data: {"department_id" : department_id}
    });
  }
}

function get_auditee_users(element){
  $('.ajax-loader-team').show();
  var team_id = $(element).val();
  if(team_id.length>0){
    $.ajax({
      url: "/risks/department_teams_users",
      type: "GET",
      data: {"team_id" : team_id}
    });
  }
}