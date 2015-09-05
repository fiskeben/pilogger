var leeway = 0.68;

$(document).ready(function () {
  var series = {
    name: 'Temperatur',
    data: _.map(data, function (item) {
      return itemAsChartObject(item);
    }).reverse(),
  },
  categories = _.map(data, function (item) {
    return timestampToDate(item.timestamp)
  });

  $('#chart').highcharts(
    {
        chart: {
            type: 'line',
            events: {
              load: function () {
                var series = this.series[0];
                setInterval(function () {
                  updateData(series);
                }, 10000);
              }
            }
        },
        credits: {
          enabled: false
        },
        legend: {
          enabled: false
        },
        title: {
            text: null //'Temperaturer'
        },
        subtitle: {
          text: null //'Utviklingen det siste døgnet'
        },
        xAxis: {
            type: 'datetime',
            categories: categories,
            tickInterval: 8,
            labels: {
              formatter: function () {
                return formatTime(this.value);
              }
            }
        },
        yAxis: {
            title: {
                useHTML: true,
                text: null
            },
            labels: {
              useHTML: true,
              formatter: function () { return this.value.toFixed(1) + "&deg;"; }
            }
        },
        plotOptions: {
          spline: {
            animation: false
          }
        },
        series: window.data
    }
  );
});

function itemAsChartObject (item) {
  console.log('creating obj', item);
  return {
    name: timestampToDate(item.timestamp),
    id: item.id,
    y: item.value + leeway,
    timestamp: item.timestamp
  }
}

function timestampToDate (timestamp) {
  return new Date(timestamp);
}

function formatTime (date) {
  var hours = date.getHours().toString(),
    minutes = date.getMinutes().toString();
  return prependZero(hours) + ":" + prependZero(minutes);
}

function prependZero (value) {
  return (value.length === 1) ? "0" + value : value;
}

function setLatest(item) {
  var value = item.temperature + leeway;
  $("#latest").html(value.toFixed(1).replace(".", ","));
}

function updateData(series) {
  var hasElements = series.data.length > 0,
    startDate,
    query = '';

  if (hasElements) {
    console.log(series);
    startDate = new Date(series.data[series.data.length - 1].timestamp + 1);
    query = '?from=' + encodeURI(startDate.toUTCString());
  }

  $.getJSON('/api/events' + query, function (data) {
    _.forEach(data, function (item) {
      series.addPoint(itemAsChartObject(item), true, hasElements);
    });
    if (data.length > 0) {
      setLatest(data[0])
    }
  });
}
