                $(document).ready(function () {
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
               


