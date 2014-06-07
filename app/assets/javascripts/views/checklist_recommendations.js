		function save_draft_checklist()
					{
						var save_draft = $("#save_draft_"+id).val()
						$("#save_draft_"+id).val('true')
					}
					function  control_checklist()
					{
					var recommendation = recommendation()
					var priority = priority()
					var reason = reason()
					var severity = severity()
					var closure_date = closure_date()
					var status = status()
					if (recommendation && priority && reason && severity && closure_date && status)
					{
					return true
					}
				else
				{
				return false
				}
					function recommendation()
					{
					$(".control_recommendation").each(function() {
						var recommendation_value = $(this).val()
						if (recommendation_value == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = true
						}
					});
					return value
					}
					function priority()
					{
					$(".control_priority").each(function() {
						var priority_value = $(this).val()
						if (priority_value == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = true
						}
					});
					return value
					}
					function reason()
					{
					$(".control_reason").each(function() {
						var status_value = $(this).val()
						if (status_value == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = true
						}
					});
					return value
					}
					function severity()
					{
					$(".control_severity").each(function() {
						//~ var recommendation_value = $(this).val()
						if ($(this).val() == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = true
						}
					});
					return value
					}
					function closure_date()
					{
					$(".control_closure_date").each(function() {
						if ($(this).val() == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = true
						}
					});
					return value
					}
					function status()
					{
					$(".control_status").each(function() {
						if ($(this).val() == '')
						{
						$('#'+this.id).addClass("error_input");
						$('#error_'+this.id).show()
						value = false
						}
						else
						{
						$('#'+this.id).removeClass("error_input");
						$('#error_'+this.id).hide()
						value = false
						}
					});
					return value
					}
					}

  $(document).ready(function() {
              // create DatePicker from input HTML element

              $(".datepicker2").kendoDatePicker();

              $(".score_points").click(function(){
								value =$(this).data("value");
								control_id = $(this).attr("id").replace("_"+value,'')
								$("#score_" +control_id).val(value)
                $(".score_points").removeClass('active')
                $(this).addClass('active')
              })     
            });
              
              
	// ajax for submitting the score method
	function save_individual_score(id)
	{
			var control_id = id;
			var checklist_id = $("#checklist_id_"+id).val()
			var recommendation = $("#recommendation_" +id).val()
			var recommendation_priority = $("#recommendation_priority_id_" +id).val()
			var reason = $("#reason_" +id).val()
			var recommendation_severity = $("#recommendation_severity_id_" +id).val()
			var closure_date = $("#closure_date_" +id).val()
			var recommendation_status = $("#recommendation_status_id_" +id).val()
			var recommendation_severity = $("#recommendation_severity_id_" +id).val()
			var score = $("#score_" +id).val()
			$.ajax({
					url: "/checklist_recommendations/update_individual_score",
					type: "POST",
					beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token',jQuery('meta[name="csrf-token"]').attr("content")); },
					data: {'checklist_recommendation[checklist_id]':  checklist_id, 'checklist_recommendation[checklist_type]': "AuditCompliance", 'checklist_recommendation[recommendation]': recommendation, 'checklist_recommendation[reason]': reason, 'checklist_recommendation[closure_date]': closure_date, 'checklist_recommendation[recommendation_priority_id]': recommendation_priority, 'checklist_recommendation[recommendation_severity_id]': recommendation_severity, 'checklist_recommendation[recommendation_status_id]': recommendation_status, 'checklist_recommendation[recommendation_completed]': true , 'checklist_recommendation[score]': score},
					}).done(function() {
					alert("dd")
			});
	} 