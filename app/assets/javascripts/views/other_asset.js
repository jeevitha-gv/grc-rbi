                $(document).ready(function () {
                    $("#grid").kendoGrid({
                        dataSource: {
                            transport: {
                                read: {
                                    url: "/other_assets",
                                    dataType: 'json',
                                    type: 'get'
                                },
                            },
                            autoSync: true,
                            schema: {
            errors: function(response) {
            return response.errors;
        },
        data: "data",
        model: {
            id: "id",
                fields: {
                    name: { type: "string", editable:true},
                    status: { type: "string" },
                    user: {type: "string"},
                    owner: {type: "string"},
                    location: {type: "string"}
                    //department: {type: "string"}
                }
            }
        },
                            // pageSize: 2
                        },
                        height: 550,
                        groupable: false,
                        // scrollable: true,
                        sortable: true,
                        pageable: false,
                        // {
                        //      refresh: true,
                        //      pageSizes: true,
                        //     buttonCount: 5
                        //  },
                       columns: [{
                            field: "name",
                            title: "Name",
                            width: 200
                        }, {
                            field: "status",
                            title: "Status"
                        }, {
                            field: "owner",
                            title: "Company Owner"
                        }, {
                            field: "user",
                            title: "Company User"
                        },{
                            field: "location",
                            title: "Location"
                        }],
                        
                    });
                });


