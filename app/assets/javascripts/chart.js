var leeway = 0.68,
  defaultColors = [
    '#ff0000',
    '#0000ff',
    '#00ff00',
    '#ffff00',
    '#00ffff',
    '#000000'
  ],
  defaultOptions = {
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
        enabled: true
      },
      title: {
          text: null
      },
      subtitle: {
        text: null
      },
      xAxis: {
          type: 'datetime',
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
        },
        marker: {
          symbol: 'circle'
        }
      }
  };

function initChart (userId) {
  window.userId = userId;
  if (window.data === undefined) {
    $.getJSON('/api/events?user_id=' + userId)
      .done(function (data) {
        renderChart(data.events);
      })
      .fail(console.log);
  } else {
    renderChart(window.data);
  }
}

function renderChart (data) {
  var colorIndex = 0,
  options = {},
  series = _.chain(data)
  .sortBy('name')
  .groupBy('name')
  .map(function (group, key, foo) {
    var color = defaultColors[colorIndex];
    colorIndex = (colorIndex + 1) % defaultColors.length;
    return {
      name: key,
      color: color,
      marker: { symbol: 'circle' },
      data: _.map(group, function (item) {
        return itemAsChartObject(item);
      })
    };
  })
  .value(),
  categories = _.map(data, function (item) {
    return timestampToDate(item.timestamp)
  }).reverse();

  setCurrentValues(series);

  options = defaultOptions;
  options.series = series;
  options.xAxis.categories = categories;

  $('#chart').highcharts(options);
}

function itemAsChartObject (item) {
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

function setCurrentValues(series) {
  var list = $(".current-values");
  _.each(series, function (item) {
    var value = (item.data[item.data.length - 1]).y;
    $("<li>" + item.name + ": " + value + "&deg;C</li>").appendTo(list);
  });
}

function setLatest(item) {
  var value = item.temperature + leeway;
  $("#latest").html(value.toFixed(1).replace(".", ","));
}

function updateData(series) {
  var hasElements = series.data.length > 0,
    timestamp,
    startDate,
    query = '?user_id=' + userId;

  if (hasElements) {
    timestamp = series.data[series.data.length - 1].timestamp + 1;
    if (isNaN(timestamp)) {
      return;
    }
    startDate = new Date(timestamp);
    query += '&from=' + encodeURI(startDate.toUTCString());
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
