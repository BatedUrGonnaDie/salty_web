$(function () {
    window.create_textutil = function(util) {
        if (util["text"] != "") {
            $.ajax({
                url: "/api/users/" + util["user"] + "/" + util["type"],
                type: "POST",
                data: "&text=" + encodeURIComponent(util["text"]) + "&reviewed=1",
                error: function(response) {
                    console.log("Creatoin of util failed with response: " + JSON.stringify(response));
                }
            });
        };
    };
});
