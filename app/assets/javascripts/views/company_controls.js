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
					title: { type: "string" },
					control_state: { type: "string" },
					owner: { type: "string" },
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
			{ field: "title", title: "Title", width: "100%" },
			{ field: "control_state", title: "State", width: "40%" },
			{ field: "owner", title: "Owner", width: "40%" },
			{ command: [{text: "show" , click: show_file},{text: "list"},{text: "miti"},{text: "edit", click: edit_file},{ text: "pdf", click: pdf_file},{text: "graph"}], title: "Action", width: "45%"  }
		]
	});

	function show_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/company_controls/"+ dataItem.id 
	}

	function pdf_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/company_controls/"+ dataItem.id + ".pdf"
	}

	function edit_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/company_controls/"+ dataItem.id + "/edit"
	}

});