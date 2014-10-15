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

$(function () {
    $('#container').highcharts({
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Chennai',   45.0],
                ['Bangalore',       26.8],
                {
                    name: 'Patna',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Mumbai',    8.5],
                ['Kerala',     6.2],
                ['Hyderabad',   0.7]
            ]
        }]
    });

    $('#container1').highcharts({
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['HR',   45.0],
                ['Risk',       26.8],
                {
                    name: 'Audit',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Testing',    8.5],
                ['Development',     6.2],
                ['Others',   0.7]
            ]
        }]
    });
    $('#container2').highcharts({
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Prventive',   45.0],
                ['Corrective',       26.8],
                {
                    name: 'Detective',
                    y: 12.8,
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
    $('#container3').highcharts({
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Continues',   45.0],
                ['Event Driven',       26.8],
                {
                    name: 'Periodic',
                    y: 12.8,
                    sliced: true,
                    selected: true
                }
            ]
        }]
    });
});