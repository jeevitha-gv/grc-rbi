$(document).on('ready page:load', function(){

 	$('#calendar').fullCalendar({
	 	editable: true,
	 	header: {
			left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
	 	},
	 	selectable: true,
	 	eventSources:[{
	 		url:'/policy_dashboards/calender',
	 		color: 'linear-gradient(to bottom, #1e5799 0%, #2989d8 50%, #207cca 51%, #7db9e8 100%) repeat scroll 0 0 rgba(0, 0, 0, 0)',
            textColor: 'black'
	 	}],
	 	eventMouseover: function( event, jsEvent, view ) { 
	 		title = ("Policy: "+ event.title + "Effective From :" + event.start_date + "Effective Till: " + event.end_date)
	 		$('.fc-event-inner').attr('data-original-title', title);
	 		$('.fc-event-inner').tooltip({placement: 'top'});
	 	},
	 	 eventMouseout: function(event, jsEvent, view) {
			$('#tooltip').css({display: 'none'});
		},
 	});

});