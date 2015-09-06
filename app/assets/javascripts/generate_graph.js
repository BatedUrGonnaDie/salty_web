$(function () {
    window.generate_graph = function() {
        var run_id = $("#splits-run-id").val();
        if (run_id != "") {
            $("#graph-progress").removeClass("progress-bar-danger");
            update_progress("0", "Fetching run...");
            $("#graph-progress").removeClass("")
            $("#chart").fadeOut(200, function() {
                $(this).empty().show();
                var run = sessionStorage.getItem(run_id);
                if (run) {
                    update_progress(50, "Parsing splits...")
                    graph_init(JSON.parse(run));
                } else {
                    $.ajax({
                        url: "https://splits.io/api/v3/runs/" + run_id,
                        type: "GET",
                        crossDomain: true,
                        success: function(response) {
                            sessionStorage.setItem(run_id, JSON.stringify(response));
                            update_progress(50, "Parsing splits...")
                            graph_init(response);
                            console.log(response);
                        },
                        error: function(response) {
                            update_progress(100, "Error retrieving splits (Status: " + response.status + ")");
                            $("#graph-progress").addClass("progress-bar-danger");
                        }
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

var graph_init = function(response) {
    add_basic(response.run);
    // Parse stringify to make copies of the objects and not destory them
    add_splits(JSON.parse(JSON.stringify(response.run.splits)), "PB vs. Golds", false);
    if (response.run.program.toLowerCase() === "livesplit") {
        add_splits(JSON.parse(JSON.stringify(response.run.splits)), "Split History " + $("#history-compare-type").val() + " vs. Golds", true);
    };
};

var add_basic = function(run) {

};

var add_splits = function(splits, graph_title, with_history) {
    var splits_small = []
    if (with_history) {
        splits.forEach(function(d) {
            var split = validate_history(d);
            if (split) { splits_small.push(split); };
            update_progress(50 + (30 / splits.length));
        });
    } else {
        splits_small = condense_splits(splits);
    };
    if (splits_small.length === 0) { return; };
    update_progress(80, "Creating graphs...");

    var margin = {top: 30, right: 30, bottom: 120, left: 60},
        width = $("#chart").width() - margin.left - margin.right,
        height = 500 - margin.top - margin.bottom;

    var x = d3.scale
              .ordinal()
              .rangeRoundBands([0, width], .1);
    var y = d3.scale
              .linear()
              .range([height, 0]);

    var xAxis = d3.svg
                  .axis()
                  .scale(x)
                  .orient("bottom")
                  .tickSize(6, 0, 0);
    var yAxis = d3.svg
                  .axis()
                  .scale(y)
                  .orient("left")
                  .ticks(10)
                  .tickFormat(function(d) { return d + "s"; })
                  .tickSize(-width, 0, 0);

    var svg = d3.select("#chart")
                .append("svg")
                .attr("width", width + margin.left + margin.right)
                .attr("height", height + margin.top + margin.bottom)
                .append("g")
                .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    x.domain(splits_small.map(function(d) { return d.name; }));
    y.domain([0, d3.max(splits_small, function(d) { return d.value; })]);

    svg.append("g")
       .attr("class", "x axis")
       .attr("transform", "translate(0," + height + ")")
       .call(xAxis)
       .selectAll("text")
       .style("text-anchor", "end")
       .attr("dx", "-.8em")
       .attr("dy", ".15em")
       .attr("transform", "rotate(-45)");
    update_progress(85);

    svg.append("g")
       .attr("class", "y axis")
       .call(yAxis)
       .append("text")
       .attr("transform", "rotate(-90)")
       .attr("y", 0 - margin.left)
       .attr("x", 0 - height / 2)
       .attr("dy", "1em")
       .style("text-anchor", "middle")
       .text("Possible Time Save");
    update_progress(90);

    svg.append("text")
       .attr("x", width / 2)
       .attr("y", 0 - margin.top / 2)
       .attr("text-anchor", "middle")
       .style("font-size", "16px")
       .style("text-decoration", "underline")
       .text(graph_title);
    update_progress(95);

    svg.selectAll("bar")
       .data(splits_small)
       .enter()
       .append("rect")
       .attr("class", "bar")
       .attr("x", function(d) { return x(d.name); })
       .attr("width", x.rangeBand())
       .attr("y", function(d) { return y(d.value); })
       .attr("height", function(d) { return height - y(d.value); })
       .attr("fill", $("#bar-fill-color").val())
       .append("title")
       .attr("class", "bar-text")
       .text(function(d) { return d.value + " seconds"; });
       update_progress(100, "Ready");
};

var condense_splits = function(splits) {
    var reduced_splits = []
    for (var i = 0, length = splits.length; i < length; ++i) {
        if (splits[i].skipped) {
            if (i + 1 < length) {
                splits[i+1].best.duration += splits[i].best.duration;
                splits[i+1].name = splits[i].name + " + " + splits[i+1].name;
            } else {
                splits.pop();
            };
            update_progress(50 + (15 / splits.length));
        };
    };
    for (var i = 0, length = splits.length; i < length; ++i) {
        if (splits[i].skipped) { continue; };
        var cmp_time = splits[i].duration - splits[i].best.duration;
        if (cmp_time > Number($("#min-bar-time").val())) {
            reduced_splits.push({name: splits[i].name, value: Math.round((cmp_time) * 100) / 100});
        };
        update_progress(50 + (15 / splits.length));
    };
    return reduced_splits;
}

var validate_history = function(split) {
    if (split.history === null || split.history.length === 0) { return false; };

    var cmp_type = $("#history-compare-type").val();
    if (cmp_type === "Mean/Average") {
        var min_cap = split.best.duration * .2,
            max_cap = split.best.duration * 1.8;
        split.history = split.history.filter(function(d) {
            if (d == 0) { return false; }
            else if (d > max_cap || d < min_cap) { return false; };
            return true;
        });
        var mean = d3.mean(split.history);
        if (mean - split.best.duration < Number($("#min-bar-time").val())) { return false; };
        return {name: split.name, value: Math.round((mean - split.best.duration) * 100) / 100};
    } else if (cmp_type === "Median") {
        var median = d3.median(split.history);
        if (median - split.best.duration < Number($("#min-bar-time").val())) { return false; };
        return {name: split.name, value: Math.round((median - split.best.duration) * 100) / 100};
    };
};
