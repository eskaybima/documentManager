var morrisCharts = function() {

    Morris.Line({
      element: 'morris-line-example',
      data: [
        { y: '2006', a: 100, b: 90 },
        { y: '2007', a: 75,  b: 65 },
        { y: '2008', a: 50,  b: 40 },
        { y: '2009', a: 75,  b: 65 },
        { y: '2010', a: 50,  b: 40 },
        { y: '2011', a: 75,  b: 65 },
        { y: '2012', a: 100, b: 90 }
      ],
      xkey: 'y',
      ykeys: ['a', 'b'],
      labels: ['Admitted Boys', 'Admitted Girls'],
      resize: true,
      lineColors: ['#33414E', '#95B75D']
    });


     Morris.Bar({
        element: 'morris-area-example',
        data: [
            { y: 'Pry 1', a: 98, b: 64, c:53, d:30 },
            { y: 'Pry 2', a: 75, b: 65, c:45, d:19 },
            { y: 'Pry 3', a: 83, b: 74, c:57, d:10 },
            { y: 'Pry 4', a: 72, b: 65, c:49, d:37 },
            { y: 'Pry 5', a: 95, b: 67, c:44, d:28 },
            { y: 'Pry 6', a: 89, b: 65, c:51, d:20 }
        ],
        xkey: 'y',
        ykeys: ['a', 'b', 'c', 'd'],
        labels: ['Excellent (100-75)%', 'Good (74-60)%','Average (59-40)%','Below Average (39-0)%'],
        barColors: ['#357EC7', '#33414E','#800080','#95B75D']
    });


    Morris.Bar({
        element: 'morris-bar-example',
        data: [
            { y: '2006', a: 100, b: 90 },
            { y: '2007', a: 75,  b: 65 },
            { y: '2008', a: 50,  b: 40 },
            { y: '2009', a: 75,  b: 65 },
            { y: '2010', a: 50,  b: 40 },
            { y: '2011', a: 75,  b: 65 },
            { y: '2012', a: 100, b: 90 }
        ],
        xkey: 'y',
        ykeys: ['a', 'b'],
        labels: ['Series A', 'Series B'],
        barColors: ['#B64645', '#33414E']
    });


    Morris.Donut({
        element: 'morris-donut-example',
        data: [
            {label: "Download Sales", value: 12},
            {label: "In-Store Sales", value: 30},
            {label: "Mail-Order Sales", value: 20}
        ],
        colors: ['#95B75D', '#3FBAE4', '#FEA223']
    });

}();