document.addEventListener("turbolinks:load", function(){



  var html;
  var color_courses = new Array([]);
  var label_courses = new Array([]);
  var counter_courses = new Array([]);
  var counter_courses_department = new Array([]);

  function InitializeComponents(){

    ProgressCoursesGeneral();
    ProgressCoursesByDepartment();
    GetCourses();
    GetCoursesByDepartment();


  }

  function GetCourses(){
    label_courses[0]= "Cursos aprobados";
    label_courses[1]= "Cursos reprobados";
    color_courses[0]= "rgba(0,0,255,100)";
    color_courses[1]= "rgba(255,10,0,100)";
    counter_courses[0]= $('#myChart_courses').attr("approved");
    counter_courses[1]= $('#myChart_courses').attr("reprobed");
    CreateTableDataCourses(label_courses, color_courses, counter_courses, "doughnut", "myChart_courses" );

  }

  function GetCoursesByDepartment(){
    label_courses[0]= "Cursos aprobados";
    label_courses[1]= "Cursos reprobados";
    color_courses[0]= "rgba(0,0,255,100)";
    color_courses[1]= "rgba(255,10,0,100)";
    counter_courses_department[0]= $('#myChart_courses_department').attr("approved");
    counter_courses_department[1]= $('#myChart_courses_department').attr("reprobed");
    console.log(label_courses);
    console.log(color_courses);
    console.log(counter_courses);
    CreateTableDataCourses(label_courses, color_courses, counter_courses_department, "doughnut", "myChart_courses_department" );

  }

  function CreateTableDataCourses( label_courses, color_courses, counter_courses, bar, id){

    var ctx = document.getElementById(id).getContext("2d");
    var chart = {

        options: {

            responsive: true,
            maintainAspectRatio: false

        },
        type: bar,
        data: {
            labels: label_courses,

            datasets: [
                {
                    // fillColor: "rgba(220,220,220,0.2)",
                    // strokeColor: "rgba(220,220,220,1)",
                    // pointColor: "rgba(220,220,220,1)",
                    backgroundColor: color_courses,

                    data: counter_courses
                }
            ]
        }};

    var myLiveChart = new Chart(ctx, chart);
  } //fin del function CreateTableDataCourses









  function ProgressCoursesGeneral(){

    $('#approved_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/approved_courses_general',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);
        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#approved_general).click(function)



    $('#reprobed_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/reprobed_courses_general',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);
        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#reprobed_general).click(function)



    $('#finished_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/finished_courses_general',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#finished_general).click(function)



    $('#enrolled_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/enrolled_courses_general',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#enrolled_general).click(function)



    $('#favorite_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/favorite_courses_general',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#favorite_general).click(function)



    $('#categories_general').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/categories_talent',
        type : 'get',
        dataType: 'json',
        success : function(data) {
           let courses = "<div class='anterior'> <canvas id='myChart' width='850px' height='320px'></canvas></div>";
           $("#option").append(courses);
           GetCategories(data);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#categories_general).click(function)



  } // fin del function ProgressCoursesGeneral


  function ProgressCoursesByDepartment(){


    $('#approved_by_department').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/approved_courses_by_department',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#approved_by_department).click(function)




    $('#reprobed_by_department').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/reprobed_courses_by_department',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#reprobed_by_department).click(function)




    $('#finished_by_department').click(function(){
      talent_id = $(this).attr("value");
        $("#option > .anterior").remove();

      $.ajax({
        url : '/admin/talents/'+talent_id+'/talent_progress/finished_courses_by_department',
        type : 'get',
        dataType: 'html',
        success : function(data) {
           let courses = "<div class='anterior'>"+data;
           $("#option").append(courses);

        },
        error : function(request,error){
          console.log(request);
          console.log(error);
        }// fin del error function
      }); //fin del ajax

    }); // fin del $(#finished_by_department).click(function)



        $('#enrolled_by_department').click(function(){
          talent_id = $(this).attr("value");
            $("#option > .anterior").remove();

          $.ajax({
            url : '/admin/talents/'+talent_id+'/talent_progress/enrolled_courses_by_department',
            type : 'get',
            dataType: 'html',
            success : function(data) {
               let courses = "<div class='anterior'>"+data;
               $("#option").append(courses);

            },
            error : function(request,error){
              console.log(request);
              console.log(error);
            }// fin del error function
          }); //fin del ajax

        }); // fin del $(#enrolled_by_department).click(function)


  } // fin del function ProgressCoursesByDepartment


  function GetCategories(data){
    var all_categories = $('#option').attr("value");
    var category = new Array;
    var counter = new Array;
    var color = new Array;
    var trending_counter = 0;
    var MessageTrending = "";

    for (i = 0 ; i< all_categories; i++) {
       category[i] = data["data"][i][0];
       counter[i] = data["data"][i][1];

	if (counter[i] > trending_counter){
         trending_counter = counter[i];
         MessageTrending = "<div class= 'anterior align-text'>"+
                           "<br>"+
                           "<h5> El usuario muestra mayor interés por categorías como: </h5>"+
                           "<br>";
       }

       color[i] = "rgba("+20*i+","+10*i+","+46*i+")";

    }


    for (i= 0; i< all_categories; i++){




      if (counter[i] == trending_counter && trending_counter > 0)  {

        MessageTrending = MessageTrending +"<h6>"+ category[i]+ "</h6><br>";

      }

    }


      CreateTableDataCategories(category, color, counter, "bar");
      $("#option").append(MessageTrending+"</div>");


  }





  function CreateTableDataCategories( category_name, color, counter, bar){

    var ctx = document.getElementById("myChart").getContext("2d");
    var chart = {

        options: {
          legend: {
                display: false
            },
            scales: {
                xAxes: [{
                  scaleLabel: {
                      display: true,
                      labelString: 'Categorías',
                      fontSize: 14
                    },
                    ticks: {

                        fontSize: 16,

                    }
                }],

                yAxes: [{
                  scaleLabel: {
                      display: true,
                      labelString: 'Cantidad de cursos',
                      fontSize: 14
                    },
                    ticks: {
                        fontSize: 20,
                        min: 0,
                        beginAtZero: true,
                        userCallback: function(label, index, labels) {
                             // when the floored value is the same as the value we have a whole number
                             if (Math.floor(label) === label) {
                                 return label;
                             }

                         },
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
            labels: category_name,

            datasets: [
                {
                  //  fillColor: "rgba(220,220,220,0.2)",
                   // strokeColor: "rgba(220,220,220,1)",
                  //  pointColor: "rgba(220,220,220,1)",
                    backgroundColor: color,
                 //   pointStrokeColor: "#fff",
                 //   pointHighlightFill: "#fff",
                 //   pointHighlightStroke: "rgba(220,220,220,1)",
                    data: counter
                }
            ]
        }};

    var myLiveChart = new Chart(ctx, chart);
  } //fin del function CreateTableDataCategories


  if(PageFile == 11)
  {
    InitializeComponents();

  }

}); // fin total
