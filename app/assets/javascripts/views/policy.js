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
			{ field: "title", title: "Policy Name", width: "40%" },
			{ field: "classification", title: "Classifications", width: "40%" },
			{ field: "distribution", title: "Distributions", width: "40%" },
			{ field: "kind", title: "Kinds", width: "40%" },
			{ field: "version", title: "Versions", width: "40%" },
			{ field: "owner", title: "Owners", width: "40%" }
		]
	});

	// Grid II

});