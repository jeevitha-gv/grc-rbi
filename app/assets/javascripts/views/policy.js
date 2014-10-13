$(document).ready(function(){

	// effective from datepicker
	$(".datepicker").kendoDatePicker({
		 format: "dd/MM/yyyy"
	});
	$(".datepicker1").kendoDatePicker({
		format: "dd/MM/yyyy"
	});
	$(".datepicker2").kendoDatePicker({
		format: "dd/MM/yyyy"
	});
	$(".datepicker3").kendoDatePicker({
		format: "dd/MM/yyyy"
	});

	// Grid I

	dataSource = new kendo.data.DataSource({
		transport: {
			read: {
				url: "/policies",
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
					title: { type: "string" },
					classification: { type: "string" },
					distribution: { type: "string" },
					kind: { type: "string" },
					version: { type: "string" },
					owner: { type: "string" }

				}
			}
		},
	});

	// Kendo Grid
	$("#grid").kendoGrid({
		dataSource: dataSource,
		height: 'auto',
		scrollable: true,
		sortable: true,
		filterable: true,
		pageable: false,
		columns: [
			{ field: "title", title: "Policy Name", width: "100%" },
			{ field: "classification", title: "Classifications", width: "40%" },
			{ field: "distribution", title: "Distributions", width: "40%" },
			{ field: "kind", title: "Kinds", width: "40%" },
			{ field: "version", title: "Versions", width: "40%" },
			{ field: "owner", title: "Owners", width: "40%" },
			{ command: [{text: "show", click: show_file},{text: "list"},{text: "miti"},{text: "edit",  click: show_file},{ text: "pdf", click: pdf_file },{text: "graph"}], title: "Action", width: "75%"  }
		]
	});

	function show_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + "/show_individual"
	}

	function pdf_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + ".pdf"
	}

	function edit_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + "/edit"
	}

	function riskGridTitle()
	{
		$('.k-grid-file').attr('title','File');
		$('.k-grid-show').attr('title','View');
		$('.k-grid-list').attr('title','Mitigate');
		$('.k-grid-miti').attr('title','review');
		$('.k-grid-edit').attr('title','Edit');
		$('.k-grid-pdf').attr('title','Report');
		$('.k-grid-graph').attr('title','Dashboard');
		$('.k-grid-delete').attr('title','Delete');
	}

});