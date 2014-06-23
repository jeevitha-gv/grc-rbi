// Kendo Tab
		$("#tabstrip").kendoTabStrip({
			animation:  {
				open: {
					effects: "fadeIn"
				}
			}
		});

 $(document).ready(function(){

	function onActivate(e) {
     if($('#search-value').val() != "")
     {
      $('#search-value').val('')
      var tabActive = e.sender.tabGroup.children("li.k-state-active").attr("aria-controls")
      var gridForSearch = select_grid(tabActive)
      $("#"+gridForSearch).data("kendoGrid").dataSource.filter({});
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
		var tabActive = tabstrip.tabGroup.children("li.k-state-active").attr("aria-controls")
		var val = $('#search-value').val();
    var gridForSearch = select_grid(tabActive)
    $("#"+gridForSearch).data("kendoGrid").dataSource.filter({
			logic  : "or",
			filters: [
				{
					field: "title",
					operator: "contains",
					value   : val
				},
				{
					field: "client",
					operator: "contains",
					value   : val
				},
				{
					field: "audit_type",
					operator: "contains",
					value   : val
				},
				{
					field: "compliance_type",
					operator: "contains",
					value   : val
				},
				{
					field: "auditor",
					operator: "contains",
					value   : val
				},
			]
		});
	}

	function select_grid(tabActive)
		{
			if(tabActive == 'tabstrip-1')
		  {
		    return "gridforall";
		  }
		  else if(tabActive == 'tabstrip-2')
		  {
		   	return "gridforplan";
		  }
		  else if(tabActive=='tabstrip-3')
		  {
		    return "gridforprogress";
		  }
		  else if(tabActive=='tabstrip-4')
		  {
		    return "gridforpublish";
		  }
		}


});

// Function for Grid button
	function set_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		if ( dataItem.compliance_type == "Compliance")
		{
			deleteCookie()
			setCookie("audit_id", dataItem.id)
			window.location.href = "/audit_compliances"
		}
		else
		{
			deleteCookie()
			setCookie("audit_id", dataItem.id)
			window.location.href = "/nc_questions/new"
		}
	}

	function check_file(e)
	{
		deleteCookie()
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		setCookie("audit_id", dataItem.id)
		window.location.href = "/checklist_recommendations/new"
	}

	function act_file(e)
	{
		deleteCookie()
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		setCookie("audit_id", dataItem.id)
		window.location.href = "/checklist_recommendations/auditee_response"
	}

	function publish_file(e)
	{
		deleteCookie()
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		setCookie("audit_id", dataItem.id)
		window.location.href = "/checklist_recommendations/audit_observation"
	}

	function edit_file(e)
	{
		deleteCookie()
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		setCookie("audit_id", dataItem.id)
		window.location.href = "/audits/"+ dataItem.id + "/edit"
	}

	function pdf_file(e)
	{
		deleteCookie()
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		setCookie("audit_id", dataItem.id)
		window.location.href = "/audits/"+ dataItem.id +".pdf"
	}

	$(document).ready(function() {

		if ( stage.length > 0 )
		{
			var	audits_url = "/audits/audit_all?stage="+stage;
		}
		else
		{
			var audits_url = "/audits/audit_all"
		}
		// Data source for all
		dataSource = new kendo.data.DataSource({
			transport: {
				read: {
					url: audits_url,
					type: "post",
					dataType: 'json'
				}
			},
			schema: {
				errors: function(response) {
				return response.errors;
			},
			data: "data",
				model: {
					id: "id",
					fields:{
						id: { type: "string" },
						title: { type: "string" },
						client: { type: "string" },
						audit_type: { type: "string" },
						compliance_type: { type: "string" },
						auditor: {type: "string"}
					}
				}
			}
		});

		// Kendo Grid for all
		$("#gridforstage").kendoGrid({
			dataSource: dataSource,
			height: 'auto',
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ field: "title", title: "Audit Title" ,width: "35%"},
				{ field: "client", title: "Client Name", width: "35%" },
				{ field: "audit_type", title: "Audit Type", width: "35%" },
				{ field: "compliance_type", title: "Compliance Type", width: "35%" },
				{ field: "auditor", title: "Auditor Name", width: "35%" },

				{command: [{text: "Set", click: set_file},{text: "tick", click: check_file},{text: "tick1", click: act_file},{text: "book", click: publish_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Actions", width: "180px" }
			],
		});


		// Kendo Grid for all
		$("#gridforall").kendoGrid({
			dataSource: dataSource,
			height: 'auto',
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ field: "title", title: "Audit Title" ,width: "35%"},
				{ field: "client", title: "Client Name", width: "35%" },
				{ field: "audit_type", title: "Audit Type", width: "35%" },
				{ field: "compliance_type", title: "Compliance Type", width: "35%" },
				{ field: "auditor", title: "Auditor Name", width: "35%" },

				{command: [{text: "Set", click: set_file},{text: "tick", click: check_file},{text: "tick1", click: act_file},{text: "book", click: publish_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Actions", width: "180px" }
			],
		});

   // Datasource for plan
		dataSourceplan = new kendo.data.DataSource({
			transport: {
				read: {
					url: "/audits/audit_with_status?audit_status_id=1",
					type: "post",
					dataType: 'json'
				}
			},
			schema: {
				errors: function(response) {
				return response.errors;
			},
			data: "data",
			model: {
				id: "id",
				fields: {
					id: { type: "string" },
					title: { type: "string" },
					client: { type: "string" },
					audit_type: { type: "string" },
					compliance_type: { type: "string" },
					auditor: {type: "string"}
					}
				}
			}
		});

		//grid for planned
		$("#gridforplan").kendoGrid({
			dataSource: dataSourceplan,
			height: 'auto',
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ field: "title", title: "Audit Title" ,width: "35%"},
				{ field: "client", title: "Client Name", width: "35%" },
				{ field: "audit_type", title: "Audit Type", width: "35%" },
				{ field: "compliance_type", title: "Compliance Type", width: "35%" },
				{ field: "auditor", title: "Auditor Name", width: "35%" },

        {command: [{text: "Set", click: set_file},{text: "tick", click: check_file},{text: "tick1", click: act_file},{text: "book", click: publish_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Actions", width: "180px" }			],
		});


   // Datasource for progress
		dataSourceprogress = new kendo.data.DataSource({
			transport: {
				read: {
					url: "/audits/audit_with_status?audit_status_id=3",
					type: "post",
					dataType: 'json'
				}
			},
			schema: {
				errors: function(response) {
				return response.errors;
			},
			data: "data",
			model: {
				id: "id",
				fields: {
					id: { type: "string" },
					title: { type: "string" },
					client: { type: "string" },
					audit_type: { type: "string" },
					compliance_type: { type: "string" },
					auditor: {type: "string"}
					}
				}
			}
		});


		//grid for InProgress
		$("#gridforprogress").kendoGrid({
			dataSource: dataSourceprogress,
			height: 'auto',
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ field: "title", title: "Audit Title" ,width: "35%"},
				{ field: "client", title: "Client Name", width: "35%" },
				{ field: "audit_type", title: "Audit Type", width: "35%" },
				{ field: "compliance_type", title: "Compliance Type", width: "35%" },
				{ field: "auditor", title: "Auditor Name", width: "35%" },

        {command: [{text: "Set", click: set_file},{text: "tick", click: check_file},{text: "tick1", click: act_file},{text: "book", click: publish_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Actions", width: "180px" }			],
		});


    // Datasource for publish
		dataSourcepublish = new kendo.data.DataSource({
			transport: {
				read: {
					url: "/audits/audit_with_status?audit_status_id=4",
					type: "post",
					dataType: 'json'
				}
			},
			schema: {
				errors: function(response) {
				return response.errors;
			},
			data: "data",
				model: {
				id: "id",
				fields: {
					id: { type: "string" },
					title: { type: "string" },
					client: { type: "string" },
					audit_type: { type: "string" },
					compliance_type: { type: "string" },
					auditor: {type: "string"}
					}
				}
			}
		});

		//grid for published
		$("#gridforpublish").kendoGrid({
			dataSource: dataSourcepublish,
			height: 'auto',
			scrollable: true,
			sortable: true,
			filterable: true,
			pageable: {
				input: true,
				numeric: false
			},
			columns: [
				{ field: "title", title: "Audit Title" ,width: "35%"},
				{ field: "client", title: "Client Name", width: "35%" },
				{ field: "audit_type", title: "Audit Type", width: "35%" },
				{ field: "compliance_type", title: "Compliance Type", width: "35%" },
				{ field: "auditor", title: "Auditor Name", width: "35%" },

        {command: [{text: "Set", click: set_file},{text: "tick", click: check_file},{text: "tick1", click: act_file},{text: "book", click: publish_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Actions", width: "180px" }			],
		});


	});
