// Kendo Tab
  $("#tabstrip").kendoTabStrip({
    animation:  {
      open: {
        effects: "fadeIn"
      }
    }
  });

 $(document).ready(function(){

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

  $("#tabstrip").kendoTabStrip({
    activate: onActivate
  });

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
    var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
    var tabActive = tabstrip.tabGroup.children("li.k-state-active").attr("aria-controls")
    var val = $('#search-value').val();
    var gridForSearch = select_grid(tabActive)
    $("#"+gridForSearch).data("kendoGrid").dataSource.filter({
      logic  : "or",
      filters: [
        {
          field: "title",
          operator: "contains",
          value   : val
        },
        {
          field: "request_type",
          operator: "contains",
          value   : val
        },
        {
          field: "incident_category",
          operator: "contains",
          value   : val
        },
        {
          field: "incident_status",
          operator: "contains",
          value   : val
        },
        {
          field: "team",
          operator: "contains",
          value   : val
        },
      ]
    });
  }
});













$(document).ready(function() {
  // Fancybox
  $(".fancybox").fancybox();

  // Kendo Datapicker
  $("#datepicker").kendoDatePicker();

  // Kendo Tab
  $("#tabstrip").kendoTabStrip({
    animation:  {
      open: {
        effects: "fadeIn"
      }
    }
  });

  //Kendo Panel
  $("#panelbar").kendoPanelBar();


  
    var incidents_url = "/incidents"
 

  dataSource = new kendo.data.DataSource({
    transport: {
      read: {
        url: incidents_url,
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
         title: { type: "string"},
          request_type: { type: "string"},
          incident_category: { type: "string"},
          incident_status: { type: "string"},
          team: { type: "string"},
        },
      },
    },
  });

  // Kendo Grid
  $("#grid").kendoGrid({
    dataSource: dataSource,
    dataBound: function(){
      //updateGridForStage(stage)
      riskGridTitle()
    },
    height: 'auto',
    scrollable: true,
    sortable: true,
    filterable: true,
    pageable: false,
    columns: [
      { field: "title", title: "Title" ,width: "35%"},
        { field: "request_type", title: "Type", width: "35%" },
        { field: "incident_category", title: "Category", width: "35%" },
        { field: "incident_status", title: "Status", width: "35%" },
        { field: "team", title: "Team", width: "35%" },
      { command: [{text: "list", click:evaluate_file },{text: "miti", click: resolution_file},{text: "edit", click: edit_file}], title: "Action", width: "200px" }
    ],
  //~ editable: "popup"
  });

  // function modify(){
  //   $('.editable-input').val($('.editable-select').val());
  //   output();
  // }

  // function output(){
  //   $('.editable-result').text('value: ' + $('.editable-input').val());
  // }

  function edit_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id + "/edit"
  }
  function evaluate_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id + "/evaluates/new"
  }

  function resolution_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id + "/resolutions/new"
  }
  // function graph_file(e)
  // {
  //   var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  //   window.location.href = "/risks/"+ dataItem.id + "/risk_per_dashboard"
  // }


  // function select_stage_class(stage_class)
  // {
  //   if(stage_class == 'mitigate')
  //   {
  //     return "k-grid-list";
  //   }
  //   else if(stage_class == 'review')
  //   {
  //     return "k-grid-miti, .k-grid-list";
  //   }
  // }

  // function updateGridForStage(stage)
  // {
  //   if(stage.length == 0)
  //   {
  //     status_update_all()
  //   }
  //   else
  //   {
  //     var selected_stage = select_stage_class(stage)
  //     $('.'+selected_stage).addClass('active');
  //   }
  // }

  // function status_update_all()
  // {
  //   var grid = $("#grid").data("kendoGrid");
  //   addGridAtiveClass(grid)
  // }

  // function addGridAtiveClass(grid)
  // {
  //   var gridData = grid.dataSource.view();
  //   for (var i = 0; i < gridData.length; i++) {
  //     var currentUid = gridData[i].uid;
  //     var currenRow = grid.table.find("tr[data-uid='" + currentUid + "']");
  //     currenStatus = gridData[i].status
  //     if (currenStatus == "Mitigated")
  //     {
  //       var test_row = $(currenRow).find(".k-grid-list")
  //       $(test_row).addClass('active')
  //     }
  //     else if (currenStatus == "Reviewed" || currenStatus == "Rejected")
  //     {
  //       var test_row = $(currenRow).find(".k-grid-list, .k-grid-miti")
  //       $(test_row).addClass('active')
  //     }
  //     else if (currenStatus == "Draft")
  //     {
  //       var test_row = $(currenRow).find(".k-grid-list, .k-grid-miti,.k-grid-graph")
  //       $(test_row).hide()
  //     }
  //   }
  // }

  // $('.editable-input').on('click', function(){
  //   $(this).select()
  //     }).on('blur', function(){
  //   output();
  // })

  //modify();

  // More contacts show
  $(".more-link").click(function(){
    if($(this).html() == "More")
      $(this).html("Less").parent().siblings(".more-info").show();
    else
      $(this).html("More").parent().siblings(".more-info").hide();
  });

  function riskGridTitle()
  {
    $('.k-grid-file').attr('title','File');
    $('.k-grid-list').attr('title','Evaluate');
    $('.k-grid-miti').attr('title','Resolution');
    $('.k-grid-edit').attr('title','edit');
    //$('.k-grid-graph').attr('title','Dashboard');
  }

  function onActivate(e) {
  if($('#search-value').val() != "")
  {
    $('#search-value').val('')
    $("#grid").data("kendoGrid").dataSource.filter({});
    }
  }

  $("#tabstrip").kendoTabStrip({
    activate: onActivate
  });

  $("#search-button").click(function(){
    search_result();
  })

  $("#search-value").on('keyup', function(e) {
    if (e.which == 13) {
      e.preventDefault();
      search_result()
    }
  });

  $('.cancel-btn1').click(function(){
    $('#search-value').val('');
    $("#grid").data("kendoGrid").dataSource.filter({});
  })

  function search_result()
  {
    var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
    var val = $('#search-value').val();
    $("#grid").data("kendoGrid").dataSource.filter({
      logic  : "or",
      filters: [
      {
        field: "title",
        operator: "contains",
        value   : val
      },
      {
        field: "request_type",
        operator: "contains",
        value   : val
      },
      {
        field: "incident_category",
        operator: "contains",
        value   : val
      },
      {
        field: "incident_status",
        operator: "contains",
        value   : val
      },
      {
        field: "team",
        operator: "contains",
        value   : val
      },
      ]
    });
  }

});