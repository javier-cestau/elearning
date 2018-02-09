
document.addEventListener("turbolinks:load", function() {



    function GetMonthsWeeks(months,month_name){

        var month = months[month_name] ;
        var weeks = [];
        $.each(month , function(val){
            weeks.push(val);
        });
        return weeks;
    }

    function GetMonthsWeeksColor(months) {

        var color = [];

        $.each(months.Enero, function(){
            color.push("rgba(120,220,220)");
        });
        $.each(months.Febrero, function(week,val){
            color.push("rgba(220,120,220)");
        });
        $.each(months.Marzo, function(week,val){
            color.push("rgba(220,220,120)");
        });

        $.each(months.Abril, function(week,val){
            color.push("rgba(120,120,220)");
        });
        $.each(months.Mayo, function(week,val){
            color.push("rgba(220,180,10)");
        });
        $.each(months.Junio, function(week,val){
            color.push("rgba(20,220,2)");
        });
        $.each(months.Julio, function(week,val){
            color.push("rgba(245,0,0)");
        });
        $.each(months.Agosto, function(week,val){
            color.push("rgba(220,150,0)");
        });
        $.each(months.Septiembre, function(week,val){
            color.push("rgba(120,120,120)");
        });

        $.each(months.Octubre, function(week,val){
            color.push("rgba(22,22,22)");
        });

        $.each(months.Noviembre, function(week,val){
            color.push("rgba(2,30,220)");
        });

        $.each(months.Diciembre, function(week,val){
            color.push("rgba(20,70,125)");
        });

        return color;
    }

    function GetMonthsWeeksValue(months){

        var weeks = [];

        $.each(months.Enero, function(week,val){
            weeks.push(val);
        });
        $.each(months.Febrero, function(week,val){
            weeks.push(val);
        });
        $.each(months.Marzo, function(week,val){
            weeks.push(val);
        });

        $.each(months.Abril, function(week,val){
            weeks.push(val);
        });
        $.each(months.Mayo, function(week,val){
            weeks.push(val);
        });
        $.each(months.Junio, function(week,val){
            weeks.push(val);
        });
        $.each(months.Julio, function(week,val){
            weeks.push(val);
        });
        $.each(months.Agosto, function(week,val){
            weeks.push(val);
        });
        $.each(months.Septiembre, function(week,val){
            weeks.push(val);
        });

        $.each(months.Octubre, function(week,val){
            weeks.push(val);
        });

        $.each(months.Noviembre, function(week,val){
            weeks.push(val);
        });

        $.each(months.Diciembre, function(week,val){
            weeks.push(val);
        });

        return weeks;
    }

    function GetInfoFromServerByWeek(){


        var url = '/admin/courses/enroll_by_week.json?';

        id_department = $(location).attr('href').split("department=")[1];

        if(id_department !== undefined){
            id_department = id_department.split("&")[0];
            url += "department="+id_department;
        }
        year = $(location).attr('href').split("year=")[1];
        year = year.split("&")[0];
        url += "&year="+year;

        $.ajax({
            url : url,
            type : 'get',
            dataType:'json',
            success : function(data) {

                $(".title > h2").remove();
                if(id_department === undefined) {
                    $(".title-report").append("<h2>Usuarios inscritos por semana</h2>");
                }
                else{
                    department_name = $(".department-name").attr("id");
                    $(".title").append("<h2>Usuarios inscritos por semana en el programa <strong>"+department_name+"</strong></h2>");

                }
                $.each(data.data.year, function(index,year_object){
                    $.each(year_object, function(year,months){

                      var weeks,colors,total_user;
                       $.each(months, function(month_name,values){

                         var values_weeks = [];


                         weeks = GetMonthsWeeks(months,month_name);
                         values = months[month_name];

                         colors = GetMonthDaysColor(month_name);
                         total_user = 0;
                          for (var i = 0; i < weeks.length; i++){


                              total_user += values[i+1];
                              values_weeks.push(values[i+1]);
                          }



                          var month = months[month_name] ;


                          $("#total-users"+month_name).append("<h5> Total de usuarios inscritos: "+total_user+"</h5>");
                          CreateTableData(month_name,weeks,colors,values_weeks,"bar","Cantidad de empleados","Semanas");


                      });

                    });
                });

            },
            error : function(request,error)
            {
                console.log(request);
            }
        });

    }


    function GetMonthsDaysValue(values){
      var container = [];

      $.each(values, function(day,value){

        container.push(value);
      });
      return container;

    }

    function GetMonthDaysColor(month_name){

      var color = "";
      switch (month_name) {
        case "Enero":
          color = "rgba(120,220,220)";
          break;
        case "Febrero":
          color = "rgba(220,120,220)";

          break;
        case "Marzo":
          color = "rgba(220,220,120)";

          break;
        case "Abril":
          color = "rgba(120,120,220)";

          break;
        case "Mayo":
          color = "rgba(220,180,10)";

          break;
        case "Junio":
          color = "rgba(20,220,2)";

          break;
        case "Julio":
          color = "rgba(245,0,0)";

          break;
        case "Agosto":
          color = "rgba(220,150,0)";

          break;
        case "Septiembre":
          color = "rgba(120,120,120)";

          break;
        case "Octubre":
          color = "rgba(22,22,22)";

          break;

        case "Noviembre":
          color = "rgba(2,30,220)";

          break;
        case "Diciembre":
          color = "rgba(20,70,125)";

          break;
        default:

      }
      return color;
    }

    function GetMonthsDays(values){
      var container = [];

      $.each(values, function(day,value){
        container.push(day);
      });

      return container;

    }

    function GetInfoFromServerByDay(){


              var url = '/admin/courses/enroll_by_day.json?';

              id_department = $(location).attr('href').split("department=")[1];

              if(id_department !== undefined){
                  id_department = id_department.split("&")[0];
                  url += "department="+id_department;
              }

              year = $(location).attr('href').split("year=")[1];
              year = year.split("&")[0];
              url += "&year="+year;

              $.ajax({

                  url : url,
                  type : 'get',
                  dataType:'json',
                  success : function(data) {


                      $(".title > h2").remove();
                      if(id_department === undefined) {
                          $(".title-report").append("<h2 class='align-text'>Usuarios inscritos por día en el "+year+"</h2>");
                      }
                      else{
                          department_name = $(".department-name").attr("id");
                          $(".title-report").append("<h2>Usuarios inscritos por día en el programa <strong>"+department_name+"</strong></h2>");

                      }

                      $.each(data.data.year, function(index,year_object){
                          $.each(year_object, function(year,months){
                            $.each(months, function(month_name,values){

                              var days = GetMonthsDays(values);
                              var values_days = GetMonthsDaysValue(values);
                              var color = GetMonthDaysColor(month_name);
                              var total_user = 0;


                              for (var i = 0; i < values_days.length; i++) {
                                total_user += values_days[i];
                              }

                              $("#total-users"+month_name).append("<h5> Total de usuarios inscritos: "+total_user+"</h5>");

                              CreateTableData(month_name,days,color,values_days, "bar", "Cantidad de empleados","Días");

                            });
                          });
                      });

                  },
                  error : function(request,error)
                  {
                      console.log(request);
                  }
              });

    }


    function GetInfoFromServerByMonth(){


              var url = '/admin/courses/enroll_by_month.json?';

              id_department = $(location).attr('href').split("department=")[1];

              if(id_department !== undefined){
                  id_department = id_department.split("&")[0];
                  url += "department="+id_department;
              }

              year = $(location).attr('href').split("year=")[1];
              year = year.split("&")[0];
              url += "&year="+year;

              $.ajax({

                  url : url,
                  type : 'get',
                  dataType:'json',
                  success : function(data) {


                      $(".title > h2").remove();
                      if(id_department === undefined) {
                          $(".title-report").append("<h2>Usuarios inscritos por mes</h2>");
                      }
                      else{
                          department_name = $(".department-name").attr("id");
                          $(".title-report").append("<h2>Usuarios inscritos por día en el programa <strong>"+department_name+"</strong></h2>");

                      }

                      $.each(data.data.year, function(index,year_object){
                          $.each(year_object, function(year,months){
                            var months_name = [],values_months = [];
                            var  color = []   , total_user;

                            $.each(months, function(month_name,values){
                              months_name.push(month_name);

                              values_months.push(values);
                              color.push(GetMonthDaysColor(month_name));
                              total_user = 0;

                              for (var i = 0; i < values_months.length; i++) {
                                total_user += values_months[i];
                              }



                            });

                            $("#total-users"+year).append("<h5> Total de usuarios inscritos: "+total_user+"</h5>");

                            CreateTableData(year,months_name,color,values_months, "horizontalBar","Meses","Cantidad de empleados");

                          });
                      });

                  },
                  error : function(request,error)
                  {
                      console.log(request);
                  }
              });

    }

    function CreateTableData(id_chart,data_label,color,data_values, bar, yString,xString){

      if(bar == "horizontalBar")
      {
        $(".chartAreaWrapper2").css({ "height": "550px"});

      }
      var ctx = document.getElementById("myChart"+id_chart).getContext("2d");
      var chart = {

          options: {
            legend: {
                  display: false
              },
              scales: {
                  xAxes: [{
                      scaleLabel: {
                        display: true,
                        labelString: xString,
                        fontSize: 16

                      },
                      ticks: {

                          fontSize: 16
                      }
                  }],

                  yAxes: [{
                      scaleLabel: {
                        display: true,
                        labelString: yString,
                        fontSize: 16

                      },
                      ticks: {
                        userCallback: function(label, index, labels) {
                             // when the floored value is the same as the value we have a whole number
                             if (Math.floor(label) === label) {
                                 return label;
                             }

                         },
                        min: 0 ,
                        fontSize: 16
                      }
                  }]
              },
              responsive: true,
              maintainAspectRatio: false,
              animation: {

                  onComplete: function(animation) {
                      var sourceCanvas = myLiveChart.chart.canvas;
                      var copyWidth = myLiveChart.scales['y-axis-0'].width - 10;
                      var copyHeight = myLiveChart.scales['y-axis-0'].height + myLiveChart.scales['y-axis-0'].top + 10;
                  }
              }
          },
          type: bar,
          data: {
              labels: data_label,

              datasets: [
                  {
                      fillColor: "rgba(220,220,220,0.2)",
                      strokeColor: "rgba(220,220,220,1)",
                      pointColor: "rgba(220,220,220,1)",
                      backgroundColor: color,
                      pointStrokeColor: "#fff",
                      pointHighlightFill: "#fff",
                      pointHighlightStroke: "rgba(220,220,220,1)",
                      data: data_values
                  }
              ]
          }};

      var myLiveChart = new Chart(ctx, chart);
    }

    if(PageFile == 7){

      if($("#day").hasClass("red")){
        GetInfoFromServerByDay();
      }
      else{

        if($("#month").hasClass("red")){
          GetInfoFromServerByMonth();
        }
        else{
          GetInfoFromServerByWeek();

        }

      }


    }
});
