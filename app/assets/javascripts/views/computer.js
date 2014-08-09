                $(document).ready(function () {
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