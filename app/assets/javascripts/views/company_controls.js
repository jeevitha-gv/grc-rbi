$(document).ready(function(){


	// Grid I

	dataSource = new kendo.data.DataSource({
		transport: {
			read: {
				url: "/company_controls",
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
					title: { type: "string" }
					// control_classification: { type: "string" },
					// purpose: { type: "string" },
					// control_state: { type: "string" },
					// control_freq: { type: "string" },
					// standard: { type: "string" },					
					// description: { type: "string" }

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
			{ field: "title", title: "Title", width: "40%" }
			// { field: "control_classification", title: "Control Classification", width: "40%" },
			// { field: "purpose", title: "Purpose", width: "40%" },
			// { field: "control_state", title: "Control State", width: "40%" },
			// { field: "control_freq", title: "Control Freq", width: "40%" },
			// { field: "standard", title: "Standard", width: "40%" },			
			// { field: "description", title: "Cescription", width: "40%" }
		]
	});

	// Grid II

});