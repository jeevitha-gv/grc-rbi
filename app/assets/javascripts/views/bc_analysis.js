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
                field: "assetable_type",
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
        ]
    });
}



$("#panelbar").kendoPanelBar();

    if ( stage.length > 0 )
    {
        var bc_analyses_url = "/bcm/bc_analyses?stage="+stage;
    }
    else
    {
        var bc_analyses_url  = "/bcm/bc_analyses"
    }

    dataSource = new kendo.data.DataSource({
        transport: {
            read: {
                url: bc_analyses_url,
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
                    title: { type: "string" },
                    department: {type: "string"},
                    threat: {type: "string"},
                    owner: {type: "string"},
                    
                }
            }
        },
                            // pageSize: 20
                        });


                $("#grid").kendoGrid({
        dataSource: dataSource,
        dataBound: function(){
            updateGridForStage(stage)
            gridTitle()
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
                            field: "title",
                            title: "Title",
                            width: 200
                        }, {
                            field: "department",
                            title: "Department"
                        }, {
                            field: "threat",
                            title: "Threat"
                        }, {
                            field: "owner",
                            title: "Owner "
                        }, 
                       { command: [{text: "tick", click: check_file}, {text: "tick1", click: act_file}, {text: "miti", click: review_file}, {text: "edit", click: main_file},{text: "delete", click: delete_file}], title: "Action" }

                        ],
                    });
function check_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
 window.location.href = "/bcm/bc_analyses/"+ dataItem.id + "/bc_plans/new"
}

function act_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/bcm/bc_analyses/"+ dataItem.id + "/bc_implementations/new"
}

function review_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/bcm/bc_analyses/"+ dataItem.id + "/bc_acceptances/new"
}

function main_file(e)
{
  var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  window.location.href = "/bcm/bc_analyses/"+ dataItem.id + "/bc_maintenances/new"
}
          
function delete_file(e)
   {
       var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
       if (confirm('Are you sure you want to delete this record ?')) {
               $.ajax({
               url: "/computers/"+dataItem.id,
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
        window.location.href = "bc_analyses/"+ dataItem.id + "/edit"
    }function select_stage_class(stage_class)
    {
       if(stage_class == 'evaluate')
      {
        return "k-grid-list";
      }
      else if(stage_class == 'action')
      {
        return "k-grid-miti, .k-grid-list";
      }
      else if(stage_class == 'review')
      {
        return "k-grid-miti, .k-grid-list";
      }
       if(stage_class == 'maintenance')
      {
        return "k-grid-list";
      }
    }

function gridTitle()
{
  $('.k-grid-tick').attr('title','Evaluate');
  $('.k-grid-tick1').attr('title','Act');
  $('.k-grid-miti').attr('title','Review');
  $('.k-grid-edit').attr('title','Edit');
  $('.k-grid-delete').attr('title','Delete');
}
      
});