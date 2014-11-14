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
		dataBound: function(){
			riskGridTitle()
		},
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
			{ command: [{text: "show", click: show_file},{text: "miti", click: review_file},{text: "list", click: approve_file},{text: "book", click: publish_file},{text: "edit",  click: edit_file},{ text: "pdf", click: pdf_file },{text: 'share', click: share_file}], title: "Action", width: "85%"  }
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

	function review_file(e)
	{	
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + "/policy_reviews/new"
	}
	function publish_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + "/publish_policies/new"
	}

	function approve_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		window.location.href = "/policies/"+ dataItem.id + "/policy_approvals/new"
	}

	function share_file(e)
	{
		var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
		$('#share_modal').modal({
  			remote: "/policies/share_policy?id=" + dataItem.id
		});
	}

	function riskGridTitle()
	{
		$('.k-grid-show').attr('title','View');
		$('.k-grid-list').attr('title','Approve');
		$('.k-grid-miti').attr('title','Review');
		$('.k-grid-edit').attr('title','Edit');
		$('.k-grid-pdf').attr('title','Report');
		$('.k-grid-book').attr('title','Publish');
		$('.k-grid-share').attr('title','Share');
	}

});

function email_validation()
{
    var email = $('#share_policy_email').val();
    var validate_email = email_validation();
    function email_validation(){
        if (email == '')
        {
            $('#share_policy_email').addClass("error_input");
            $('#email_error').show()
            $('#share_modal').modal('show');
            return false
        }
        else
        {
            $('#share_policy_email').removeClass("error_input");
            $('#email_error').hide()
            $('#share_modal').modal('hide');
            new Messi("Email is Shared successfully", {title: 'Success', titleClass: 'success', autoclose: 1500});
            return true
        }
    }
}
