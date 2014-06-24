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

		// Data source for all
		dataSource = new kendo.data.DataSource({
			transport: {
				read: {
					url: "/audits/audit_all",
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

	
	$(document).ready(function(){

	Top_postion = $(window).scrollTop();

	$( ".user_login" ).mouseenter(function() {
		$(this).addClass("active");
		$(".account_header_dropdown").slideDown(100);
	})
	.mouseleave(function() {
		$(this).removeClass("active");
		$(".account_header_dropdown").hide();
	});

  $("#auditees-users option").each(function( index ) {
    var user_value = ($(this).attr('class'))
    if(user_value!=""){$(this).attr('selected', true)}
  });
	
});

  function auditee_add()
	{
    var size = $('#auditee-list').find('.auditee-rows').size();
    $("#auditee-list").append(""+"<div class='form-group clearfix auditee-dropdown'>"+$(".auditee-dropdown").html().replace('audit[audit_auditees_attributes][0][user_id]','audit[audit_auditees_attributes]['+size+'][user_id]')+"</div>"+"")//.replace(, ''); ;
  }

 $(document).ready(function(){
    $("#audit_compliance_type").change(function () {
      $('#standard-compliance  select').attr('name', '');
      $('#standard-topic  select').attr('name', '');
      var getStandardVal = this.value;
      if(getStandardVal == 'Compliance')
        {
          $('#standard-compliance').show();
          $('#standard-compliance  select').attr('name', 'audit[standard_id]');
          $('#standard-topic  select').attr('name', '');
          $('#standard-topic').hide();
        }
        else if(getStandardVal == 'NonCompliance')
        {
          $('#standard-topic').show();
          $('#standard-topic  select').attr('name', 'audit[standard_id]');
          $('#standard-compliance  select').attr('name', '');
          $('#standard-compliance').hide();
        }
        else if(getStandardVal=='')
        {
          $('#standard-compliance').hide();
          $('#standard-topic').hide();
        }
    });

    $(".datepicker").kendoDatePicker({
      format: "dd/MM/yyyy"
    });
    $(".datepicker1").kendoDatePicker({
      format: "dd/MM/yyyy"
    });


    // $('#add_auditee').click(function(){
    //   var size = $('#auditee-list').find('.auditee-rows').size();

    //   // console.log(cd append)
    //   $("#auditee-list").append(""+"<div class='form-group clearfix auditee-dropdown'>"+$(".auditee-dropdown").html().replace('audit[audit_auditees_attributes][0][user_id]','audit[audit_auditees_attributes]['+size+'][user_id]')+"</div>"+"");
    // });

    $(".next-phase").click(function(){
      // new Messi('Planned for further phases.', {autoclose: '5000'});
      new Messi('Planned for further phases.', {title: 'Warning', titleClass: 'warning', autoclose: 2000});
    });
  });
	
	 function get_departments(element){
    var location_id = $(element).val();
    if(location_id.length>0){
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"location_id" : location_id}
      });
    }
    else{
      $('#department-dropdown').hide();
      $('#teams-dropdown').hide();
    }
  }

  function get_teams(element){
    var department_id = $(element).val();
    if(department_id.length>0){
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"department_id" : department_id}
      });
    }
    else {
      $('#teams-dropdown').hide();
    }
  }

  function get_auditee_users(element){
    var team_id = $(element).val();
    if(team_id.length>0){
      $.ajax({
        url: "/audits/department_teams_users",
        type: "GET",
        data: {"team_id" : team_id}
      });
    }
    else {
      $('#teams-dropdown').hide();
    }
  }