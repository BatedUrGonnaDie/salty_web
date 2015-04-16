$(function () {
    window.create_textutil = function(util) {
        if (util["text"] != "") {
            $.ajax({
                url: "/api/users/" + util["user"] + "/" + util["type"],
                type: "POST",
                data: "&text=" + encodeURIComponent(util["text"]) + "&reviewed=1",
                success: function(response) {
                    var type_single = util["type"].substring(0, util["type"].length - 1);
                    $("#new_" + util["type"] + "_input").val("");
                    var input_stuff = "<div id='" + util["type"] + "-" + response[type_single]["id"] + "'class='pure-u-1-2'>";
                    input_stuff += "<div class='textutil'>"
                    input_stuff += "<input type='text' value='" + util["text"] + "' />";
                    input_stuff += "</div></div>"
                    $("#" + util["type"] + "-form").append(input_stuff);
                    console.log(input_stuff);
                },
                error: function(response) {
                    console.log("Creatoin of util failed with response: " + JSON.stringify(response));
                }
            });
        };
    };
});
