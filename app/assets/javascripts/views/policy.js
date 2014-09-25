$(document).ready(function(){

	// effective from datepicker
	$(".datepicker").kendoDatePicker();
	$(".datepicker1").kendoDatePicker();

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
					author: { type: "string" }

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
			{ field: "author", title: "Authors", width: "40%" }
		]
	});

	// Grid II

});