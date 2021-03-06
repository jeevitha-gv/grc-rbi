$(document).ready(function () {

$('.cancel-btn1').click(function(){
    $('#search-value').val('');
    search_result()
})

function onActivate(e) {
 if($('#search-value').val() != "")
 {
  $('#search-value').val('')
  var tabActive = e.sender.tabGroup.children("li.k-state-active").attr("aria-controls")
  var gridForSearch = select_grid(tabActive)
  $("#"+gridForSearch).data("kendoGrid").dataSource.filter({});
 }
}

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
    var val = $('#search-value').val();
    $("#grid").data("kendoGrid").dataSource.filter({
        logic  : "or",
        filters: [
            {
                field: "name",
                operator: "contains",
                value   : val
            },
            {
                field: "asset_state",
                operator: "contains",
                value   : val
            },
            {
                 field: "owner",
                 operator: "contains",
                 value   : val
            },
            {
                 field: "custodian",
                 operator: "contains",
                 value   : val
            },
            {
                 field: "evaluated",
                 operator: "contains",
                 value   : val
            },            
        ]
    });
}




                    $("#grid").kendoGrid({
                        dataSource: {
                            transport: {
                                read: {
                                    url: "/inventory/information_assets",
                                    dataType: 'json',
                                    type: 'get'
                                },
                                destroy: {
                                           url: function(risk) 
                                                {
                                                    return "/assets/information_assets/" + information_asset.id
                                                },
                                                dataType: "json",
                                                type: "DELETE"
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
                    name: { type: "string" },
                    asset_state: { type: "string" },
                    asset_value: { type: "integer" },
                    owner: {type: "string"},
                    custodian: {type: "string"},
                    evaluated: {type: "string"},
                    
                    //department: {type: "string"}
                }
            }
        },
                            // pageSize: 20
                        },
                        height: 550,
                        groupable: false,
                        sortable: true,
                        pageable: false,
                        //{
                        //     refresh: true,
                        //     pageSizes: true,
                        //     buttonCount: 5
                        // },
                       columns: [{
                            field: "name",
                            title: "Name",
                            width: 200
                        }, {
                            field: "asset_state",
                            title: "Status",
                            width: 120
                        }, {
                            field: "asset_value",
                            title: "Asset Value",
                            width: 120
                        }, {
                            field: "owner",
                            title: "Asset Owner",
                            width: 150
                        }, {
                            field: "custodian",
                            title: "Asset Custodian",
                            width: 150
                        },{
                            field: "evaluated",
                            title: "Evaluator",
                            width: 120
                        },
                      { command: [{text: "tick", click: check_file}, {text: "tick1", click: act_file}, {text: "miti", click: review_file}, {text: "edit", click: edit_file},{text: "delete", click: delete_file}], title: "Action" }

                        ],
                    });

function check_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/assets/"+ dataItem.id + "/assessments/new"
}

function act_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/assets/"+ dataItem.id + "/asset_actions/new"
}

function review_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/assets/"+ dataItem.id + "/asset_reviews/new"
}

function delete_file(e)
{
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    if (confirm('Are you sure you want to delete this record ?')) {
       $.ajax({
           url: "/assets/information_assets/"+dataItem.id,
           type: 'delete',
           dataType: 'json',
           success:function(result){
           }
       });
    }
    $('#grid').data('kendoGrid').dataSource.read();
    $('#grid').data('kendoGrid').refresh();
}

function edit_file(e)
{
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "information_assets/"+ dataItem.assetable_id + "/edit"
}
      
});