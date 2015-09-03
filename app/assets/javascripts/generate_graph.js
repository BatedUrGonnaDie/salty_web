$(function () {
    window.generate_graph = function() {
        run_id = $("#splits-run-id").val();
        if (run_id != "") {
            $("#chart").fadeOut(200, function() {
                $(this).empty().show();
                if (sessionStorage.getItem(run_id)) {
                    response = JSON.parse(sessionStorage.getItem(run_id));
                    console.log(response);
                    add_basic(response.run);
                    add_splits(response.run.splits, "PB vs. Golds", false);
                    if (response.run.program == "livesplit") {
                        add_splits(response.run.splits, "History Mean vs. Golds", true);
                    };
                };
            });
            if (!sessionStorage.getItem(run_id)) {
                $.ajax({
                    url: "https://splits.io/api/v3/runs/" + run_id,
                    type: "GET",
                    crossDomain: true,
                    success: function(response) {
                        sessionStorage.setItem(run_id, JSON.stringify(response));
                        add_basic(response.run);
                        add_splits(response.run.splits, "PB vs. Golds", false);
                        if (response.run.program == "livesplit") {
                            add_splits(response.run.splits, "History Mean vs. Golds", true);
                        };
                    },
                    error: function(response) {
                        console.log(response);
                    }
                })
            };
        } else {
            // red required
        };
    };
});

var add_basic = function(run) {

}

var add_splits = function(splits, graph_title, with_history) {
    var splits_small = []
    splits.forEach(function(d) {
        if (with_history) {
            var split = validate_history(d);
        } else {
            var split = validate_split(d);
        }
        if (split) { splits_small.push(split)};
    });
    if (splits_small.length === 0) { return; };

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
    svg.append("text")
       .attr("x", width / 2)
       .attr("y", 0 - margin.top / 2)
       .attr("text-anchor", "middle")
       .style("font-size", "16px")
       .style("text-decoration", "underline")
       .text(graph_title);

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
};

var validate_split = function(split) {
    if (split.gold || split.skipped) {
        return false;
    } else if (split.duration - split.best.duration < Number($("#min-bar-time").val())) {
        return false;
    } else {
        return {name: split.name, value: Math.round((split.duration - split.best.duration) * 100) / 100}
    };
};

var validate_history = function(split) {
    if (split.history.length === 0) { return false; };
    split.history = split.history.filter(function(d) { if (d == 0) { return false; } return true; });
    var mean = d3.mean(split.history);
    if (mean - split.best.duration < Number($("#min-bar-time").val())) { return false; };
    return {name: split.name, value: Math.round((mean - split.best.duration) * 100) / 100};
};

var export_to_png = function() {
    var html = d3.select("svg").attr("version", 1.1).attr("xmlns", "http://www.w3.org/2000/svg").node().parentNode.innerHTML;
    var imgsrc = "data:image/svg+xml;base64," + btoa(html);
    var img = '<img src="' + imgsrc +'">';
    var canvas = document.querySelector("canvas"),
        context = canvas.getContext("2d");

    var image = new Image;
    image.src = imgsrc;
    image.onload = function() {
        context.drawImage(image, 0, 0);
        var canvasdata = canvas.toDataURL("image/png");
        var pngimg = '<img src="' + canvasdata + '">';
        d3.select("#pngdataurl").html(pngimg);
        var a = document.createElement("a");
        a.download = "sample.png";
        a.href = canvasdata;
        document.body.appendChild(a);
        a.click();
    }
}
