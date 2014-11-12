$(document).on('ready page:load', function(){

    $('#calendar').fullCalendar({
        editable: true,
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        defaultView: 'month',
        height: 500,
        slotMinutes: 15,
        minTime: 1,
        maxTime: 24,
        firstHour: 8,
    	allDaySlot: true,

        loading: function(bool){
            if (bool)
                $('#loading').show();
            else
                $('#loading').hide();
        },

        selectable: true,
        selectHelper: true,
		droppable: false,


        // a future calendar might have many sources.
        eventSources: [
        {
            url: '/asset_dashboard/computers',
            color: 'grey',
            textColor: 'black',
        }        
        ],
        timeFormat: '',
        dragOpacity: "0.5",

		eventMouseover: function(event, jsEvent, view) {
    		title = ("Computer: "+ event.name + "<br />")
            $('.fc-event-inner').attr('data-original-title', title);
            $('.fc-event-inner').attr('data-html', "true");
    		$('.fc-event-inner').tooltip({placement: 'bottom'});
		},

		eventMouseout: function(event, jsEvent, view) {
			$('#tooltip').css({display: 'none'});
		},

		//~ //http://arshaw.com/fullcalendar/docs/event_ui/eventDrop/
        eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
            updateEvent(event);
        },

        eventResize: function(event, dayDelta, minuteDelta, revertFunc){
            updateEvent(event);
        },

		eventAfterRender: function (event, element, view) {
            var dataHoje =  convertDate();
			if(event.publised == "4")
			{
	    		element.css('background-color', '#89CC52');
				element.css('color','#fff');
				element.css('border-color','#89CC52');
			}
            else if (event.end_date < dataHoje) {
				element.css('background-color', '#EC5959');
				element.css('color','#fff');
				element.css('border-color','#EC5959');
			}
            else if (event.end_date >= dataHoje)
			{
                element.css('background-color', '#FFA200');
				element.css('color','#fff');
				element.css('border-color','#FFA200');
			}
		},

        // http://arshaw.com/fullcalendar/docs/mouse/eventClick/
        eventClick: function(event, jsEvent, view){
            // window.location.replace("/audits/"+event.id+'-'+event.title+"/audit_dashboard");
        },
    });
});


function convertDate() {
	function pad(s) { return (s < 10) ? '0' + s : s; }
    var d = new Date();
    return [pad(d.getFullYear()), pad(d.getMonth()+1), d.getDate()].join('-');
}