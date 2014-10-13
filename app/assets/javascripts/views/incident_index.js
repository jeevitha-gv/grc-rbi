

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
   
   $("#btnExport").click(function(e) {

 var dataSource =  $("#grid").data("kendoGrid").dataSource; 
     var filteredDataSource = new kendo.data.DataSource( { 
         data: dataSource.data(), 
         filter: dataSource.filter(),
     }); 

     filteredDataSource.read();
     var data = filteredDataSource.view();

     var result = "data:application/vnd.ms-excel;filename=filename.xls,";

     result += "<table><tr><th>title</th><th>category_id</th><th>request_type_id</th><th>department_id</th><th>team_id</th></tr>";

     for (var i = 0; i < data.length; i++) {
         result += "<tr>";

         result += "<td>";
         result += data[i].title;
         result += "</td>";

         result += "<td>";
         result += data[i].request_type;
         result += "</td>";

         result += "<td>";
         result += data[i].incident_category;
         result += "</td>";

         result += "<td>";
         result += data[i].incident_status;
         result += "</td>";

         result += "<td>";
         result += data[i].team;
         result += "</td>";

         result += "</tr>";
     }

     result += "</table>";

function mains()
{
        var dt = new Date();
        var day = dt.getDate();
        var month = dt.getMonth() + 1;
        var year = dt.getFullYear();
        var hour = dt.getHours();
        var mins = dt.getMinutes();
        var postfix = day + "." + month + "." + year + " " + hour + ":" + mins;
        var a = document.createElement('a');
        var table_div = (document.getElementById('grid').getElementsByTagName('tbody')[0]);
        var table_html = table_div.innerHTML.replace( );
        a.href = result;
        a.download = 'incidentexporteddata@'  +postfix+ '.xls';
        a.click();
}


      var sBrowser, sUsrAg = navigator.userAgent;
        if(sUsrAg.indexOf("Chrome") > -1) {
              mains();
              alert("Chrome Alert");

            } else if (sUsrAg.indexOf("Safari") > -1) {
              mains();
              alert("Safari Alert");

            } else if (sUsrAg.indexOf("Opera") > -1) {
              mains();
              alert("Opera Alert");

            } else if (sUsrAg.indexOf("Firefox") > -1) {
            alert("Firefox Alert");
            // mains();
            window.open(result,'application/vnd.ms-excel', '_blank', 'hida'+ '.xls');
            } else if (sUsrAg.indexOf("MSIE") > -1) {
            alert("MSIE alert");
            mains();
            }
            });



//      if (window.navigator.msSaveBlob) {
// //Internet Explorer
// window.navigator.msSaveBlob(new Blob([result]), 'incident.xls');
//  //window.navigator.msSaveOrOpenBlob(new Blob([result]), 'exporteddata@'  +postfix+ '.xls');
// }
// else if (window.webkitURL != null) {
// var dt = new Date();
//         var day = dt.getDate();
//         var month = dt.getMonth() + 1;
//         var year = dt.getFullYear();
//          var hour = dt.getHours();
//         var mins = dt.getMinutes();
//         var postfix = day + "." + month + "." + year + " " + hour + ":" + mins;
//         var a = document.createElement('a');
//       var table_div = (document.getElementById('grid').getElementsByTagName('tbody')[0]);
//        var table_html = table_div.innerHTML.replace( );
//      a.href = result;
//               a.download = 'incidentexporteddata@'  +postfix+ '.xls';
//            a.click();
         
//          }
// else {
//  alert(1111111111111111111111);
//  window.open(result);
// }
// });

// if (window.navigator.msSaveBlob) {
// //Internet Explorer
// window.navigator.msSaveBlob(new Blob([result]), 'incident.xls');
//  //window.navigator.msSaveOrOpenBlob(new Blob([result]), 'exporteddata@'  +postfix+ '.xls');
// }
// else if (window.webkitURL != null) {
// //Google Chrome and Mozilla Firefox
// var a = document.createElement('a');
// result = encodeURIComponent(result);
// a.href = 'data:application/vnd.ms-excel;charset=UTF-8,' + result;
// a.download = 'ExportedKendoGrid.xls';
// a.click();
// }
// else {
// //Everything Else
// alert(1111111111111111111111);
// window.open(result);
// }
// e.preventDefault();
// });

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

