$(function () {
    var categories =  $("#history_signs").data('dates_vital_signs');
    var height = $("#history_signs").data('height_vital_signs');
    var weight = $("#history_signs").data('weight_vital_signs');
    var temperature = $("#history_signs").data("temperature_vital_signs");
    var sistolica = $("#history_signs").data("sistolica");
    var diastolica = $("#history_signs").data("diastolica");

    $('#history_signs').highcharts({
        chart: {
            type: 'area'
        },
        title: {
            text: 'Análisis de datos',
            x: -20 //center
        },
        subtitle: {
            text: 'Fuente: Idoctore.com',
            x: -20
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            title: {
                text: 'Unidades'
            },
            plotLines: [{
                value: 0,
                width: 600,
                color: '#fff'
            }]
        },
        tooltip: {
            valueSuffix: 'unidades'
        },
        legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
        },
        series: [{
            name: 'Peso',
            data: weight
        }, {
            name: 'Presión Diastolica',
            data: diastolica
        }, {
            name: 'Presión Sistólica',
            data: sistolica
        }, {
            name: 'Temperatura',
            data: temperature
        },{
            name: 'Estatura',
            data: height }]
    });
});
