$(function () {
    window.generate_graph = function() {
        var run_id = $("#splits-run-id").val();
        if (run_id != "") {
            $("#graph-progress").removeClass("progress-bar-danger");
            update_progress("0", "Fetching run...");
            $("#graph-progress").removeClass("")
            $("#info-table").add("#chart-container").fadeOut(200).promise().done(function() {
                $("#info-table").empty().show();
                $(this).children().each(function() {$(this).empty().show(); })
                $(this).show()
                var run = JSON.parse(sessionStorage.getItem(run_id));

                if (run) {
                  update_progress(50, "Parsing splits...");
                  add_basic(run);
                  add_splits(run.splits);
                  add_history(run);
                  add_resets(run);
                } else {
                  var info_call = $.ajax({
                    url: "https://splits.io/api/v4/runs/" + run_id + "?historic=1",
                    type: "GET",
                    crossDomain: true
                  });
                  var splits_call = $.ajax({
                    url: "https://splits.io/api/v4/runs/" + run_id + "/splits?historic=1",
                    type: "GET",
                    crossDomain: true
                  });
                  $.when(info_call, splits_call).then(function(run_info, splits) {
                    if (run_info[1] === "success" && splits[1] === "success") {
                      update_progress(50, "Parsing splits...");
                      run_info[0].splits = splits[0];
                      sessionStorage.setItem(run_id, JSON.stringify(run_info[0]));
                      add_basic(run_info[0]);
                      add_splits(run_info[0].splits);
                      add_history(run_info[0]);
                      add_resets(run_info[0]);
                    } else {
                      $("#graph-progress").addClass("progress-bar-danger");
                      update_progress(100, "Error retirving splits (history too long most likely");
                    };
                  });
                };
            });

        } else {
            // red required
        };
    };
});

var update_progress = function(percentage, new_text) {
    var bar = $("#graph-progress");
    bar.attr("style", "mid-width: 2em; width: " + percentage + "%;");
    bar.attr("aria-valuenow", percentage + "%");
    if (new_text) {
        bar.text(new_text);
    };
};

var add_basic = function(run) {
    var runner_names = [];
    for (var i = 0; i < run.runners.length; ++i) {
        runner_names.push(run.runners[i].name);
    }
    var table = "" +
    "<table class='table table-striped table-condensed'>" +
      "<caption>Run Information</caption>" +
      "<tr>" +
        "<th>Run Name</th><th>Attempts</th><th>Completed Runs</th><th>Program</th><th>Runners</th>" +
      "</tr>" +
      "<tr>" +
        "<td>"+run.name+"</td><td>"+run.attempts+"</td><td>"+(run.history.length + 1)+" (" +
        (Math.round(((run.history.length + 1) / run.attempts) * 100) / 100)+"%)</td><td>"+run.program+"</td>" +
        "<td>"+runner_names.join(", ")+"</td>" +
      "</tr>" +
    "</table>"
    $("#info-table").append(table);
};

var add_history = function(run) {
  var duration_title = "Run Duration Over Time";
  var duration = run.history.map(function(d) {return d; });
  duration.unshift("Run Length");
  var duration_ticks = new Array(run.history.length);
  for (var i = 1; i < duration.length; ++i) {
    duration_ticks[i - 1] = i;
  };
  var chart3 = c3.generate({
    bindto: "#chart3",
    title: {
      text: duration_title
    },
    data: {
      columns: [duration],
      color: function(d, i) { return $("#bar-fill-color").val(); }
    },
    axis: {
      x: {
        type: "category",
        categories: duration_ticks
      },
      y: {
        label: {
          text: "Duration of Run",
          position: "outer-middle"
        },
        tick: {
          format: time_formatter
        }
      }
    },
    legend: {
      hide: true
    }
  });
};

var add_resets = function(run) {
  var reset_data = [];
  var counter = run.attempts;
  run.splits.forEach(function(d) {
    reset_data.push([d.name, counter - d.history.length]);
    counter = d.history.length;
  });
  var chart4 = c3.generate({
    bindto: "#chart4",
    title: {
      text: "Resets/Split"
    },
    data: {
      columns: reset_data,
      type: "donut"
    },
    donut: {
      title: "Resets/Level",
      label: {
        format: function(v) { return v; }
      }
    }
  });
};

