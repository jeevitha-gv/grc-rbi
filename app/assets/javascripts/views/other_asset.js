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
                field: "status",
                operator: "contains",
                value   : val
            },
            {
                 field: "location",
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
                                    url: "/inventory/other_assets",
                                    dataType: 'json',
                                    type: 'get'
                                },
                                destroy: {
                                           url: function(risk) 
                                                {
                                                    return "/other_assets/" + other_asset.id
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
                   owner: { type: "string" },
                    custodian: {type: "string"},
                    asset_type: {type: "string"},
                    
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
                            field: "owner",
                            title: "Owner"
                        }, {
                            field: "custodian",
                            title: "Custodian"
                        },                    
                        {
                            field: "asset_type",
                            title: "AssetType"
                        },                               
                      { command: [{text: "edit", click: edit_file},{text: "delete", click: delete_file}], title: "Action" }

                        ],
                    });
          

function delete_file(e)
   {
       var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
       if (confirm('Are you sure you want to delete this record ?')) {
               $.ajax({
               url: "/other_assets/"+dataItem.id,
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
        window.location.href = "other_assets/"+ dataItem.assetable_id + "/edit"
    }
});