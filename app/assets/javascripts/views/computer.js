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
            {
                 field: "technical_contact",
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
                                    url: "/computers",
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
                    name: { type: "string" },
                    status: { type: "string" },
                    location: {type: "string"},
                    technical_contact: {type: "string"},
                    
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
                            field: "status",
                            title: "Status"
                        }, {
                            field: "location",
                            title: "Location"
                        }, {
                            field: "technical_contact",
                            title: "Technical Contact"
                        },
                      { command: [{text: "edit", click: edit_file}], title: "Action" }

                        ],
                    });
          

function edit_file(e)
    {
        var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
        window.location.href = "/computers/"+ dataItem.id + "/edit"
    }
      });