var add_splits = function(splits) {
  var pb = ["PB - Gold"];
  var pb_title = "PB vs Golds";
  var pb_ticks = [];
  var small_pb = condense_pb(JSON.parse(JSON.stringify(splits)));
  small_pb.forEach(function(d) {
    pb.push(d.value);
    pb_ticks.push(d.name);
  });

  var history_title = "Split History " + $("#history-compare-type").val() + "vs Golds";
  var history = [$("#history-compare-type").val() + " - Gold"];
  var history_ticks = [];
  splits.forEach(function(d) {
    var split = validate_history(d);
    if (split) {
      history.push(split.value);
      history_ticks.push(split.name);
    };
  });

  update_progress(80, "Creating graphs...");
  var chart = c3.generate({
    bindto: "#chart",
    title: {
      text: pb_title
    },
    data: {
      columns: [pb],
      type: "bar",
      color: function(d, i) { return $("#bar-fill-color").val(); }
    },
    axis: {
      x: {
        type: 'category',
        categories: pb_ticks,
        tick: {
          rotate: -45,
          multiline: false
        },
        height: 80
      },
      y: {
        label: {
          text: "Possible Time Save",
          position: "outer-middle"
        },
        tick: {
          format: function(d) { return d + "s"; }
        }
      },
    },
    legend: {
      hide: true
    }
  });

  var chart2 = c3.generate({
    bindto: "#chart2",
    title: {
      text: history_title
    },
    data: {
      columns: [history],
      type: "bar",
      color: function(d, i) { return $("#bar-fill-color").val(); }
    },
    axis: {
      x: {
        type: "category",
        categories: history_ticks,
        tick: {
          rotate: -45,
          multiline: false
        },
        height: 80
      },
      y: {
        label: {
          text: "Possible Time Save",
          position: "outer-middle"
        },
        tick: {
          format: function(d) { return d + "s"; }
        }
      }
    },
    legend: {
      hide: true
    }
  });

  update_progress(100, "All Done!");
};

var condense_pb = function(splits) {
  var reduced_splits = [];
  for (var i = 0, length = splits.length; i < length; ++i) {
    if (splits[i].skipped) {
      if (i < length) {
        splits[i + 1].best += splits[i].best;
        splits[i + 1].duration += splits[i].duration;
        splits[i + 1].name = splits[i].name + " + " + splits[i + 1].name;
      };
      continue;
    };
    var cmp_time = splits[i].duration - splits[i].best;
    if (cmp_time > Number($("#min-bar-time").val())) {
      reduced_splits.push({name: splits[i].name, value: round_two(cmp_time)});
    }
  };
  return reduced_splits;
}

var validate_history = function(split) {
    if (split.history === null || split.history.length === 0) { return false; };

    var cmp_type = $("#history-compare-type").val();
    if (cmp_type === "Mean/Average") {
        if ($("#remove-mean-outliers").val()) {
          var min_cap = split.best * .2,
              max_cap = split.best * 1.8;
          split.history = split.history.filter(function(d) {
              if (d == 0) { return false; }
              else if (d > max_cap || d < min_cap) { return false; };
              return true;
          });
        };
        var mean = d3.mean(split.history);
        if (mean - split.best < Number($("#min-bar-time").val())) { return false; };
        return {name: split.name, value: round_two(mean - split.best)};
    } else if (cmp_type === "Median") {
        var median = d3.median(split.history);
        if (median - split.best < Number($("#min-bar-time").val())) { return false; };
        return {name: split.name, value: round_two(median - split.best)};
    };
};

var round_two = function(num) {
  return Math.round((num) * 100) / 100;
}

var time_formatter = function(x) {
  var minutes = x / 60;
  var hours = Math.floor(minutes / 60);
  minutes = Math.floor(minutes % 60);
  var seconds = Math.floor(x % 60);
  if (minutes < 10) { minutes = "0" + minutes; };
  if (seconds < 10) { seconds = "0" + seconds; };

  var output = hours + ":" + minutes + ":" + seconds;
  return output;
}