// function select_grid(tabActive)
//     {
//       if(tabActive == 'tabstrip-1')
//       {
//         return "gridforall";
//       }
//       else if(tabActive == 'tabstrip-2')
//       {
//         return "gridforplan";
//       }
//       else if(tabActive=='tabstrip-3')
//       {
//         return "gridforprogress";
//       }
//       else if(tabActive=='tabstrip-4')
//       {
//         return "gridforpublish";
//       }
//     }


// });

  function modify(){
    $('.editable-input').val($('.editable-select').val());
    output();
  } 

  function output(){
    $('.editable-result').text('value: ' + $('.editable-input').val());
  }

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
  function closure_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id + "/closes/new"
  }
  // function graph_file(e)
  // {
  //   var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
  //   window.location.href = "/risks/"+ dataItem.id + "/risk_per_dashboard"
  // }


  function select_stage_class(stage_class)
  {
    if(stage_class == 'evaluate')
    {
      return "k-grid-list";
    }
    else if(stage_class == 'resolution')
    {
      return "k-grid-miti, .k-grid-list";
    }
    else if(stage_class == 'close')
    {
      return "k-grid-miti, .k-grid-list, .k-grid-graph";
    }
  }

  function updateGridForStage(stage)
  {
    alert(stage.length);
    if(stage.length == 0)
    {
      status_update_all()
    }
    else
    {
      var selected_stage = select_stage_class(stage)
      $('.'+selected_stage).addClass('active');
    }
  }

  function status_update_all()
  {
    var grid = $("#grid").data("kendoGrid");
    addGridAtiveClass(grid)
  }

  function addGridAtiveClass(grid)
  {
    var gridData = grid.dataSource.view();
    for (var i = 0; i < gridData.length; i++) {
      var currentUid = gridData[i].uid;
      var currenRow = grid.table.find("tr[data-uid='" + currentUid + "']");
      currenStatus = gridData[i].incident_status
      if (currenStatus == "New")
      {
        var test_row = $(currenRow).find(".k-grid-list")
        $(test_row).addClass('active')
      }
      // else if (currenStatus == "Completed" || currenStatus == "Closed")
      // {
      //   var test_row = $(currenRow).find(".k-grid-list, .k-grid-miti")
      //   $(test_row).addClass('active')
      // }
      //else if (currenStatus == "Draft")
         else  (currenStatus == "Draft")
      {
        var test_row = $(currenRow).find(".k-grid-list, .k-grid-miti")
        alert(5555555555555555);
        $(test_row).hide()
      }
    }
  }
  

  $('.editable-input').on('click', function(){
    $(this).select()
      }).on('blur', function(){
    output();
  })

  modify();

  // More contacts show
  $(".more-link").click(function(){
    if($(this).html() == "More")
      $(this).html("Less").parent().siblings(".more-info").show();
    else
      $(this).html("More").parent().siblings(".more-info").hide();
  });

  function incidentGridTitle()
  {
    $('.k-grid-file').attr('title','File');
    $('.k-grid-list').attr('title','evaluate');
    $('.k-grid-miti').attr('title','resolution');
    $('.k-grid-graph').attr('title','close');
    $('.k-grid-edit').attr('title','edit');
    //$('.k-grid-graph').attr('title','Dashboard');
  }

  function adavance_search()
  {
    //alert(1111111);
      var title = $("#title").val();
      var category_id = $("#category_id").val();
      var request_type_id = $("#request_type_id").val();
      var department_id = $("#department_id").val();
      var team_id = $("#team_id").val();
      var incidents_url = "/incidents?title="+title+"&"+"category_id="+category_id+"&"+"request_type_id="+request_type_id+"&"+"department_id="+department_id+"&"+"team_id="+ team_id
  
   function pdf_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id +".pdf"
  }

  dataSource = new kendo.data.DataSource({
    transport: {
      read: {
        url: incidents_url,
        dataType: 'json',
        type: "get"
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

    $("#grid").kendoGrid({
    dataSource: dataSource,
    dataBound: function(){

      //updateGridForStage(stage)
      incidentGridTitle()
    },
    height: 'auto',
    scrollable: true,
    sortable: true,
    filterable: true,
    pageable: true,
    columns: [
      { field: "title", title: "Title" ,width: "35%"},
        { field: "request_type", title: "Type", width: "35%" },
        { field: "incident_category", title: "Category", width: "35%" },
        { field: "incident_status", title: "Status", width: "35%" },
        { field: "team", title: "Team", width: "35%" },
      { command: [{text: "list", click:evaluate_file },{text: "miti", click: resolution_file},{text: "graph", click: closure_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Action", width: "200px" }
    ],
  //~ editable: "popup"
  });

  }

  $(document).ready(function(){

  Top_postion = $(window).scrollTop();

  $( ".user_login" ).mouseenter(function() {
    $(this).addClass("active");
    $(".account_header_dropdown").slideDown(100);
  })
  .mouseleave(function() {
    $(this).removeClass("active");
    $(".account_header_dropdown").hide();
  });

// if ( stage.length > 0 )
//   {
//     var incidents_url = "/incidents/incident_all?stage="+stage;
//   }
//   else
//   {
//     var incidents_url = "/incidents/incident_all"
//   }


    var incidents_url = "/incidents"
  
 

  dataSource = new kendo.data.DataSource({
    transport: {
      read: {
        url: incidents_url,
        dataType: 'json',
        type: "get"
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
      incidentGridTitle()
    },
    height: 'auto',
    scrollable: true,
    sortable: true,
    filterable: true,
    pageable: true,
    columns: [
      { field: "title", title: "Title" ,width: "35%"},
        { field: "request_type", title: "Type", width: "35%" },
        { field: "incident_category", title: "Category", width: "35%" },
        { field: "incident_status", title: "Status", width: "35%" },
        { field: "team", title: "Team", width: "35%" },
      { command: [{text: "list", click:evaluate_file },{text: "miti", click: resolution_file},{text: "graph", click: closure_file},{text: "pdf", click: pdf_file},{text: "edit", click: edit_file}], title: "Action", width: "200px" }
    ],
  //~ editable: "popup"
  });



// function onActivate(e) {
  // if($('#search-value').val() != "")
  // {
  //   $('#search-value').val('')
  //   $("#grid").data("kendoGrid").dataSource.filter({});
  //   }
  // }

  // $("#tabstrip").kendoTabStrip({
  //   activate: onActivate
  // });

  // $("#search-button").click(function(){
  //   search_result();
  // })




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
  function closure_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id + "/closes/new"
  }
  function pdf_file(e)
  {
    var dataItem = this.dataItem(jQuery(e.currentTarget).closest("tr"));
    window.location.href = "/incidents/"+ dataItem.id +".pdf"
  }
  // function graph_file(e)

// function onActivate(e) {
  // if($('#search-value').val() != "")

  // {
  //   $('#search-value').val('')
  //   $("#grid").data("kendoGrid").dataSource.filter({});
  //   }
  // }

  // $("#tabstrip").kendoTabStrip({
  //   activate: onActivate
  // });

  // $("#search-button").click(function(){
  //   search_result();
  // })

  // $("#search-value").on('keyup', function(e) {
  //   if (e.which == 13) {
  //     e.preventDefault();
  //     search_result()
  //   }
  // });

  // $('.cancel-btn1').click(function(){
  //   $('#search-value').val('');
  //   $("#grid").data("kendoGrid").dataSource.filter({});
  // })

  // function search_result()
  // {
  //   var tabstrip = $("#tabstrip").kendoTabStrip().data("kendoTabStrip");
  //   var val = $('#search-value').val();
  //   $("#grid").data("kendoGrid").dataSource.filter({
  //     logic  : "or",
  //     filters: [
  //     {
  //       field: "title",
  //       operator: "contains",
  //       value   : val
  //     },
  //     {
  //       field: "request_type",
  //       operator: "contains",
  //       value   : val
  //     },
  //     {
  //       field: "incident_category",
  //       operator: "contains",
  //       value   : val
  //     },
  //     {
  //       field: "incident_status",
  //       operator: "contains",
  //       value   : val
  //     },
  //     {
  //       field: "team",
  //       operator: "contains",
  //       value   : val
  //     },
  //     ]
  //   });
  // }





  function riskGridTitle()
  {
    $('.k-grid-file').attr('title','File');
    $('.k-grid-list').attr('title','Evaluate');
    $('.k-grid-miti').attr('title','Resolution');
    $('.k-grid-graph').attr('title','Close');
    $('.k-grid-edit').attr('title','edit');
    $('.k-grid-pdf').attr('title','PDF');
    //$('.k-grid-graph').attr('title','Dashboard');
  }




});