

document.addEventListener("turbolinks:load", function(){
  if(PageFile == 15)
  {
      InitializeComponents();
  }
});

function InitializeComponents(){

    GetData();

}

function GetData(){

    // guarda un arreglo de 2 posiciones, con un contador para aprobados y otro para reprobados
    var counter_average = new Array;
    var counter_a = 0;
    var counter_r = 0;
    var label = new Array;
    var color = new Array;

    for (i = 0 ; i< gon.counter; i++){

      var actual_grade = gon.dotest[i].grade;

    	 if (actual_grade >= gon.test.min_grade){

    	     counter_a+=1;

    	 } else {
    	     counter_r+=1;
    	 }

    }

    counter_average[0]= counter_a;
    counter_average[1]= counter_r;
    label[0] = "Aprobados";
    label[1] = "Reprobados";
    color[0] = "rgba(0,0,255,100)";
    color[1] = "rgba(255,10,0,100)";


    CreateTableAverage(label,color,counter_average,"horizontalBar");

}

function CreateTableAverage( label_a, color, counter, bar){

    var ctx = document.getElementById("myChartAverage").getContext("2d");
    var chart = {

        options: {
          legend: {
                display: false
            },
            scales: {
                xAxes: [{
                  scaleLabel: {
                      display: true,
                      labelString: 'Cantidad de usuarios',
                      fontSize: 16
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

                    }//tick
                }],

                yAxes: [{
                  scaleLabel: {
                      display: true,
                      labelString: '',
                      fontSize: 16
                    },
                    ticks: {
                        fontSize: 16,
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
            labels: label_a,

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
