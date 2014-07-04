$(document).ready(function() {
	// Fancybox
	$(".fancybox").fancybox();

	// Kendo Datapicker
	$("#datepicker").kendoDatePicker();

	// Kendo Tab
	$("#tabstrip").kendoTabStrip({
		animation:  {
			open: {
				effects: "fadeIn"
			}
		}
	});

	// Kendo Panel
	$("#panelbar").kendoPanelBar();

	dataSource = new kendo.data.DataSource({
		transport: {
			read: {
				url: '/risks',
				dataType: 'json',
				type: 'get'
			},
		},
		schema: {
			errors: function(response) {
			return response.errors;
		},
		data: "data",
		model: {
			id: "id",
				fields: {
					subject: { type: "string" },
					status: { type: "string" },
					risk: {type: "string"},
					owner: {type: "string"},
					days_open: {type: "string"}
				}
			}
		},
		pageSize: 20
	});

	// Kendo Grid
	$("#grid").kendoGrid({
		dataSource: dataSource,
		dataBound: function(){
			risk_gridTitle()
		},
		height: 'auto',
		scrollable: true,
		sortable: true,
		filterable: true,
		pageable: {
		input: true,
		numeric: false
		},
		columns: [
			{ field: "subject", title: "Subject", width: "40%" },
			{ field: "status", title: "Status", width: "30%" },
			{ field: "risk", title: "Risk", width: "8%" },
			{ field: "owner", title: "Owner", width: "20%" },
			{ field: "days_open", title: "Days Open", width: "15%" },
			{ command: [{text: "file"},{text: "list"},{text: "miti"},{text: "edit", click: edit_file}], title: "Action", width: "170px" }
		],
	//~ editable: "popup"
	});

	function modify(){
		$('.editable-input').val($('.editable-select').val());
		output();
	}

	function output(){
		$('.editable-result').text('value: ' + $('.editable-input').val());
	}

	function edit_file(e)
	{
		this.dataItem($(e.currentTarget).closest("tr"));
		console.log(this.dataItem(jQuery(e.currentTarget).closest("tr")).id)
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/risks/"+ dataItem.id + "/edit"
	}

	$('.editable-input').on('click', function(){
		$(this).select()
			}).on('blur', function(){
		output();
	})

	modify();

	// More contacts show
	$(".more-link").click(function(){
		if($(this).html() == "More")
			$(this).html("Less").parent().siblings(".more-info").show();
		else
			$(this).html("More").parent().siblings(".more-info").hide();
	});

	function risk_gridTitle()
	{
		$('.k-grid-file').attr('title','File');
		$('.k-grid-list').attr('title','Mitigate');
		$('.k-grid-miti').attr('title','review');
		$('.k-grid-edit').attr('title','Edit');
	}

	function onActivate(e) {
	if($('#search-value').val() != "")
	{
		$('#search-value').val('')
		$("#grid").data("kendoGrid").dataSource.filter({});
		}
	}

	$("#tabstrip").kendoTabStrip({
		activate: onActivate
	});

	$("#search-button").click(function(){
		search_result();
	})

	$("#search-value").on('keyup', function(e) {
		if (e.which == 13) {
			e.preventDefault();
			search_result()
		}
	});

	function search_result()
	{
		var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
		var val = $('#search-value').val();
		$("#grid").data("kendoGrid").dataSource.filter({
			logic  : "or",
			filters: [
			{
				field: "subject",
				operator: "contains",
				value   : val
			},
			{
				field: "status",
				operator: "contains",
				value   : val
			},
			{
				field: "risk",
				operator: "contains",
				value   : val
			},
			{
				field: "owner",
				operator: "contains",
				value   : val
			},
			{
				field: "days_open",
				operator: "contains",
				value   : val
			},
			]
		});
	}

});