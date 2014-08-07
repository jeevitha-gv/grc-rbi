                $(document).ready(function () {
                    $("#grid").kendoGrid({
                        dataSource: {
                            transport: {
                                read: {
                                    url: "/contracts",
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
                        { command: [{text: "edit", click: edit_file}], title: "Action" }
                        ],
                    });
                function edit_file(e)
    {
        var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
        window.location.href = "/contracts/"+ dataItem.id + "/edit"
    }
      });
               


