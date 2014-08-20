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
                field: "contract_type",
                operator: "contains",
                value   : val
            },
            {
                field: "contract_status",
                operator: "contains",
                value   : val
            },
            {
                 field: "name",
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
                                    url: "/contracts",
                                    dataType: 'json',
                                    type: 'get'
                                },
                                destroy: {
                                           url: function(risk) 
                                                {
                                                    return "/contracts/" + contract.id
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
                    contract_type: { type: "string" },
                    contract_status: { type: "string" },
                    name: {type: "string"},
                    location: {type: "string"},
                    
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
                            field: "contract_type",
                            title: "Contract Type",
                            Model: 200
                        }, {
                            field: "contract_status",
                            title: "Contract Status"
                        }, {
                            field: "name",
                            title: "Name"
                        }, {
                            field: "location",
                            title: "Location"
                        },
                        { command: [{text: "edit", click: edit_file},{text: "delete", click: delete_file}], title: "Action" }
                        ],
                    });

   function delete_file(e)
   {
       var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
       if (confirm('Are you sure you want to delete this record ?')) {
               $.ajax({
               url: "/contracts/"+dataItem.id,
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
        window.location.href = "/contracts/"+ dataItem.id + "/edit"
    }
      });
               


