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

function get_risk_owners(element){
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

function change_scoring_method(element){
  var scoringType = $(element).val();
  if (scoringType == 'ClassicScoring')
  {
    $('.scoring_model').show();
    $('.classic_scoring').show();
    $('.owasp_scoring').hide();
    $('.dread_scoring').hide();
    $('.cvss_scoring').hide();
    $('.custom_scoring').hide();
  }
  if (scoringType == 'OwaspScoring')
  {
    $('.owasp_scoring').show();
    $('.scoring_model').hide();
    $('.dread_scoring').hide();
    $('.cvss_scoring').hide();
    $('.custom_scoring').hide();
    $('.scoring_model').hide();
    $('.classic_scoring').hide();
  }
  if (scoringType == 'DreadScoring')
  {
    $('.dread_scoring').show();
    $('.scoring_model').hide();
    $('.owasp_scoring').hide();
    $('.cvss_scoring').hide();
    $('.custom_scoring').hide();
    $('.scoring_model').hide();
    $('.classic_scoring').hide();
  }
  if (scoringType == 'CvssScoring')
  {
    $('.cvss_scoring').show();
    $('.scoring_model').hide();
    $('.owasp_scoring').hide();
    $('.dread_scoring').hide();
    $('.custom_scoring').hide();
    $('.scoring_model').hide();
    $('.classic_scoring').hide();
  }
  if (scoringType == 'Custom')
  {
    $('.custom_scoring').show();
    $('.scoring_model').hide();
    $('.owasp_scoring').hide();
    $('.dread_scoring').hide();
    $('.cvss_scoring').hide();
    $('.scoring_model').hide();
    $('.classic_scoring').hide();
  }
}