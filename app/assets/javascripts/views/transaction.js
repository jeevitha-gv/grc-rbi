$(document).ready(function(){
  var currentDate = new Date()
  var month = currentDate.getMonth() + 1

  var currentYear = $('#credit_card_year').val()
  monthForTransaction(currentYear)

  $('#credit_card_year').change(function(){
    var currentYear = $('#credit_card_year').val()
    monthForTransaction(currentYear)
  })

  $(".credit_card_verification_value").focusout(function(){
    var cvvValue = $(".credit_card_verification_value").val();
    validate(/^\d+$/, result, cvvValue, "Cvv is invalid")
  });

  $(".credit_card_first_name").focusout(function(){
    var firstName = $(".credit_card_first_name").val();
    validate(/^[a-zA-Z_]+$/, first_name, firstName, "Name must contain only alphabets")
  });

  $(".credit_card_last_name").focusout(function(){
    var lastName = $(".credit_card_last_name").val();
    validate(/^[a-zA-Z_]+$/, last_name, lastName, "Name must contain only alphabets")
  });

  function monthForTransaction(currentYear)
  {
    $('#credit_card_month').empty();
    if(currentYear == "2014")
    {
      for (var j = month; j < 13; j++ ){
        $("#credit_card_month").append("<option value='"+j+"'>"+j+"</option>");
      }
    }
    else
    {
      for (var j = 1; j < 13; j++ ){
        $("#credit_card_month").append("<option value='"+j+"'>"+j+"</option>");
      }
    }
  }
})

function validate(regExp, divID, fieldValue, validationMsg)
{
  $(divID).text("");
  var regExpressionForInt = regExp;
  console.log(!regExpressionForInt.test(fieldValue))
  if(!regExpressionForInt.test(fieldValue)) {
    $(divID).text(validationMsg);
    $(divID).css("color", "red");
    $(divID).show();
  }
  else
  {
    $(divID).text("");
    $(divID).hide();
  }
  return false;
}