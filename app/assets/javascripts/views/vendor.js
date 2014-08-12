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
                field: "reseller_type",
                operator: "contains",
                value   : val
            },
            {
                 field: "contact_name",
                 operator: "contains",
                 value   : val
            },
            {
                 field: "contact_email",
                 operator: "contains",
                 value   : val
            },
            {
                 field: "city",
                 operator: "contains",
                 value   : val
            },
            
        ]
    });
}
                    $("#grid").kendoGrid({
                        dataSource: {
                            transport: {
                                read:
                                  {
                                     url: "/vendors",
                                     dataType: 'json',
                                    type: 'get'
                                 },
                            
                             // {
                             //        url: crudServiceBaseUrl + "/vendors",
                             //        dataType: "json"
                             //    },
                                 // update: {
                                 //     url:  "/vendors/update",
                                 //     dataType: "json"
                                 //     type: 'get'
                                 // },
                             //    create: {
                             //        url: crudServiceBaseUrl + "/vendors/new",
                             //        dataType: "json"
                             //    },
                             //    parameterMap: function(options, operation) {
                             //        if (operation !== "read" && options.models) {
                             //            return {models: kendo.stringify(options.models)};
                             //        }
                             //    }
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
                    reseller_type: { validation: { required: true },type: "string" },
                    contact_name: {type: "string"},
                    contact_email: {type: "string"},
                    city: {type: "string"},
                    
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
                            Model: 200
                        }, {
                            field: "reseller_type",
                            title: "Reseller"
                        }, {
                            field: "contact_name",
                            title: "Contact Name"
                        }, {
                            field: "contact_email",
                            title: "Contact Email"
                        },{
                            field: "city",
                            title: "City"
                        },
                        // { command: ["edit", "destroy"], title: "Action", width: "200px" }
                        { command: [{text: "edit", click: edit_file}], title: "Action" }
                        ],
                       // editable: "popup"
                    });
                function edit_file(e)
    {
        var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
        window.location.href = "/vendors/"+ dataItem.id + "/edit"
    }

     function delete_file(e)
    {
        var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
        window.location.href = "/vendors/"+ dataItem.id + "/delete"
    }
      });
               


