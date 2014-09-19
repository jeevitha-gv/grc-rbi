// For Asset Scoring
$( document ).ready(function() {
  $('.score').change(function() {
    var conf = parseInt($("#conf").val());
    var inte = parseInt($("#inte").val());
    var avai = parseInt($("#avai").val());
    var total_score = conf + inte + avai;
    $('#total_score').text(total_score);
    if( total_score > 7 && total_score <= 9 )
      $('#score_color').removeClass().addClass('high-box');
    else if( total_score > 5 && total_score <= 7 )
      $('#score_color').removeClass().addClass('medium-box');
    else if( total_score >= 3 && total_score <= 5 )
      $('#score_color').removeClass().addClass('low-box');
  });
});

$( document ).ready(function() {
    var conf = parseInt($("#conf").val());
    var inte = parseInt($("#inte").val());
    var avai = parseInt($("#avai").val());
    var total_score = conf + inte + avai;
    $('#total_score').text(total_score);
    if( total_score > 7 && total_score <= 9 )
      $('#score_color').removeClass().addClass('high-box');
    else if( total_score > 5 && total_score <= 7 )
      $('#score_color').removeClass().addClass('medium-box');
    else if( total_score >= 3 && total_score <= 5 )
      $('#score_color').removeClass().addClass('low-box');
});

// For Semantic Dropdown
$('.ui.dropdown')
  .dropdown();