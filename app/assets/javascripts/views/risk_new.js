function get_compliance_libraries(element) {
  $('.ajax-loader').show();
  var compliance_id = $(element).val();
  if(compliance_id.length > 0) {
    $.ajax({
      url: "/risks/compliance_libraries",
      type: "GET",
      data: {"compliance_id" : compliance_id}
    });
  }
}