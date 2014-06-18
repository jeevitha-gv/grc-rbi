/* validation for auditee_response*/
function answer_response()

{
  var detailed = detailed_check()
  var checkbox = checkbox_validate()
  if(detailed && checkbox)
  {
    return true;
  }
  else
  {
    return false
  }
}
function detailed_check()
  {
    $(".nc_question_answer").each(function() {
      var detailed_value = $(this).val()
      if (detailed_value == '')
      {
        $('#'+this.id).addClass("error_input");
        $('#error_'+this.id).show();
        value = false
      }
      else
      {
        $('#'+this.id).removeClass("error_input");
        $('#error_'+this.id).hide()
        value = true
      }
    });
    return value
  }


function checkbox_validate()
  {
  var chks = document.getElementsByClassName('answer_check');
  var hasChecked = false;
  for (var i = 0; i < chks.length; i++)
  {
    if (chks[i].checked)
    {
    hasChecked = true;
    break;
    }
  }

  if (hasChecked == false)
    {
    var answer = $('#answer_id').attr('value');
    $('#answer_check_'+answer).show()
    return false;
    }

  return true;
  }

