                $(document).ready(function () {
                    $("#grid").kendoGrid({
                        dataSource: {
                            transport: {
                                read: {
                                    url: "/mobile_assets",
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
                    model: { type: "string" },
                    manufacturer: { type: "string" },
                    service_provider: {type: "string"},
                    device_type: {type: "string"},
                    
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
                            field: "model",
                            title: "width",
                            Model: 200
                        }, {
                            field: "manufacturer",
                            title: "Manufacturer"
                        }, {
                            field: "service_provider",
                            title: "Provider"
                        }, {
                            field: "device_type",
                            title: "Device Type"
                        },]
                    });
                });


