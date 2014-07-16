/* validation for auditee_response*/
$(window).load(function(){
  var $container = $('#grid_items');
  // initialize
  $container.masonry({
    columnWidth: 292,
    itemSelector: '.item',
    isFitWidth: true
  });


  $(".block_banner img").each(function(index, element) {
        var screenImage = $(this);

    // Create new offscreen image to test
    var theImage = new Image();
    theImage.src = screenImage.attr("src");

    var imageHeight = theImage.height;

    $(this).css("max-height",imageHeight);
    $(this).css("min-height",imageHeight);
    });
});

$(".click_icon").click(function() {
      $(".share_pop").show();
});

$(".click_icon").click(function(){
    $(".share_pop").show();
});

$(document).ready(function(){

  Top_postion = $(window).scrollTop();

  $( ".user_login" ).mouseenter(function() {
    $(this).addClass("active");
    $(".account_header_dropdown").slideDown(100);
  })
  .mouseleave(function() {
    $(this).removeClass("active");
    $(".account_header_dropdown").hide();
  });

  //for notification drop hide in outside click
  onclick_icon = 0;
  $(".click_icon").mouseenter(function() {
    onclick_icon = 0;
  })
  .mouseleave(function() {
    onclick_icon = 1;
  });


  $("body").click(function(){
    if(onclick_icon){
      $(".share_pop").hide();
    }
  });


  /* placeholder */
  $(".place_holder").each(function(index, element) {
    placeholder = $(this).attr("data-original");
    $(this).val(placeholder);
    $(this).removeClass("active");
    });

  $(".place_holder").focus(function(){
    placeholder = $(this).attr("data-original");
    current_value = $(this).val();
    if(current_value==placeholder){
      $(this).val("");
      $(this).addClass("active");
    }
  });
  $(".place_holder").blur(function(){
    placeholder = $(this).attr("data-original");
    current_value = $(this).val();
    if(current_value==""){
      $(this).val(placeholder);
      $(this).removeClass("active");
    }else{
      $(this).addClass("active");
    }
  });
  $(".place_holder").click(function(){
    placeholder = $(this).attr("data-original");
    current_value = $(this).val();
    if(current_value==placeholder){
      $(this).val("");
      $(this).addClass("active");
    }
  });
  /* placeholder */

});
/*$(window).scroll(function(){
  Top_postion = $(window).scrollTop();

  if(Top_postion>10){
    $(".go_to_top").show();
  }else{
    $(".go_to_top").hide();
  }
});
$(".go_to_top").click(function(){
  top = 0;
  $("html, body").animate({scrollTop: "0"}, 800);
});
*/

function display_selected_files(e)
{
$(e).parent().find("#selected_files").html("<h5>selected: " + $(e).val() + "</h5>");
}

$(function() {
  $( "#Accordion1" ).accordion();
});


function answer_response()
{
  var detailed = detailed_check()
  var checkbox = checkbox_validate()
  var multiple_checkbox = checkbox_validate_multiple()
  var attachment = attachment_check()
  if(detailed && checkbox && multiple_checkbox && attachment)
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
  var detailed_answer = []
  $(".nc_question_answer").each(function() {
    var detailed_value = $(this).val()
    if (detailed_value == '')
    {
      $('#'+this.id).addClass("error_input");
      $('#error_'+this.id).show();
      detailed_answer.push('true');
    }
    else
    {
      $('#'+this.id).removeClass("error_input");
      $('#error_'+this.id).hide()
      detailed_answer.push('false');
    }
  });
  if (detailed_answer.indexOf( 'true' ) == -1)
  {
    value = true
  }
  else
  {
    value = false
  }
  return value
}
function checkbox_validate()
{
  test = []
  yesOrNo = []
  var yes_or_no = $('.answer_yes_or_no').length
  $('.answer_yes_or_no').each(function(){
    yesOrNo.push($(this).attr('id'))
  })
  $('.answer_check:checked').each(function(index) {
    val = index + 2;
    var valu = $(this).val();
    if (valu)
    {
      var name = $(this).attr('name')
      var answer_id = name.split('[')[1].split(']')[0];
      test.push(answer_id);
      $('#answer_check_'+answer_id).remove();
      yesOrNo.splice($.inArray(answer_id, yesOrNo),1);
    }
  });
  if (yesOrNo.length > 0)
  {
    for(var i = 0; i < yesOrNo.length; i++)
    {
      $('#answer_check_'+yesOrNo[i]).show();
    }
  }

  if(test.length != yes_or_no)
  {
    return false;
  }
  else
  {
    return true;
  }
}

function checkbox_validate_multiple()
{
  test = []
  $('.multiple_answer_check:checked').each(function(index) {
    val = index + 2;
    var valu = $(this).val();
    test.push(valu)
  });
  var multipleOptions = $('.multiple-choice').length
  // console.log(multipleOptions+'multiple length')
  // console.log(test+'muitple')
  if (multipleOptions != test.length)
  {
    $('#answer_check_multiple').show();
    return false;
  }
  else
  {
    $('#answer_check_multiple').hide();
    return true;
  }
}

function attachment_check()
{
  test = []
  $('.attachment-check').each(function(index) {
    val = index + 2;
    var valu = $(this).val();
    console.log(valu)
    if (valu == '')
    {
      var name = $(this).attr('name')
      var answer_id = name.split('[')[1].split(']')[0];
      test.push(answer_id);
      $('#answer_attachment_'+answer_id).show();
    }
  });
  $('.answered-attachment').each(function(){
    var attach_html = $(this).html().trim();
    if (attach_html.length>100)
    {
      var attach_id = $(this).attr('id');
      test.splice($.inArray(attach_id, test),1);
    }
  })

  if(test.length>0)
  {
    // alert(test)
    for(var i = 0; i < test.length; i++)
    {
      $('#answer_attachment_'+this[i]).show();
    }
    return false;
  }
  else
  {
    return true;
  }
}