$(function () {
	    var  array = $('#chart_sics').data('valuesfc');
	    
	    var cronicx = array[0]
	    var outstandingx = array[1] 	  
        var seriousx = array[2]
        var inconsequentialx = array[3]

        $('#chart_sics').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Historial de enfermedades por diagnóstico'
            },
            subtitle: {
                text: 'Por: IDoctore.com'
            },
            xAxis: {
                categories: ['Diagnostico de enfermedades'],
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Cantidad',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            tooltip: {
                valueSuffix: 'Cantidad de Enfermedades'
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            },
            legend: {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor || '#FFFFFF'),
                shadow: true
            },
            credits: {
                enabled: false
            },
            series: [{
                name: 'Sin Consecuencias',
                data: [inconsequentialx]
            }, {
                name: 'Relevante',
                data: [outstandingx]
            }, {
                name: 'Serio',
                data: [seriousx]
            }, {
            	name: 'Cronico',
                data: [cronicx]

            }]
        });
    });