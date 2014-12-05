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


		var controls_url = "/controls"


	dataSource = new kendo.data.DataSource({
		transport: {
			read: {
				url: controls_url,
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
					id: { type: "integer" },
					name: { type: "string" },
					owner: { type: "integer" },
					control_regulation: { type: "integer" },					
				}
			}
		},
	});

	// Kendo Grid
	$("#grid").kendoGrid({
		dataBound: function(){
			updateGridForStage(stage)
			controlGridTitle()
		},
		dataSource: dataSource,
		height: 'auto',
		scrollable: true,
		sortable: true,
		filterable: true,
		pageable: false,
		columns: [
			{ field: "id", title: "Control ID", width: "20%" },
			{ field: "name", title: "Name", width: "30%" },
			{ field: "owner", title: "Owner", width: "30%" },
			{ field: "control_regulation", title: "Control Regulation", width: "30%" },
		
			{ command: [{text: "list", click: approval_file},{text: "miti", click: review_file},{text: "book", click: audit_file},{text: "edit", click: edit_file},{text: "graph", click: graph_file}], title: "Action", width: "200px" }
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
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/controls/"+ dataItem.id + "/edit"
	}

	function approval_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/controls/"+ dataItem.id + "/control_approvals/new"
	}

	function review_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/controls/"+ dataItem.id + "/control_reviews/new"
	}
	function audit_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/controls/"+ dataItem.id + "/control_audits/new"
	}
	function graph_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/controls/"+ dataItem.id + "/risk_per_dashboard"
	}


	function select_stage_class(stage_class)
	{
		if(stage_class == 'approval')
	  {
	    return "k-grid-appr";
	  }
	  else if(stage_class == 'review')
	  {
	   	return "k-grid-revw, .k-grid-appr";
	  }
	  else if(stage_class == 'audit')
	  {
	   	return "k-grid-revw, .k-grid-appr, .k-grid-aud";
	  }
	}

	function updateGridForStage(stage)
	{

		
		if(stage.length == 0)
		{
			status_update_all()
		}
		else
		{
			var selected_stage = select_stage_class(stage)
			$('.'+selected_stage).addClass('active');
		}
	}

	function status_update_all()
	{
		var grid = $("#grid").data("kendoGrid");
		addGridAtiveClass(grid)
  }

  function addGridAtiveClass(grid)
  {
	  var gridData = grid.dataSource.view();
	  for (var i = 0; i < gridData.length; i++) {
	    var currentUid = gridData[i].uid;
	    var currenRow = grid.table.find("tr[data-uid='" + currentUid + "']");
	    currenStatus = gridData[i].status
	    if (currenStatus == "Mitigated")
	    {
	    	var test_row = $(currenRow).find(".k-grid-appr")
	    	$(test_row).addClass('active')
	    }
	    else if (currenStatus == "Reviewed" || currenStatus == "Rejected")
	    {
	    	var test_row = $(currenRow).find(".k-grid-appr, .k-grid-revw")
	    	$(test_row).addClass('active')
	  	}
	  	else if (currenStatus == "Draft")
	  	{
	  		var test_row = $(currenRow).find(".k-grid-appr, .k-grid-revw,.k-grid-graph")
	  		$(test_row).hide()
	  	}
	  }
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

	function controlGridTitle()
	{
		$('.k-grid-file').attr('title','File');
		$('.k-grid-appr').attr('title','Approval');
		$('.k-grid-revw').attr('title','Review');
		$('.k-grid-aud').attr('title','Audit');
		$('.k-grid-edit').attr('title','Edit');
		$('.k-grid-graph').attr('title','Dashboard');
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

	$('.cancel-btn1').click(function(){
 		$('#search-value').val('');
 		$("#grid").data("kendoGrid").dataSource.filter({});
 	})

	function search_result()
	{
		var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
		var val = $('#search-value').val();
		$("#grid").data("kendoGrid").dataSource.filter({
			logic  : "or",
			filters: [
			{
				field: "id",
				operator: "contains",
				value   : val
			},
			{
				field: "name",
				operator: "contains",
				value   : val
			},
			{
				field: "owner",
				operator: "contains",
				value   : val
			},
			{
				field: "control_regulation",
				operator: "contains",
				value   : val
			},
			]
		});
	}

});